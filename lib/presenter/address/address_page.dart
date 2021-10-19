import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:google_maps_flutter_web/google_maps_flutter_web.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({Key? key}) : super(key: key);

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  final Completer<GoogleMapController> _mapController = Completer();
  final Map<MarkerId, Marker> _markers = {};
  int _markerIdCounter = 0;

  LatLng _initialPosition = LatLng(-12.046374, -77.042793);

  void _addMarker(LatLng location, MarkerId markerId) {
    setState(() {
      _markers[markerId] = (Marker(
        markerId: markerId,
        position: _initialPosition,
        draggable: false,
      ));
    });
  }

  void _getUserLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position currentPosition = await Geolocator.getCurrentPosition();

    setState(() {
      _initialPosition =
          LatLng(currentPosition.latitude, currentPosition.longitude);
      // _locationController.text = placemark[0].name!;
    });

    MarkerId markerId = MarkerId(_markerIdVal());

    _addMarker(_initialPosition, markerId);

    Future.delayed(const Duration(milliseconds: 50), () async {
      GoogleMapController controller = await _mapController.future;
      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: _initialPosition,
            zoom: 17.0,
          ),
        ),
      );
    });
  }

  String _markerIdVal({bool increment = false}) {
    String val = 'marker_id_$_markerIdCounter';
    if (increment) _markerIdCounter++;
    return val;
  }

  void _onCameraMove(CameraPosition position) {
    MarkerId markerId = MarkerId(_markerIdVal());
    Marker marker = _markers[markerId]!;
    Marker updatedMarker = marker.copyWith(positionParam: position.target);

    setState(() {
      _markers[markerId] = updatedMarker;
    });

    print(_markers);
    print(_markers.length);
  }

  @override
  void initState() {
    _getUserLocation();
    super.initState();
  }

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
                mapType: MapType.normal,
                initialCameraPosition:
                    CameraPosition(target: _initialPosition, zoom: 17.0),
                onCameraMove: _onCameraMove,
                onMapCreated: (controller) =>
                    _mapController.complete(controller),
                markers: Set.of(_markers.values),
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
}
