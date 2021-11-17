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
  late GoogleMapController _mapController;

  final CameraPosition _initialCameraPosition = const CameraPosition(
    target: LatLng(-12.046374, -77.042793),
    zoom: 17.0,
  );

  bool _serviceEnabled = false;

  late CameraPosition _position;

  @override
  void initState() {
    super.initState();
    _checkLocationPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: _initialCameraPosition,
                myLocationEnabled: false,
                onMapCreated: _onMapCreated,
                onCameraMove: (position) => _position = position,
                onCameraIdle: () {
                  print(_position.target);
                  widget.onCoordsChange(_position.target);
                },
              ),
              Align(
                alignment: Alignment.centerRight,
                child: CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.orange[400],
                  child: IconButton(
                    splashRadius: 1,
                    icon: const Icon(
                      Icons.location_searching,
                      color: Colors.white,
                    ),
                    onPressed: _serviceEnabled
                        ? _setCurrentCoords
                        : _checkLocationPermissions,
                  ),
                ),
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

  void _setCurrentCoords() async {
    if (_serviceEnabled) {
      var locationData = await Geolocator.getCurrentPosition();

      _mapController.moveCamera(
        CameraUpdate.newLatLngZoom(
          LatLng(
            locationData.latitude,
            locationData.longitude,
          ),
          17.0,
        ),
      );

      widget.onCoordsChange(
        LatLng(
          locationData.latitude,
          locationData.longitude,
        ),
      );
    }
  }

  void _setDistrictCameraPosition() async {
    final places =
        GoogleMapsPlaces(apiKey: "AIzaSyDK6a99pqYap3FeLbJ2m0rwnsGEb9qIpts");

    var districtName = widget.order.client.district.name;

    PlacesSearchResponse response =
        await places.searchByText("$districtName, Peru");

    _mapController.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(
            response.results.first.geometry!.location.lat,
            response.results.first.geometry!.location.lng,
          ),
          zoom: 17.0,
        ),
      ),
    );
  }

  void _checkLocationPermissions() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Future.error("Location service is disabled");
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse) {
        setState(() => _serviceEnabled = true);
      }
    } else {
      setState(() => _serviceEnabled = true);
    }
  }

  void _onMapCreated(controller) {
    _mapController = controller;

    _setDistrictCameraPosition();
  }
}
