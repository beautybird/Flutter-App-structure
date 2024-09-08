import 'package:flutter/material.dart';
import 'package:flutterapp/src/settings/settings_controller.dart';

class HomePage extends StatefulWidget {
  static const routeName='/homePageRoute';
  final SettingsController? controller;
  final String? label;

  const HomePage({super.key,this.controller,this.label});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
