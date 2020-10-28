import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart'
    as bg;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  print("Application started");
  await Future.delayed(const Duration(seconds: 3));
  runZoned<Future<void>>(() async {
    runApp(MyApp());
  }, onError: print);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    print("Page init");
    ////
    // 1.  Listen to events (See docs for all 12 available events).
    //

    // Fired whenever a location is recorded
    bg.BackgroundGeolocation.onLocation((bg.Location location) {
      print('[location] - $location');
    });

    // Fired whenever the plugin changes motion-state (stationary->moving and vice-versa)
    bg.BackgroundGeolocation.onMotionChange((bg.Location location) {
      print('[motionchange] - $location');
    });

    // Fired whenever the state of location-services changes.  Always fired at boot
    bg.BackgroundGeolocation.onProviderChange((bg.ProviderChangeEvent event) {
      print('[providerchange] - $event');
    });

    ////
    // 2.  Configure the plugin
    //
    bg.BackgroundGeolocation.ready(bg.Config(
            desiredAccuracy: bg.Config.DESIRED_ACCURACY_HIGH,
            distanceFilter: 10.0,
            stopOnTerminate: false,
            startOnBoot: true,
            debug: true,
            logLevel: bg.Config.LOG_LEVEL_VERBOSE))
        .then((bg.State state) {
      print(state);
      if (!state.enabled) {
        print("BG STARTED");
        ////
        // 3.  Start the plugin.
        //
        bg.BackgroundGeolocation.start();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print("Build");
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'There should be 8 images',
              ),
              Image(image: const AssetImage('assets/house.jpg')),
              Image(image: const AssetImage('assets/tree.jpg')),
              Image(image: const AssetImage('assets/sky.jpeg')),
              Image(image: const AssetImage('assets/1.jpg')),
              Image(image: const AssetImage('assets/2.jpg')),
              Image(image: const AssetImage('assets/3.jpg')),
              Image(image: const AssetImage('assets/4.jpg')),
              Image(image: const AssetImage('assets/5.jpeg')),
              // Image(image: const AssetImage('assets/6.jpeg')),
              // Image(image: const AssetImage('assets/7.jpg')),
              // Image(image: const AssetImage('assets/8.jpg')),
              // Image(image: const AssetImage('assets/9.jpg')),
              // Image(image: const AssetImage('assets/10.jpg')),
              // Image(image: const AssetImage('assets/11.jpg')),
              // Image(image: const AssetImage('assets/12.jpg')),
              // Image(image: const AssetImage('assets/13.jpg')),
              // Image(image: const AssetImage('assets/14.jpg')),
              // Image(image: const AssetImage('assets/15.jpg')),
            ],
          ),
        ),
      ),
    );
  }
}
