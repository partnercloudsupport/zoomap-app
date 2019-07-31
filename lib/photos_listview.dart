import 'package:flutter/material.dart';

import 'package:photo_view/photo_view_gallery.dart';

class PhotosScreen extends StatefulWidget {
  PhotosScreen({this.images});

  final images;

  _PhotosScreenState createState() => _PhotosScreenState();

  static const String id = 'PhotosScreen';
}

class _PhotosScreenState extends State<PhotosScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //print(widget.images);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _verifyNetwork());
  }

  Widget _verifyNetwork() {
    if (widget.images == null) {
      return Center(
        child: Text(
          'Network Issues. Try again Later',
          style: TextStyle(fontSize: 20),
        ),
      );
    } else {
      return ListView(children: <Widget>[_imagesArray(context)]);
    }
  }

  Widget _imagesArray(BuildContext context) {
    return _buildAlbum(context);
  }

  Widget _buildAlbum(BuildContext context) {
    List<PhotoViewGalleryPageOptions> list =
        List<PhotoViewGalleryPageOptions>();
    for (var index in widget.images) {
      list.add(
        PhotoViewGalleryPageOptions(
          imageProvider: NetworkImage(index),

          //heroTag: 'Imagem ${list.length}',
        ),
      );
      print('addddd $index');
    }
    return Stack(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: PhotoViewGallery(
            pageOptions: list,
            backgroundDecoration: BoxDecoration(color: Colors.black87),
          ),
        ),
        Container(
          child: FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.close,
              color: Colors.white,
              size: 50,
            ),
          ),
        )
      ],
    );
  }
}
