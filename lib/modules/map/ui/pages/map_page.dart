import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_map/flutter_map.dart'; // Suitable for most situations
import 'package:flutter_map/plugin_api.dart'; // Only import if required functionality is not exposed by default
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:revolution1401/common/styles/colorPalette/color_palette_helper.dart';
import 'package:revolution1401/modules/map/bloc/map_bloc.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  MapController mapController = MapController();
  LatLng? tappedLocation;
  String cityName = '';
  @override
  Widget build(BuildContext context) {
    final markers = <Marker>[
      Marker(
        width: 80,
        height: 80,
        point: LatLng(51.5, -0.09),
        builder: (ctx) => const FlutterLogo(
          textColor: Colors.blue,
          key: ObjectKey(Colors.blue),
        ),
      ),
      Marker(
        width: 80,
        height: 80,
        point: LatLng(35.7077714, 51.2075678),
        builder: (ctx) => IconButton(
          icon: Icon(
            Icons.location_on,
            color: context.colors.primary,
            size: 38,
          ),
          onPressed: () {
            print('tehran in here');
          },
        ),
      ),
      Marker(
        width: 80,
        height: 80,
        point: LatLng(48.8566, 2.3522),
        builder: (ctx) => const FlutterLogo(
          textColor: Colors.purple,
          key: ObjectKey(Colors.purple),
        ),
      ),
    ];
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        body: FlutterMap(
          mapController: mapController,
          options: MapOptions(
            center: LatLng(32.4279, 53.6880),
            zoom: 4.0,
            onTap: (tapPosition, point) async {
              setState(() {
                tappedLocation = point;
                cityName = '';
              });
              final url =
                  'https://nominatim.openstreetmap.org/reverse?format=json&lat=${tappedLocation?.latitude}&lon=${tappedLocation?.longitude}&zoom=18&addressdetails=1';
              final response = await http.get(Uri.parse(url));
              final jsonData = jsonDecode(response.body);
              if (jsonData['address'] != null) {
                setState(() {
                  cityName = jsonData['address']['city'] ?? '';
                });
              }
            },
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
              retinaMode: false,
            ),
            MarkerLayer(
              markers: tappedLocation == null
                  ? []
                  : [
                      Marker(
                        point: tappedLocation!,
                        builder: (ctx) => Icon(Icons.location_on),
                      ),
                    ],
            ),
          ],
        ),
        bottomNavigationBar: cityName == ''
            ? SizedBox()
            : BottomAppBar(
                child: Container(
                  height: 50,
                  child: Center(
                    child: Text(
                      'Selected city: $cityName',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
