import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

class CustomMap extends StatelessWidget {
  const CustomMap({ 
    Key key, 
    @required this.onTap,
    @required this.height,
    this.onMapCreate,
    this.markers,
    @required this.coordinate,
    // @required this.ontap,
    this.mapController
  }) : super(key: key);

  final double height;
  // final double lat;
  // final double long;
  final Function onTap;
  final Function onMapCreate;
  final Marker markers;
  final LatLng coordinate;
  final Completer<GoogleMapController> mapController;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: GoogleMap(
        myLocationButtonEnabled: false,
        onTap:onTap,
        initialCameraPosition: CameraPosition(target: coordinate, zoom: 16),
        onMapCreated: (GoogleMapController controller) {
          return mapController.complete(controller);
        },
        myLocationEnabled: true,
        markers: { 
          Marker(
            markerId: MarkerId(""),
            infoWindow: InfoWindow(title:""),
            // icon: BitmapDescriptor.,
            position: coordinate,
          )
    },
      ),
    );
  }
}