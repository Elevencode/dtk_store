import 'dart:async';

import 'package:dtk_store/model/address.dart';
import 'package:dtk_store/model/order.dart';
import 'package:dtk_store/presenter/address/cubit/adress_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
// import 'package:google_maps_flutter_web/google_maps_flutter_web.dart';

class AddressPage extends StatefulWidget {
  final Order order;
  const AddressPage({Key? key, required this.order}) : super(key: key);

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  // final Completer<GoogleMapController> _mapController = Completer();
  // final Map<MarkerId, Marker> _markers = <MarkerId, Marker>{};
  final Location _location = Location();

  final Completer<GoogleMapController> _completer = Completer();
  GoogleMapController? _controller;

  // int _markerIdCounter = 0;

  final List<Marker> _markers = [];

  final CameraPosition _initialCameraPosition = const CameraPosition(
    target: LatLng(-12.046374, -77.042793),
    zoom: 17.0,
  );

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AdressCubit>(
      create: (context) => AdressCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "POR FAVOR AYUDANOS A ENCONTRAR\nTU UBICACION EXACTA",
            textAlign: TextAlign.center,
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Stack(children: [
                GoogleMap(
                  // markers: Set<Marker>.of(_markers.values),
                  markers: _markers.toSet(),
                  mapType: MapType.normal,
                  initialCameraPosition: _initialCameraPosition,
                  // onMapCreated: _onMapCreated,
                  onMapCreated: (controller) {
                    const marker = Marker(
                      markerId: MarkerId('0'),
                      position: LatLng(-12.046374, -77.042793),
                      visible: false,
                    );
                    _markers.add(marker);
                    _completer.complete(controller);
                    _controller = controller;
                  },
                  myLocationEnabled: true,
                  // onCameraMove: ((_position) => _updatePosition(_position)),
                  onCameraMove: (CameraPosition position) {
                    setState(() {
                      _markers.first = _markers.first
                          .copyWith(positionParam: position.target);
                    });
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
                Positioned(
                  bottom: 20,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: ElevatedButton(
                      onPressed: () {
                        final Address address = Address(
                          city: widget.order.client!.address!.city,
                          street: widget.order.client!.address!.street,
                          country: widget.order.client!.address!.country,
                          lat: _markers.first.position.latitude,
                          lng: _markers.first.position.longitude,
                        );
                        BlocProvider.of<AdressCubit>(context)
                            .updateAdress(address);
                      },
                      child: const Text(
                        'CONFIRMAR LA\nUBICACION EXACTA',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(50, 70),
                        primary: const Color(0XFF67C99C),
                      ),
                    ),
                  ),
                ),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: () {},
                child: const Text(
                  'LLAMA A MI ACCESOR',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(MediaQuery.of(context).size.width, 70),
                  primary: const Color(0XFF557EF1),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
