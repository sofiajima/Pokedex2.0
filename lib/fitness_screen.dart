import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';

import 'home_screen.dart';

class FitnessScreen extends StatefulWidget {
  const FitnessScreen({Key key}) : super(key: key);

  @override
  State<FitnessScreen> createState() => _FitnessScreenState();
}

class _FitnessScreenState extends State<FitnessScreen> {
  Stream<StepCount> _stepCountStream;
  Stream<PedestrianStatus> _pedestrianStatusStream;
  String _status, _stepCountValue;

  @override
  void initState() {
    super.initState();
    requestPermission();
  }

  // request for permission
  Future<void> requestPermission() async {
    PermissionStatus result;
    if (await Permission.activityRecognition.request().isGranted) {
      result = await Permission.activityRecognition.status;
      setUpPedometer();
    } else {
      result = await Permission.activityRecognition.request();
    }
  }

  void setUpPedometer() {
    _stepCountStream = Pedometer.stepCountStream;
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    _stepCountStream.listen((StepCount event) {
      setState(() {
        _stepCountValue = event.steps.toString();
      });
    });
    _pedestrianStatusStream.listen((PedestrianStatus event) {
      setState(() {
        _status = event.status.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      drawer: NavigationDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        // add text and Image
        title: Text(
          'Mis Pasos',
          style: TextStyle(
            color: Colors.black,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),

        // color black
        iconTheme: IconThemeData(color: Colors.black),

        // remove elevation
        elevation: 0,
      ),
      // center text
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '$_stepCountValue',
              style: TextStyle(
                color: Colors.black,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '$_status',
              style: TextStyle(
                color: Colors.black,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            // add Image
            Positioned(
              top: height * 0.18,
              right: -30,
              child: Image.asset(
                _status == null
                    ? 'images/Charmander.png'
                    : _status == 'walking'
                        ? 'images/Charizard.png'
                        : _status == 'running'
                            ? 'images/Charizard.png'
                            : _status == 'stopped'
                                ? 'images/Charmander.png'
                                : 'images/Charmander.png',
                height: 60,
                fit: BoxFit.fitHeight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
