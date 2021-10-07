import 'dart:async';
import 'dart:math';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:hackkimura/model/AEDResponse.dart';

class AEDMap extends StatefulWidget {
  AEDMap({Key? key}) : super(key: key);

  @override
  _AEDMapState createState() => _AEDMapState();
}

class _AEDMapState extends State {
  final Location _locationService = Location();
  final Completer<MapboxMapController> _controller = Completer();
  LocationData? _yourLocation;
  StreamSubscription? _locationChangedListen;
  var _zoomGesturesEnabled = true;
  var _myLocationEnabled = true;
  final double _initialLat = 35.96;
  final double _initialLong = 136.185;
  final double _searchRadius = 1000;

  @override
  void initState() {
    super.initState();
    _acquireCurrentLocation();
    _locationChangedListen =
        _locationService.onLocationChanged.listen((LocationData result) async {
      setState(() {
        _yourLocation = result;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();

    // 監視を終了
    _locationChangedListen?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.arrow_back)),
            title: Text("AEDマップ")),
        backgroundColor: Colors.black,
        body: MapboxMap(
            onMapCreated: (MapboxMapController controller) {
              _controller.complete(controller);
              _gpsToggle();
            },
            styleString: MapboxStyles.MAPBOX_STREETS,
            zoomGesturesEnabled: _zoomGesturesEnabled,
            myLocationEnabled: _myLocationEnabled,
            trackCameraPosition: true,
            compassEnabled: true,
            initialCameraPosition: CameraPosition(
              target: LatLng(
                  _yourLocation != null
                      ? _yourLocation!.latitude!
                      : _initialLat,
                  _yourLocation != null
                      ? _yourLocation!.longitude!
                      : _initialLong),
              zoom: 13.5,
            ),
            onMapClick: (Point<double> point, LatLng tapPoint) {
              _controller.future.then((mapboxMap) {
                mapboxMap.moveCamera(CameraUpdate.newLatLng(tapPoint));
              });
            }),
        floatingActionButton:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          SizedBox(width: .1),
          OutlinedButton(
              child: Text('この周辺のAEDを探す',
                  style: Theme.of(context).textTheme.bodyText1),
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: const StadiumBorder(),
                side: const BorderSide(color: Colors.green),
              ),
              onPressed: _searchAEDs),
          FloatingActionButton(
              backgroundColor: Colors.blue,
              onPressed: () {
                _gpsToggle();
              },
              child: Icon(Icons.gps_fixed)),
        ]));
  }

  void _searchAEDs() async {
    _controller.future.then((mapboxMap) async {
      double latitude = mapboxMap.cameraPosition!.target.latitude;
      double longitude = mapboxMap.cameraPosition!.target.longitude;

      Uri uri = Uri.parse(
          'https://aed.azure-mobile.net/api/AEDSearch?lat=$latitude&lng=$longitude&r=$_searchRadius');
      http.Response resp = await http.get(uri);
      if (resp.statusCode == 200) {
        final jsonArray = json.decode(resp.body);
        if (jsonArray.length > 0) {
          jsonArray.forEach((i) {
            AEDResponse response = AEDResponse.fromJson(i);
            mapboxMap.addSymbol(
              SymbolOptions(
                  geometry: LatLng(response.latitude, response.longitude),
                  iconImage: "images/pin.png",
                  iconSize: .1),
            );
          });
        }
      }

      final metersPerPixel =
          await mapboxMap.getMetersPerPixelAtLatitude(latitude);
      mapboxMap.addCircle(CircleOptions(
          circleRadius: _searchRadius / metersPerPixel,
          circleStrokeColor: "#008000",
          circleStrokeWidth: 7,
          circleOpacity: 0.1,
          circleColor: "#008000",
          geometry: LatLng(latitude, longitude)));
    });
  }

  void _gpsToggle() async {
    _controller.future.then((mapboxMap) {
      mapboxMap.moveCamera(CameraUpdate.newLatLng(LatLng(
          _yourLocation != null ? _yourLocation!.latitude! : _initialLat,
          _yourLocation != null ? _yourLocation!.longitude! : _initialLong)));
    });
  }

  void _acquireCurrentLocation() async {
    // Initializes the plugin and starts listening for potential platform events
    Location location = new Location();

    // Whether or not the location service is enabled
    bool serviceEnabled;

    // Status of a permission request to use location services
    PermissionStatus permissionGranted;

    // Check if the location service is enabled, and if not, then request it. In
    // case the user refuses to do it, return immediately with a null result
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    // Check for location permissions; similar to the workflow in Android apps,
    // so check whether the permissions is granted, if not, first you need to
    // request it, and then read the result of the request, and only proceed if
    // the permission was granted by the user
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    // Gets the current location of the user
    _yourLocation = await location.getLocation();
  }
}
