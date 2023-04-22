import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../shared/google_maps_util.dart';

class GoogleMapsWidget extends StatefulWidget {
  final double lat;
  final double lon;
  const GoogleMapsWidget({required this.lat, required this.lon});

  @override
  State<GoogleMapsWidget> createState() => _GoogleMapsWidgetState();
}

class _GoogleMapsWidgetState extends State<GoogleMapsWidget> {
  Completer<GoogleMapController> _controller = Completer();

  late LatLng _center;
  Set<Marker> _markers = {};

  @override
  void initState(){
    super.initState();
    _center = LatLng(widget.lat, widget.lon);
    _markers.add(Marker(
      markerId: MarkerId("marker"),
      position: _center,
      infoWindow: InfoWindow(title: "Marker"),
    ));
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }


  @override
  Widget build(BuildContext context) {
    return SizedBox(
  width: MediaQuery.of(context).size.width,
  height: 200,
  child: Stack(
    children: [
      GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 11.0,
        ),
        zoomControlsEnabled: false,
        markers: _markers,
      ),
      Positioned.fill(
        child: InkWell(
          onTap: () {
            GoogleMapsUtil.navigateTo(_center.latitude, _center.longitude);
          },
          child: Container(color: Colors.transparent),
        ),
      ),
    ],
  ),
);
  }
}