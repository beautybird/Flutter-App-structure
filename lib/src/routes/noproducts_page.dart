import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutterapp/src/settings/settings_controller.dart';
import 'package:flutter/material.dart';

class NoProductsPage extends StatelessWidget {
  static const routeName = "/noProductsRoute";
  final SettingsController? controller;
  final String? label;

  const NoProductsPage({super.key, this.controller, this.label});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedTextKit(
        animatedTexts: [
          WavyAnimatedText(
            'No Products Available',
            textStyle: TextStyle(fontSize: 22.0),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
