import 'dart:async';

import 'package:dtk_store/model/address.dart';
import 'package:dtk_store/model/driver.dart';
import 'package:dtk_store/model/order.dart';
import 'package:dtk_store/presenter/address/cubit/map_widget_cubit.dart';
import 'package:dtk_store/presenter/order/cubit/order_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class ClientCoordsPickerMap extends StatefulWidget {
  final Order order;
  final OrderCubit orderCubit;
  final void Function(LatLng coords) onCoordsChange;

  const ClientCoordsPickerMap(
      {Key? key, required this.order, required this.orderCubit, required this.onCoordsChange})
      : super(key: key);

  @override
  State<ClientCoordsPickerMap> createState() => _ClientCoordsPickerMapState();
}

class _ClientCoordsPickerMapState extends State<ClientCoordsPickerMap> {
  Location location = Location();
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  LocationData? _locationData;
  final Completer<GoogleMapController> _completer = Completer();
  GoogleMapController? _controller;
  final List<Marker> _markers = [];
  late CameraPosition _initialCameraPosition;

  @override
  void initState() {
    super.initState();

    setupLocation();
  }

  void setupLocation() async {
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
    _initialCameraPosition = CameraPosition(
      target: LatLng(_locationData!.latitude!, _locationData!.longitude!),
      zoom: 17.0,
    );
    setState(() {
      widget.onCoordsChange(_initialCameraPosition.target);
    });
  }

  @override
  Widget build(BuildContext context) {
    return _locationData == null
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : BlocBuilder<AdressCubit, AdressState>(
            builder: (context, state) {
              if (state is AdressLoadSuccess || state is AdressInitial) {
                return Column(
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
                                markerId: MarkerId('0'),
                                position:
                                    LatLng(_locationData!.latitude!, _locationData!.longitude!),
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
                                _markers.first =
                                    _markers.first.copyWith(positionParam: position.target);
                              });
                              widget.onCoordsChange(position.target);
                            },
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
              if (state is AdressLoading) {
                return const CircularProgressIndicator();
              } else {
                //TODO: Сделать виджет ошибки
                return Container();
              }
            },
          );
  }
}
