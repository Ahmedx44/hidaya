import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:hidaya/core/config/assets/image/app_image.dart';

class Qibla extends StatefulWidget {
  const Qibla({super.key});

  @override
  _QiblaCompassState createState() => _QiblaCompassState();
}

class _QiblaCompassState extends State<Qibla> {
  // StreamSub is used to listen to stream and handle incoming data
  StreamSubscription<QiblahDirection>? _subscription;
  double _currentDirection = 0;

  @override
  void initState() {
    super.initState();
    // FlutterQiblah.qiblahStream will continuesly provide QiblaDIrection
    //after that we listen the direction and set the direction to the currentDirection by  module operation,
    //this will make sure the value is between 0 and 360, this is used to determine the direction of the currenDirection
    _subscription = FlutterQiblah.qiblahStream.listen((direction) {
      setState(() {
        _currentDirection = direction.qiblah % 360;
      });
    });
  }

  @override
  void dispose() {
    // THis cancel the stream subscription to prevent memory leak
    // it stop listening to the FLutterQIblah.qiblahSTream when the widget is no longer in use.
    _subscription?.cancel();
    super.dispose();
  }

  String _getDirectionText(double degree) {
    if (degree >= 337.5 || degree < 22.5) {
      return 'N';
    } else if (degree >= 22.5 && degree < 67.5) {
      return 'NE';
    } else if (degree >= 67.5 && degree < 112.5) {
      return 'E';
    } else if (degree >= 112.5 && degree < 157.5) {
      return 'SE';
    } else if (degree >= 157.5 && degree < 202.5) {
      return 'S';
    } else if (degree >= 202.5 && degree < 247.5) {
      return 'SW';
    } else if (degree >= 247.5 && degree < 292.5) {
      return 'W';
    } else {
      return 'NW';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${_currentDirection.toStringAsFixed(2)}° ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              Text(
                _getDirectionText(_currentDirection),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'Rotate your phone till the kaba is at the center',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.inversePrimary),
          ),
          const SizedBox(height: 20),
          Center(
            //we use Transform widget with rotatate method to make the image move direction based on the provided _currentDirection
            child: Transform.rotate(
              angle: _currentDirection *
                  (3.141592653589793 /
                      180), // Convert to radians,beacuse the angle propety expect rotation angle based on radian not degree
              //we convert the degree to radian using pi/180
              child: Image.asset(height: 300, AppImage.qibla_compass),
            ),
          ),
        ],
      ),
    );
  }
}
