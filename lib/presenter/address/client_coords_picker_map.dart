import 'dart:convert';

import 'package:dtk_store/model/order.dart';
import 'package:dtk_store/presenter/order/cubit/order_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart'
    show GoogleMapsPlaces, PlacesSearchResponse;
import 'package:url_launcher/url_launcher.dart';

class ClientCoordsPickerMap extends StatefulWidget {
  const ClientCoordsPickerMap({
    Key? key,
    required this.order,
    required this.orderCubit,
    required this.onCoordsChange,
  }) : super(key: key);

  final Order order;
  final OrderCubit orderCubit;
  final void Function(LatLng coords) onCoordsChange;

  @override
  State<ClientCoordsPickerMap> createState() => _ClientCoordsPickerMapState();
}

enum ClientLocationPermissions {
  allowed,
  denied,
  deniedForever,
}

class _ClientCoordsPickerMapState extends State<ClientCoordsPickerMap> {
  late GoogleMapController _mapController;

  final CameraPosition _initialCameraPosition = const CameraPosition(
    target: LatLng(-12.046374, -77.042793),
    zoom: 17.0,
  );

  late ClientLocationPermissions _locationPermission;

  late CameraPosition _position;

  @override
  void initState() {
    super.initState();

    _locationPermission = ClientLocationPermissions.denied;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: _initialCameraPosition,
                myLocationButtonEnabled: true,
                myLocationEnabled: false,
                onMapCreated: _onMapCreated,
                onCameraMove: (position) => _position = position,
                onCameraIdle: () => widget.onCoordsChange(_position.target),
              ),
              Align(
                alignment: const Alignment(1, .3),
                child: Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: SizedBox(
                    width: 48,
                    height: 48,
                    child: FloatingActionButton(
                      onPressed: _onCurrentLocationButtonPressed,
                      backgroundColor: Colors.white,
                      child: _buildCurrentLocationIcon(),
                    ),
                  ),
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
    );
  }

  _onCurrentLocationButtonPressed() {
    switch (_locationPermission) {
      case ClientLocationPermissions.allowed:
        _setCurrentCoords();
        break;

      case ClientLocationPermissions.denied:
        _requestPermissions();
        break;

      case ClientLocationPermissions.deniedForever:
        _requestPermissions(true);
        break;
    }
  }

  _buildCurrentLocationIcon() {
    switch (_locationPermission) {
      case ClientLocationPermissions.allowed:
        return Icon(
          Icons.my_location,
          color: Theme.of(context).primaryColorDark,
        );

      case ClientLocationPermissions.denied:
        return Stack(
          children: const [
            Icon(
              Icons.location_searching,
              color: Colors.orange,
            ),
            Padding(
              padding: EdgeInsets.all(1.0),
              child: Icon(
                Icons.help_rounded,
                size: 22,
                color: Colors.orange,
              ),
            ),
          ],
        );

      case ClientLocationPermissions.deniedForever:
        return const Icon(
          Icons.location_disabled,
          color: Colors.red,
        );
    }
  }

  void _requestPermissions([bool deniedForever = false]) {
    Widget content = const Text(
      "Para acceder a su ubicación actual, "
      "permita el acceso a la geolocalización",
    );

    var url = "https://support.google.com/chrome/answer/142065?hl=es-419";

    if (deniedForever) {
      content = Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Has prohibido el acceso a tu ubicación para siempre. "
            "Es necesario para identificar su ubicación y entregar "
            "el producto a la dirección correcta lo antes posible. "
            "Para continuar, habilite el seguimiento de "
            "ubicación en la configuración de su navegador.\n",
          ),
          TextButton(
            child: Text(url),
            onPressed: () => launch(url),
          ),
        ],
      );
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Geolocalización deshabilitada"),
        content: content,
        actions: deniedForever
            ? null
            : [
                OutlinedButton(
                  onPressed: () {
                    _checkLocationPermissions();
                    Navigator.pop(context);
                  },
                  child: const Text("Solicitar permisos"),
                ),
              ],
      ),
    );
  }

  void _setCurrentCoords() async {
    var locationData = await Geolocator.getCurrentPosition();

    _mapController.moveCamera(
      CameraUpdate.newLatLngZoom(
        LatLng(
          locationData.latitude,
          locationData.longitude,
        ),
        17.0,
      ),
    );

    widget.onCoordsChange(
      LatLng(
        locationData.latitude,
        locationData.longitude,
      ),
    );
  }

  void _setDistrictCameraPosition() async {
    final places = GoogleMapsPlaces(
      apiKey: "AIzaSyDK6a99pqYap3FeLbJ2m0rwnsGEb9qIpts",
    );

    var query = '${widget.order.client.district.name}, Peru';

    PlacesSearchResponse response = await places.searchByText(query);

    _mapController.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(
            response.results.first.geometry!.location.lat,
            response.results.first.geometry!.location.lng,
          ),
          zoom: 17.0,
        ),
      ),
    );
  }

  void _checkLocationPermissions() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();

    //* Проверяем если получение местоположения запрещено сейчас,
    //* то запрашиваем разрешение.
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      //* Пользователь дал разрешение.
      if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse) {
        setState(
          () {
            _locationPermission = ClientLocationPermissions.allowed;
            _setCurrentCoords();
          },
        );
      }

      //* Пользователь запретил навсегда.
      else if (permission == LocationPermission.deniedForever) {
        setState(
          () => _locationPermission = ClientLocationPermissions.deniedForever,
        );
      }
    }

    //* Запрещено получение геолокации по умолчанию.
    else if (permission == LocationPermission.deniedForever) {
      setState(
        () => _locationPermission = ClientLocationPermissions.deniedForever,
      );
    }

    //* Разрешено по умолчанию.
    else {
      setState(
        () {
          _locationPermission = ClientLocationPermissions.allowed;
          _setCurrentCoords();
        },
      );
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    _mapController.setMapStyle(jsonEncode(gMapStyle));

    _checkLocationPermissions();
    _setDistrictCameraPosition();
  }
}

const gMapStyle = [
  {
    "featureType": "administrative",
    "elementType": "geometry",
    "stylers": [
      {"visibility": "off"}
    ]
  },
  {
    "featureType": "poi",
    "stylers": [
      {"visibility": "off"}
    ]
  },
  {
    "featureType": "transit",
    "stylers": [
      {"visibility": "off"}
    ]
  }
];
