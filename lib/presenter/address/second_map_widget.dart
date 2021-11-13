import 'dart:async';

import 'package:dtk_store/model/order.dart';
import 'package:dtk_store/presenter/address/cubit/map_widget_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:open_route_service/open_route_service.dart';

class SecondMapWidget extends StatelessWidget {
  const SecondMapWidget({
    Key? key,
    required this.order,
  }) : super(key: key);

  final Order order;

  @override
  Widget build(BuildContext context) {
    //? TEST
    // BlocProvider.of<AdressCubit>(context).getDriver(
    //   "CBX-772-675",
    //   "+51986307179",
    //   DateTime.parse("2021-10-16T17:00:54+00:00"),
    // );
    //! PROD
    BlocProvider.of<AdressCubit>(context).getDriver(
      order.shortCode,
      order.client.phone,
      DateTime.now(),
    );
    return BlocBuilder<AdressCubit, AdressState>(builder: (context, state) {
      if (state is AdressLoadSuccess) {
        return SecondMapWidgetBody(
          order: order,
          driverCoords: LatLng(
            state.driver.lat,
            state.driver.lng,
          ),
        );
      }
      return const Text("Driver not founded");
    });
  }
}

class SecondMapWidgetBody extends StatefulWidget {
  const SecondMapWidgetBody({
    Key? key,
    required this.order,
    required this.driverCoords,
  }) : super(key: key);

  final Order order;
  final LatLng driverCoords;

  @override
  State<SecondMapWidgetBody> createState() => _SecondMapWidgetBodyState();
}

class _SecondMapWidgetBodyState extends State<SecondMapWidgetBody> {
  late LatLng _driverCoords;
  late LatLng _clientCoords;

  final OpenRouteService _polylineClient =
      OpenRouteService(apiKey: 'AIzaSyDK6a99pqYap3FeLbJ2m0rwnsGEb9qIpts');

  late GoogleMapController _mapController;

  late List<Coordinate> _routeCoordinates;

  late BitmapDescriptor _driverIcon;

  late BitmapDescriptor _orderIcon;

  Set<Marker> _markers = {};

  Set<Polyline> _polyline = {};

  List<LatLng> _polylineCoords = [];

  PolylinePoints _polylinePoints = PolylinePoints();

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
                polylines: _polyline,
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

    _polyline.clear();

    _setupLocation();

    // await _setPolylines();
    await _getMarkers();
  }

  Future<void> _getMarkers() async {
    setState(
      () {
        _markers.add(
          Marker(
            markerId: MarkerId("$_driverCoords"),
            position: _driverCoords,
            icon: _driverIcon,
          ),
        );

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

  // Future<bool> _updateMap() async {
  // await Future.delayed(const Duration(milliseconds: 400));

  // var controller = _mapController;

  // var region = await controller.getVisibleRegion();
  // if (region.southwest.latitude == 0.0) return false;

  // LatLng _southwest;
  // LatLng _northeast;

  // final _clientLatLng = LatLng(
  //   _clientCoords.latitude,
  //   _clientCoords.longitude,
  // );
  // final _driverLatLng = LatLng(
  //   _driverCoords.latitude,
  //   _driverCoords.longitude,
  // );

  // if (_clientLatLng.latitude <= _driverLatLng.latitude) {
  //   _southwest = _clientLatLng;
  //   _northeast = _driverLatLng;
  // } else {
  //   _southwest = _driverLatLng;
  //   _northeast = _clientLatLng;
  // }

  // CameraUpdate update = CameraUpdate.newLatLngBounds(
  //   LatLngBounds(
  //     southwest: _southwest,
  //     northeast: _northeast,
  //   ),
  //   70,
  // );

  // controller.moveCamera(update);

  // return true;
  // }ƒ

  Future<void> _getIcons() async {
    _driverIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(45, 45)),
      "assets/images/driver-icon.png",
    );

    _orderIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(45, 45)),
      "assets/images/order-icon.png",
    );
  }

  Future<void> _setPolylines() async {
    // _routeCoordinates = await _polylineClient.directionsRouteCoordsGet(
    //   startCoordinate: Coordinate(
    //     latitude: _driverCoords.latitude,
    //     longitude: _driverCoords.longitude,
    //   ),
    //   endCoordinate: Coordinate(
    //     latitude: _clientCoords.latitude,
    //     longitude: _clientCoords.longitude,
    //   ),
    // );

    // final List<LatLng> routePoints = _routeCoordinates
    //     .map((coordinate) => LatLng(coordinate.latitude, coordinate.longitude))
    //     .toList();

    // setState(
    //   () {
    //     _polyline.add(
    //       Polyline(
    //         polylineId: const PolylineId('route'),
    //         visible: true,
    //         points: routePoints,
    //         color: Colors.red,
    //         width: 4,
    //       ),
    //     );
    //   },
    // );

    // PolylineResult result = await _polylinePoints.getRouteBetweenCoordinates(
    //   "AIzaSyDK6a99pqYap3FeLbJ2m0rwnsGEb9qIpts",
    //   PointLatLng(
    //     _driverCoords.latitude,
    //     _driverCoords.longitude,
    //   ),
    //   PointLatLng(
    //     _clientCoords.latitude,
    //     _clientCoords.longitude,
    //   ),
    // );

    // if (result.status == "OK") {
    //   _polylineCoords.clear();

    //   setState(
    //     () {
    //       _polyline = result.points.map(
    //         (PointLatLng point) {
    //           _polylineCoords.add(LatLng(point.latitude, point.longitude));

    //           return Polyline(
    //             width: 7,
    //             polylineId: const PolylineId("polyline"),
    //             points: _polylineCoords,
    //             color: Theme.of(context).primaryColor,
    //           );
    //         },
    //       ).toSet();
    //     },
    //   );
    // }
  }

  void _setupLocation() {
    if (widget.order.client.address.lat != null &&
        widget.order.client.address.lng != null) {
      setState(
        () {
          _driverCoords = widget.driverCoords;

          _clientCoords = LatLng(
            widget.order.client.address.lat!,
            widget.order.client.address.lng!,
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
