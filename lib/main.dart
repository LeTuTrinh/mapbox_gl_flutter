import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: MapboxMap(
        accessToken:
            'pk.eyJ1IjoidC10cmluaDE3NSIsImEiOiJjbGYyNzE5b3owM3ZtM3NwZjdxM2xqMjBvIn0.5BedsDciHWZ8vt5BEUBLYg',
        initialCameraPosition: const CameraPosition(
          target: LatLng(10.958613288458084, 106.8346566003732),
          zoom: 14,
        ),
      )),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
