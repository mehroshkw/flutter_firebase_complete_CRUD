import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// const LatLng currentLocation = LatLng(31.4613888, 74.3628915);

class Maps extends StatefulWidget {
  Maps({Key? key}) : super(key: key);

  @override
  State<Maps> createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        child: Column(children: [
          Flexible(
              child: FlutterMap(
            options: MapOptions(
              center: LatLng(31.4613888, 74.3628915),
              zoom: 8,
            ),
            nonRotatedChildren: [
              AttributionWidget.defaultWidget(
                source: 'OpenStreetMap contributors',
                onSourceTapped: null,
              ),
            ],
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
                subdomains: ['a','b','c'],
              ),
              MarkerLayer(
                markers: [
                  Marker(point: LatLng(31.4613888, 74.3628915), builder: (ctx) => Icon(Icons.push_pin_sharp))
                ],
              )
            ],
          ))
        ]),
      ),
    ));
  }
}
