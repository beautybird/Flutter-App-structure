import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  ///
  Completer<GoogleMapController> _mapController = Completer();
  double? mapHeight;
  double? mapWidth;

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  ///
  ///Markers
  Set<Marker> _markers = Set<Marker>();

  @override
  Widget build(BuildContext context) {

    mapHeight = MediaQuery.of(context).size.height;
    mapWidth = MediaQuery.of(context).size.width;

    return Placeholder(
      child: Container(
        constraints: BoxConstraints(
          minWidth: 300.0,
          maxWidth: 300.0,
          minHeight: 300.0,
          maxHeight: 300.0,
        ),
        child: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition:_kGooglePlex ,
          markers: _markers,
          onMapCreated: (GoogleMapController controller){
            _mapController.complete(controller);
          },
        ),
      ),
    );
  }
}
