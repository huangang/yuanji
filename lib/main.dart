import 'package:flutter/material.dart';
import './home.dart';
import './page/weather.dart';
import './page/rand_image.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: <String, WidgetBuilder> {
        '/': (context) => new HomePageWidget(),
        '/weather': (context) => new WeatherApp(),
        '/rand_image': (context) => new RandImage(),
      },
      title: '猿集',
      theme: new ThemeData(primaryColor: Color.fromRGBO(58, 66, 86, 1.0)),
      // home: HomePageWidget(),
    );
  }
}