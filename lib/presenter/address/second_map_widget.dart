import 'dart:async';

import 'package:dtk_store/model/order.dart';
import 'package:dtk_store/presenter/address/cubit/map_widget_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

class SecondMapWidget extends StatefulWidget {
  const SecondMapWidget({Key? key, required this.order}) : super(key: key);

  final Order order;

  @override
  State<SecondMapWidget> createState() => _SecondMapWidgetState();
}

class _SecondMapWidgetState extends State<SecondMapWidget> {
  bool _serviceEnabled = false;

  @override
  void initState() {
    BlocProvider.of<AddressCubit>(context).getDriver(
      widget.order.shortCode,
      widget.order.client.phone,
      DateTime.now(),
    );
    _checkLocationPermissions();
    super.initState();
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
                  child: const Text('Request permission'),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return BlocBuilder<AddressCubit, AddressState>(
      builder: (context, state) {
        if (state is AddressLoadSuccess) {
          return SecondMapWidgetBody(
            order: widget.order,
            serviceEnabled: _serviceEnabled,
            driverCoords: LatLng(
              state.driver.lat,
              state.driver.lng,
            ),
          );
        }
        return SecondMapWidgetBody(
          order: widget.order,
          serviceEnabled: _serviceEnabled,
        );
      },
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
      if (permission == LocationPermission.always || permission == LocationPermission.whileInUse) {
        setState(() => _serviceEnabled = true);
      }
    } else {
      setState(() => _serviceEnabled = true);
    }
  }
}

class SecondMapWidgetBody extends StatefulWidget {
  const SecondMapWidgetBody({
    Key? key,
    required this.order,
    required this.serviceEnabled,
    this.driverCoords,
  }) : super(key: key);

  final Order order;
  final bool serviceEnabled;
  final LatLng? driverCoords;

  @override
  State<SecondMapWidgetBody> createState() => _SecondMapWidgetBodyState();
}

class _SecondMapWidgetBodyState extends State<SecondMapWidgetBody> {
  late LatLng _driverCoords;

  late LatLng _clientCoords;

  late GoogleMapController _mapController;

  late BitmapDescriptor _driverIcon;

  late BitmapDescriptor _orderIcon;

  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _getIcons().then((_) => _init());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              GoogleMap(
                markers: _markers,
                myLocationEnabled: false,
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                    widget.order.client.address.lat!,
                    widget.order.client.address.lng!,
                  ),
                  zoom: 17.0,
                ),
                onMapCreated: _onMapCreated,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _init() async {
    _markers.clear();

    _setupLocation();

    await _getMarkers();
  }

  Future<void> _getMarkers() async {
    setState(
      () {
        if (widget.driverCoords != null) {
          _markers.add(
            Marker(
              markerId: MarkerId("$_driverCoords"),
              position: _driverCoords,
              icon: _driverIcon,
            ),
          );
        }

        _markers.add(
          Marker(
            markerId: MarkerId("$_clientCoords"),
            position: LatLng(
              _clientCoords.latitude,
              _clientCoords.longitude,
            ), //position of marker
            icon: _orderIcon,
          ),
        );
      },
    );
  }

  Future<void> _getIcons() async {
    if (widget.driverCoords != null) {
      _driverIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(45, 45)),
        "assets/images/driver-icon.png",
      );
    }

    _orderIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(45, 45)),
      "assets/images/order-icon.png",
    );
  }

  Future<void> _setupLocation() async {
    if (widget.order.client.address.lat != null && widget.order.client.address.lng != null) {
      setState(
        () {
          if (widget.driverCoords != null) {
            _driverCoords = widget.driverCoords!;
          }

          _clientCoords = LatLng(
            widget.order.client.address.lat!,
            widget.order.client.address.lng!,
          );
        },
      );
    } else if (widget.order.client.address.lat == null && !widget.serviceEnabled ||
        widget.order.client.address.lng == null && !widget.serviceEnabled) {
      final places = GoogleMapsPlaces(apiKey: "AIzaSyDK6a99pqYap3FeLbJ2m0rwnsGEb9qIpts");

      var districtName = widget.order.client.district.name;

      PlacesSearchResponse response = await places.searchByText("$districtName, Peru");

      setState(
        () {
          if (widget.driverCoords != null) {
            _driverCoords = widget.driverCoords!;
          }

          _clientCoords = LatLng(
            response.results.first.geometry!.location.lat,
            response.results.first.geometry!.location.lng,
          );
        },
      );
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;

    // _updateMap();
  }
}
