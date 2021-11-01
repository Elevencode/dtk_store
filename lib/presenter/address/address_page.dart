import 'dart:async';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:google_maps_flutter_web/google_maps_flutter_web.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({Key? key}) : super(key: key);

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  // final Completer<GoogleMapController> _mapController = Completer();
  // final Map<MarkerId, Marker> _markers = <MarkerId, Marker>{};

  // int _markerIdCounter = 0;

  final List<Marker> _markers = [];

  final CameraPosition _initialCameraPosition = const CameraPosition(
    target: LatLng(-12.046374, -77.042793),
    zoom: 17.0,
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
                },
                myLocationEnabled: true,
                // onCameraMove: ((_position) => _updatePosition(_position)),
                onCameraMove: (CameraPosition position) {
                  setState(() {
                    _markers.first =
                        _markers.first.copyWith(positionParam: position.target);
                  });
                  // if (_markers.isNotEmpty) {
                  // setState(() {
                  //     MarkerId markerId = MarkerId(_markerIdVal());
                  // Marker? marker = _markers[markerId];
                  // Marker updatedMarker = marker!.copyWith(
                  //   positionParam: position.target,
                  // );
                  //  _markers[markerId] = updatedMarker;
                  // });
                  // MarkerId markerId = MarkerId(_markerIdVal());
                  // Marker? marker = _markers[markerId];
                  // Marker updatedMarker = marker!.copyWith(
                  //   positionParam: position.target,
                  // );

                  // setState(() {
                  //   _markers[markerId] = updatedMarker;
                  // });
                  // }
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

  // void _updatePosition(CameraPosition _position) {
  //   var newMarkerPosition = {
  //     "latitude": _position.target.latitude,
  //     "longitude": _position.target.longitude
  //   };
  //   Marker marker = _markers[0];

  //   setState(() {
  //     _markers[0] = marker.copyWith(
  //         positionParam: LatLng(
  //             newMarkerPosition["latitude"]!, newMarkerPosition["longitude"]!));
  //   });
  // }

  // void _onMapCreated(GoogleMapController controller) async {
  //   _mapController.complete(controller);
  //   final LatLng position = LatLng(-12.046374, -77.042793);

  //   MarkerId markerId = MarkerId(_markerIdVal());
  //   Marker marker = Marker(
  //     markerId: markerId,
  //     position: position,
  //     draggable: false,
  //   );
  //   setState(() {
  //     _markers[markerId] = marker;
  //   });

  //   Future.delayed(const Duration(seconds: 1), () async {
  //     GoogleMapController controller = await _mapController.future;
  //     controller.animateCamera(
  //       CameraUpdate.newCameraPosition(
  //         CameraPosition(
  //           target: LatLng(position.latitude, position.longitude),
  //           zoom: 17.0,
  //         ),
  //       ),
  //     );
  //   });
  // }

  // String _markerIdVal({bool increment = false}) {
  //   String val = 'marker_id_$_markerIdCounter';
  //   if (increment) _markerIdCounter++;
  //   return val;
  // }
}
