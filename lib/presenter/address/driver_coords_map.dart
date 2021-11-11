import 'dart:async';

import 'package:dtk_store/model/order.dart';
import 'package:dtk_store/presenter/address/cubit/map_widget_cubit.dart';
import 'package:dtk_store/presenter/order/cubit/order_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class DriverCoordsMap extends StatefulWidget {
  final Order order;
  final OrderCubit orderCubit;

  const DriverCoordsMap(
      {Key? key, required this.order, required this.orderCubit})
      : super(key: key);

  @override
  State<DriverCoordsMap> createState() => _DriverCoordsMapState();
}

class _DriverCoordsMapState extends State<DriverCoordsMap> {
  final Completer<GoogleMapController> _completer = Completer();
  GoogleMapController? _controller;

  final List<Marker> _markers = [];

  late CameraPosition _initialCameraPosition;

  @override
  Widget build(BuildContext context) {
    _initialCameraPosition = CameraPosition(
        target: LatLng(
            widget.order.client.address.lat!, widget.order.client.address.lng!),
        zoom: 17.0);
    return BlocListener<AdressCubit, AdressState>(
      listener: (context, state) {
        if (state is AdressLoadSuccess) {
          widget.orderCubit.getOrder();
        }
      },
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                GoogleMap(
                  markers: _markers.toSet(),
                  mapType: MapType.normal,
                  initialCameraPosition: _initialCameraPosition,
                  onMapCreated: (controller) {
                    final marker = Marker(
                      // icon: BitmapDescriptor.fromAssetImage(configuration, assetName),
                      markerId: MarkerId('0'),
                      position: _initialCameraPosition.target,
                      visible: false,
                    );
                    _markers.add(marker);
                    _completer.complete(controller);
                    _controller = controller;
                  },
                  myLocationEnabled: true,
                  onCameraMove: (CameraPosition position) {
                    FocusScope.of(context).unfocus();
                    setState(() {
                      _markers.first = _markers.first
                          .copyWith(positionParam: position.target);
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
