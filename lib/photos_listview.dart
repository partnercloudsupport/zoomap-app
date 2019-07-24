import 'package:flutter/material.dart';

class PhotosScreen extends StatefulWidget {
  PhotosScreen({Key key}) : super(key: key);

  _PhotosScreenState createState() => _PhotosScreenState();

  static const String id = 'PhotosScreen';
}

class _PhotosScreenState extends State<PhotosScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text('Phots list'),
        ),
      ),
    );
  }
}
