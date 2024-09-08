import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutterapp/src/settings/settings_controller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlacesStream extends StatefulWidget {

  static const routeName="/placesStreamRoute";
  final SettingsController? controller;

  const PlacesStream({super.key,this.controller});

  @override
  State<PlacesStream> createState() => _PlacesStreamState();
}

class _PlacesStreamState extends State<PlacesStream> {

  //Display places to UI
  Completer<GoogleMapController?>? _mapController = Completer();
  StreamSubscription? locationStreamSubscription;
  StreamSubscription? boundsSubscription;
  //Stream<PlaceName?>? _locationNameSearchStream;

  String? finalSelectedStreet;
  double? latValue;
  double? lngValue;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
