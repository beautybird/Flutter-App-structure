import 'package:flutter/material.dart';
import 'package:flutterapp/src/settings/settings_controller.dart';

class NoProductsPage extends StatelessWidget {
  static const routeName='/';
  final SettingsController? controller;
  final String? label;

  const NoProductsPage({super.key,this.controller,this.label});

  @override
  Widget build(BuildContext context) {
    return const Placeholder(
      //Add the message you want here
    );
  }
}
