import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_map/flutter_map.dart';
import 'package:geojson/geojson.dart';

class MapBloc extends ChangeNotifier {
  GeoJson? geoJson;

  final lines = <Polyline>[];

  Future<void> parseAndDrawAssetsOnMap() async {
    final geo = GeoJson();
    geo.processedLines.listen((GeoJsonLine line) {
      /// when a line is parsed add it to the map right away
      lines.add(
        Polyline(
          strokeWidth: 2.0,
          color: Colors.blue,
          points: line.geoSerie!.toLatLng(),
        ),
      );
      notifyListeners();
    });
    geo.endSignal.listen((_) => geo.dispose());
    final data = await rootBundle
        .loadString('assets/iran.geojson');
    await geo.parse(data, verbose: true);
  }

  // Future<void> loadGeoJson() async {
  //   String data = await rootBundle.loadString('assets/iran.geojson');
  //   Map<String, dynamic> json = jsonDecode(data);
  //   geoJson = GeoJson()..;
  // }
}
