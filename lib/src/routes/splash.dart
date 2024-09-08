import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

class SplashPage extends StatefulWidget {
  static const routeName = "/splashRoute";
  final String? label;
  final String? detailsPath;
  const SplashPage({super.key, this.label, this.detailsPath});

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _redirect();
  }

  Future<void> _redirect() async {
    await Future.delayed(Duration(seconds: 4));
    if (!mounted) {
      return;
    }
    context.go('/a');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Positioned(
              left: 140.0,
              width: 100.0,
              top: 300.0,
              height: 100.0,
              child: Image(
                image: AssetImage(
                  'assets/images/tabarak1.png',
                ),
                width: 80.0,
                height: 80.0,
                fit: BoxFit.fill,
              ),
            ),
            Positioned(
              left: 120.0,
              width: 150.0,
              top: 400.0,
              height: 40.0,
              child: AnimatedTextKit(
                animatedTexts: [
                  WavyAnimatedText(
                    'Bueno',
                    textStyle: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
