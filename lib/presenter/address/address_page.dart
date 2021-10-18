import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:google_maps_flutter_web/google_maps_flutter_web.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({Key? key}) : super(key: key);

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  final Completer<GoogleMapController> _mapController = Completer();
  // Map<MarkerId, Marker> _markers = <MarkerId, Marker>{};
  final _markers = <Marker>[
    Marker(
      draggable: true,
      markerId: MarkerId("1"),
      position: LatLng(-12.046374, -77.042793),
    ),
  ];

  final CameraPosition _initialCameraPosition = const CameraPosition(
    target: LatLng(-12.046374, -77.042793),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  markers: Set<Marker>.of(_markers),
                  mapType: MapType.normal,
                  initialCameraPosition: _initialCameraPosition,
                  onMapCreated: _onMapCreated,
                  onCameraMove: ((_position) => _updatePosition(_position))),
              Positioned(
                bottom: 20,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: ElevatedButton(
                    onPressed: () {},
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
    );
  }

  void _updatePosition(CameraPosition _position) {
    var newMarkerPosition = {
      "latitude": _position.target.latitude,
      "longitude": _position.target.longitude
    };
    Marker marker = _markers[0];

    setState(() {
      _markers[0] = marker.copyWith(
          positionParam: LatLng(
              newMarkerPosition["latitude"]!, newMarkerPosition["longitude"]!));
    });
  }

  void _onMapCreated(GoogleMapController controller) async {
    _mapController.complete(controller);
    LatLng position = const LatLng(-12.046374, -77.042793);

    Future.delayed(Duration(seconds: 1), () async {
      GoogleMapController controller = await _mapController.future;
      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: position,
            zoom: 17.0,
          ),
        ),
      );
    });
  }
}
