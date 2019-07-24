import 'dart:async';

import 'package:flutter/material.dart';
import 'package:zoomap/photos_listview.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
  static const String id = 'MyHomePage';
}

class _MyHomePageState extends State<MyHomePage> {
  Set<Marker> markers = Set();
  Marker marker;
  double lat;
  double long;
  GoogleMapController mapController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Container(
              color: Colors.blue,
              child: Center(
                child: Text(
                  'information',
                ),
              ),
            ),
          ),
          Expanded(
            child: _googleMap(context),
            flex: 6,
          ),
          Expanded(
            child: FlatButton(
              onPressed: () {
                Navigator.pushNamed(context, PhotosScreen.id);
              },
              color: Colors.teal,
              child: Text('click here for show the pics'),
            ),
          )
        ],
      ),
    );
  }

  Widget _googleMap(BuildContext context) {
    return Container(
        // height: MediaQuery.of(context).size.height,
        // width: MediaQuery.of(context).size.width,
        child: GoogleMap(
      onTap: (LatLng tapPosition) {
        markers.remove(marker);
        lat = (tapPosition.latitude);
        long = (tapPosition.longitude);
        _addMarker(latitude: lat, longitude: long);
      },
      initialCameraPosition:
          CameraPosition(target: LatLng(40.0, -74.0), zoom: 12),
      mapType: MapType.normal,
      onMapCreated: _mapController,
      markers: markers,
    ));
  }

  _mapController(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }

  _addMarker({@required double latitude, @required double longitude}) {
    marker = Marker(
      position: LatLng(latitude, longitude),
      icon: BitmapDescriptor.defaultMarker,
      markerId: MarkerId('xablau'),
    );
    markers.add(marker);
    setState(() {});
  }
}
