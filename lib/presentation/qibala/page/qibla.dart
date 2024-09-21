import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:hidaya/core/config/assets/image/app_image.dart';

class QiblaCompass extends StatefulWidget {
  const QiblaCompass({super.key});

  @override
  _QiblaCompassState createState() => _QiblaCompassState();
}

class _QiblaCompassState extends State<QiblaCompass>
    with SingleTickerProviderStateMixin {
  StreamSubscription<QiblahDirection>? _subscription;
  late AnimationController _controller;
  late Animation<double> _animation;
  double _currentDirection = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500), // Adjust duration as needed
    );

    _animation = Tween<double>(begin: 0, end: 0).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    _subscription = FlutterQiblah.qiblahStream.listen((direction) {
      final newDirection = direction.qiblah;

      // Update the animation tween
      _animation = Tween<double>(
        begin: _currentDirection,
        end: newDirection,
      ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

      _currentDirection = newDirection;
      _controller.forward(from: 0);
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Transform.rotate(
          angle: _animation.value *
              (3.141592653589793 / 180), // Convert to radians
          child: Image.asset(AppImage.qibla_compass),
        ),
      ),
    );
  }
}
