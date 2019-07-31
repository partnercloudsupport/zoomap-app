import 'package:flutter/material.dart';
import 'package:zoomap/photos_listview.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'flickr_images.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
  List<String> networkImages;
  bool isMarked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Container(
              color: Color(0xFF61234e),
              child: Center(
                child: Text(
                  'Zoomap',
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontFamily: 'Dosis',
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          Expanded(
            child: _googleMap(context),
            flex: 6,
          ),
          Expanded(
            child: RaisedButton(
              onPressed: () {
                isMarked == true ? getImageUrlList() : null;
              },
              color: Color(0xFF61234e),
              child: Text(
                'Put a marker and tap here',
                style: TextStyle(
                    fontSize: 25, fontFamily: 'Roboto', color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void getImageUrlList() async {
    FlickrImages flickrImages = FlickrImages();

    try {
      networkImages =
          await flickrImages.getImageList(latitude: lat, longitude: long);

      if (networkImages[0] == 'noImagesFound') {
        Alert(
          context: context,
          type: AlertType.info,
          title: "No images found",
          desc: "Try to mark another place",
          buttons: [
            DialogButton(
              child: Text(
                "ok",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => Navigator.pop(context),
              width: 120,
            )
          ],
        ).show();
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return PhotosScreen(
              images: networkImages,
            );
          }),
        );
      }
    } catch (e) {
      Alert(
        context: context,
        type: AlertType.error,
        title: "Network Issues",
        desc: "There's no internet connection",
        buttons: [
          DialogButton(
            child: Text(
              "ok",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            width: 120,
          )
        ],
      ).show();
    }
  }

  Widget _googleMap(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: GoogleMap(
          onTap: (LatLng tapPosition) {
            isMarked = true;
            markers.remove(marker);
            lat = (tapPosition.latitude);
            long = (tapPosition.longitude);

            print(lat);
            print(long);
            _addMarker(latitude: lat, longitude: long);
          },
          initialCameraPosition:
              CameraPosition(target: LatLng(-0.92, 0.0), zoom: 2),
          mapType: MapType.normal,
          onMapCreated: _mapController,
          markers: markers,
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
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
      markerId: MarkerId('marker'),
    );
    markers.add(marker);
    setState(() {});
  }
}
