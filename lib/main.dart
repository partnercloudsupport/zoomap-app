import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'photos_listview.dart';
import 'package:flare_splash_screen/flare_splash_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen.navigate(
        name: 'animations/Zoomap.flr',
        next: MyHomePage(),
        backgroundColor: Color(0xFF61234e),
        until: () => Future.delayed(Duration(seconds: 1)),
        startAnimation: 'Lupa_move',
      ),
      routes: {
        MyHomePage.id: (context) => MyHomePage(),
        PhotosScreen.id: (context) => PhotosScreen()
      },
    );
  }
}
