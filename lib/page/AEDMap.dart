import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class MyAEDApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State {
  MapboxMapController? mapController;
  var _zoomGesturesEnabled = true;
  var _myLocationEnabled = true;

  void _onMapCreated(MapboxMapController controller) async {
    mapController = controller;
    // Acquire current location (returns the LatLng instance)
    final result = await acquireCurrentLocation();

    // You can either use the moveCamera or animateCamera, but the former
    // causes a sudden movement from the initial to 'new' camera position,
    // while animateCamera gives a smooth animated transition
    await controller.animateCamera(
      CameraUpdate.newLatLng(result),
    );

    // Add a circle denoting current user location
    await controller.addCircle(
        CircleOptions(
          circleRadius: 8.0,
          circleColor: '#006992',
          circleOpacity: 0.8,

          // YOU NEED TO PROVIDE THIS FIELD!!!
          // Otherwise, you'll get a silent exception somewhere in the stack
          // trace, but the parameter is never marked as @required, so you'll
          // never know unless you check the stack trace
          geometry: result,
          draggable: false,
        ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    mapController?.addSymbol(
      SymbolOptions(
        geometry: LatLng(35.17176088096857, 136.88817886263607),
        iconImage: "assets/images/AED.jpg",
      ),
    );

    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back)),
          title: Text("AEDマップ"),
          backgroundColor: Colors.blueGrey[600]
      ),
      backgroundColor: Colors.black,
      body: MapboxMap(
        onMapCreated: _onMapCreated,
        styleString: MapboxStyles.MAPBOX_STREETS,
        zoomGesturesEnabled: _zoomGesturesEnabled,
        myLocationEnabled: _myLocationEnabled,
        initialCameraPosition: const CameraPosition(
            target: LatLng(35.17176088096857, 136.88817886263607),
            zoom: 13.4746),
      ),
    );
  }
}


Future<LatLng> acquireCurrentLocation() async {
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
      return LatLng(0, 0);
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
      return LatLng(0, 0);
    }
  }

  // Gets the current location of the user
  final locationData = await location.getLocation();
  return LatLng(locationData.latitude!, locationData.longitude!);
}
