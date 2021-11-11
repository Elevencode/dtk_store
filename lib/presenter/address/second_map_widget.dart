import 'dart:async';

import 'package:dtk_store/model/driver.dart';
import 'package:dtk_store/model/order.dart';
import 'package:dtk_store/presenter/address/cubit/map_widget_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
// import 'package:google_maps_flutter_web/google_maps_flutter_web.dart';

class SecondMapWidget extends StatefulWidget {
  const SecondMapWidget({
    Key? key,
    required this.order,
  }) : super(key: key);

  final Order order;

  @override
  State<SecondMapWidget> createState() => _SecondMapWidgetState();
}

class _SecondMapWidgetState extends State<SecondMapWidget> {
  //TODO: пофиксить на настоящие данные
  LatLng _driverCoords = const LatLng(-12.046374, -77.042793);

  late GoogleMapController _mapController;

  late BitmapDescriptor _driverIcon;

  late BitmapDescriptor _orderIcon;

  Set<Marker> _markers = {};

  Set<Polyline> _polyline = {};

  List<LatLng> _polylineCoords = [];

  PolylinePoints _polylinePoints = PolylinePoints();

  late CameraPosition _initialCameraPosition;

  LocationData? _locationData;

  @override
  void initState() {
    super.initState();
    _getIcons().then((value) => _init());

    _setupLocation();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AdressCubit, AdressState>(
      listener: (context, state) {
        if (state is AdressLoadSuccess) {
          BlocProvider.of<AdressCubit>(context).getDriver(widget.order.shortCode, widget.order.client.phone, DateTime.now());
          //TODO: driver coords
          Driver driver = state.driver!;
          _driverCoords = LatLng(driver.lat, driver.lng);
          print(driver);
        }
      },
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                GoogleMap(
                  markers: _markers,
                  mapType: MapType.normal,
                  initialCameraPosition: _initialCameraPosition,
                  onMapCreated: (controller) => setState(
                    () => _mapController = controller,
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
      ),
    );
  }

  Future<void> _init() async {
    _markers.clear();

    _polyline.clear();

    await _setPolylines();
    await _getMarkers();
  }

  Future<void> _getMarkers() async {
    setState(
      () {
        _markers.add(
          Marker(
            markerId: MarkerId(_driverCoords.toString()),
            position: _driverCoords,
            icon: _driverIcon,
          ),
        );

        _markers.add(
          Marker(
            markerId: MarkerId(
              "${_locationData!.latitude!}${_locationData!.longitude!}",
            ),
            position: LatLng(
              _locationData!.latitude!,
              _locationData!.longitude!,
            ), //position of marker
            icon: _orderIcon,
          ),
        );
      },
    );
  }

  Future<void> _getIcons() async {
    _driverIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      "assets/driver-icon.png",
    );
    _orderIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      "assets/order-icon.png",
    );
  }

  Future<void> _setPolylines() async {
    PolylineResult result = await _polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyDK6a99pqYap3FeLbJ2m0rwnsGEb9qIpts",
      PointLatLng(
        _driverCoords.latitude,
        _driverCoords.longitude,
      ),
      PointLatLng(
        _locationData!.latitude!,
        _locationData!.longitude!,
      ),
    );

    if (result.status == "OK") {
      _polylineCoords.clear();

      setState(() {
        _polyline = result.points.map(
          (PointLatLng point) {
            _polylineCoords.add(LatLng(point.latitude, point.longitude));

            return Polyline(
              width: 7,
              polylineId: const PolylineId("polyline"),
              points: _polylineCoords,
              color: Theme.of(context).primaryColor,
            );
          },
        ).toSet();
      });
    }
  }

  void _setupLocation() async {
    Location location = Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();

    if (_locationData != null) {
      setState(() {
        _initialCameraPosition = CameraPosition(
          target: LatLng(_locationData!.latitude!, _locationData!.longitude!),
          zoom: 17.0,
        );

        _driverCoords = LatLng(
          _locationData!.latitude!,
          _locationData!.longitude!,
        );
      });
    }
  }
}
