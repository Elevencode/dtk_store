import 'dart:async';

import 'package:dtk_store/model/order.dart';
import 'package:dtk_store/presenter/address/cubit/map_widget_cubit.dart';
import 'package:dtk_store/presenter/order/cubit/order_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
// import 'package:google_maps_flutter_web/google_maps_flutter_web.dart';

class MapWidgetConfirmedState extends StatefulWidget {
  final Order order;
  final OrderCubit orderCubit;

  const MapWidgetConfirmedState(
      {Key? key, required this.order, required this.orderCubit})
      : super(key: key);

  @override
  State<MapWidgetConfirmedState> createState() =>
      _MapWidgetConfirmedStateState();
}

class _MapWidgetConfirmedStateState extends State<MapWidgetConfirmedState> {
  // final Completer<GoogleMapController> _mapController = Completer();
  // final Map<MarkerId, Marker> _markers = <MarkerId, Marker>{};
  // Location location = Location();

  // late bool _serviceEnabled;
  // late PermissionStatus _permissionGranted;
  // LocationData? _locationData;

  final Completer<GoogleMapController> _completer = Completer();
  GoogleMapController? _controller;

  // int _markerIdCounter = 0;

  final List<Marker> _markers = [];

  late CameraPosition _initialCameraPosition;

  // @override
  // void initState() {
  //   setupLocation();
  //   super.initState();
  // }

  // void setupLocation() async {
  //   _serviceEnabled = await location.serviceEnabled();
  //   if (!_serviceEnabled) {
  //     _serviceEnabled = await location.requestService();
  //     if (!_serviceEnabled) {
  //       return;
  //     }
  //   }

  //   _permissionGranted = await location.hasPermission();
  //   if (_permissionGranted == PermissionStatus.denied) {
  //     _permissionGranted = await location.requestPermission();
  //     if (_permissionGranted != PermissionStatus.granted) {
  //       return;
  //     }
  //   }

  //   _locationData = await location.getLocation();
  //   _initialCameraPosition = CameraPosition(
  //     target: LatLng(_locationData!.latitude!, _locationData!.longitude!),
  //     zoom: 17.0,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    _initialCameraPosition = CameraPosition(
        target: LatLng(
            widget.order.client.address.lat!, widget.order.client.address.lng!),
        zoom: 17.0);
    return
        // _locationData == null
        //     ? const Center(
        //         child: CircularProgressIndicator(),
        //       ):
        BlocListener<AdressCubit, AdressState>(
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
                  // scrollGesturesEnabled: false,
                  // markers: Set<Marker>.of(_markers.values),
                  markers: _markers.toSet(),
                  mapType: MapType.normal,
                  initialCameraPosition: _initialCameraPosition,
                  // onMapCreated: _onMapCreated,
                  onMapCreated: (controller) {
                    final marker = Marker(
                      // icon: BitmapDescriptor.fromAssetImage(configuration, assetName),
                      markerId: MarkerId('0'),
                      position: _initialCameraPosition.target,
                      // LatLng(_locationData!.latitude!,
                      //     _locationData!.longitude!),
                      visible: false,
                    );
                    _markers.add(marker);
                    _completer.complete(controller);
                    _controller = controller;
                  },
                  myLocationEnabled: true,
                  // onCameraMove: ((_position) => _updatePosition(_position)),
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
