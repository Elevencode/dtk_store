import 'dart:async';

import 'package:dtk_store/model/order.dart';
import 'package:dtk_store/presenter/address/cubit/map_widget_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:open_route_service/open_route_service.dart';

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
  @override
  void initState() {
    BlocProvider.of<AdressCubit>(context).getDriver(
      widget.order.shortCode,
      widget.order.client.phone,
      DateTime.now(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdressCubit, AdressState>(builder: (context, state) {
      if (state is AdressLoadSuccess) {
        return SecondMapWidgetBody(
          order: widget.order,
          driverCoords: LatLng(
            state.driver.lat,
            state.driver.lng,
          ),
        );
      }
      return SecondMapWidgetBody(
        order: widget.order,
      );
    });
  }
}

class SecondMapWidgetBody extends StatefulWidget {
  const SecondMapWidgetBody({
    Key? key,
    required this.order,
    this.driverCoords,
  }) : super(key: key);

  final Order order;
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

  void _setupLocation() {
    // TODO?: Возможно стоит убрать проверку, ибо вызывается виджет только после получения координат
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
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;

    // _updateMap();
  }
}
