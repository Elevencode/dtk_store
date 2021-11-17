import 'package:dtk_store/model/order.dart';
import 'package:dtk_store/presenter/order/cubit/order_cubit.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart'
    show GoogleMapsPlaces, PlacesSearchResponse;

class ClientCoordsPickerMap extends StatefulWidget {
  const ClientCoordsPickerMap({
    Key? key,
    required this.order,
    required this.orderCubit,
    required this.onCoordsChange,
  }) : super(key: key);

  final Order order;
  final OrderCubit orderCubit;
  final void Function(LatLng coords) onCoordsChange;

  @override
  State<ClientCoordsPickerMap> createState() => _ClientCoordsPickerMapState();
}

class _ClientCoordsPickerMapState extends State<ClientCoordsPickerMap> {
  final Set<Marker> _markers = {};

  late CameraPosition _initialCameraPosition;

  bool _serviceEnabled = false;

  @override
  void initState() {
    super.initState();
    _initialCameraPosition = const CameraPosition(
      target: LatLng(-12.046374, -77.042793),
      zoom: 17.0,
    );
    _checkLocationPermissions();
  }

  @override
  Widget build(BuildContext context) {
    if (!_serviceEnabled) {
      return SizedBox(
        width: 480,
        height: 400,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  title: Text(
                    'Has prohibido el acceso a tu ubicación.',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  subtitle: Text(
                    "Es necesario para identificar su ubicación y "
                    "entregar el producto a la dirección correcta lo antes posible.\n"
                    "Para continuar, habilite el seguimiento de ubicación "
                    "en la configuración de su navegador.",
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () => _checkLocationPermissions(),
                  child: const Text('Solicitar permiso'),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              GoogleMap(
                markers: _markers,
                mapType: MapType.normal,
                initialCameraPosition: _initialCameraPosition,
                onMapCreated: (controller) {
                  //TODO: понять как ожидать подгрузки стейта и после обновлять место
                  // Future.delayed(const Duration(seconds: 3));
                  // controller.animateCamera(
                  //   CameraUpdate.newLatLngZoom(
                  //     LatLng(
                  //       _initialCameraPosition.target.latitude,
                  //       _initialCameraPosition.target.longitude,
                  //     ),
                  //     17.0,
                  //   ),
                  // );
                },
                myLocationEnabled: false,
                onCameraMove: _onCameraMove,
                myLocationButtonEnabled: true,
              ),
              const Align(
                alignment: Alignment.center,
                child: Icon(
                  Icons.add_location,
                  size: 40.0,
                  color: Colors.purple,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _checkLocationPermissions() async {
    bool serviceEnabled;
    LocationPermission permission;
    Position locationData;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Future.error("Location service is disabled");
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse) {
        locationData = await Geolocator.getCurrentPosition();

        var marker = Marker(
          markerId: const MarkerId('0'),
          position: LatLng(locationData.latitude, locationData.longitude),
          visible: false,
        );

        setState(
          () {
            _markers.clear();
            _markers.add(marker);

            _initialCameraPosition = CameraPosition(
              target: LatLng(
                locationData.latitude,
                locationData.longitude,
              ),
              zoom: 17.0,
            );

            _serviceEnabled = true;
          },
        );

        widget.onCoordsChange(
          LatLng(
            locationData.latitude,
            locationData.longitude,
          ),
        );
      }
    } else {
      setState(() => _serviceEnabled = true);
    }
  }

  void _onCameraMove(CameraPosition position) {
    FocusScope.of(context).unfocus();
    setState(() {
      _markers.clear();
      _markers.add(
        Marker(
          markerId: const MarkerId('0'),
          position: LatLng(position.target.latitude, position.target.longitude),
          visible: false,
        ),
      );
    });
    widget.onCoordsChange(position.target);
  }

  // void _setupLocation() async {
  //   final places =
  //       GoogleMapsPlaces(apiKey: "AIzaSyDK6a99pqYap3FeLbJ2m0rwnsGEb9qIpts");

  //   var districtName = widget.order.client.district.name;

  //   PlacesSearchResponse response =
  //       await places.searchByText("$districtName, Peru");
  //   setState(() {
  //     _locationData = LatLng(
  //       response.results.first.geometry!.location.lat,
  //       response.results.first.geometry!.location.lng,
  //     );

  //     _initialCameraPosition = CameraPosition(
  //       target: LatLng(
  //         response.results.first.geometry!.location.lat,
  //         response.results.first.geometry!.location.lng,
  //       ),
  //       zoom: 17.0,
  //     );
  //   });
  //   widget.onCoordsChange(_initialCameraPosition.target);
  // }

}
