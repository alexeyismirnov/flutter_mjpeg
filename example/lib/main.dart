import 'package:flutter/material.dart';
import 'package:mjpeg/mjpeg.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text('MJPEG live view'),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Mjpeg.startLiveView(url: "http://172.16.15.211:9000/live-camera-23");
          },
          child: const Text('Live view'),
        ),
      ),
    ));
  }
}
