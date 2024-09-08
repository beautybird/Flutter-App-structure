import 'package:flutterapp/src/settings/settings_controller.dart';
import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {

  static const routeName = '/errorRoute';
  final SettingsController? controller;

  const ErrorPage({super.key,this.controller});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Error '),
    );
  }
}
