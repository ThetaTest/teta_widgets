// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';

// Project imports:

/// Map Template

class GoogleMapsTemplate {
  static String toCodeOnInit({
    required final BuildContext context,
    required final String mapControllerName,
    required final String mapConfigDatasetName,
    required final String markersDatasetName,
    required final String markerId,
    required final String markerLatitude,
    required final String markerLongitude,
    required final String markerIconUrl,
    required final String markerIconWidth,
    required final String markerDrawPath,
    required final String customMapStyle,
    required final String initialPositionLng,
    required final String initialPositionLat,
    required final bool showMyLocationMarker,
    required final bool trackMyLocation,
    required final String initialZoomLevel,
  }) {
    return '';
  }

  static Future<String> toCode({
    required final BuildContext context,
    required final String mapControllerName,
    required final String mapConfigDatasetName,
    required final String markersDatasetName,
    required final String markerId,
    required final String markerLatitude,
    required final String markerLongitude,
    required final String markerIconUrl,
    required final String markerIconWidth,
    required final String markerDrawPath,
    required final String customMapStyle,
    required final String initialPositionLng,
    required final String initialPositionLat,
    required final bool showMyLocationMarker,
    required final bool trackMyLocation,
    required final String initialZoomLevel,
  }) async {
    final googleMapsKey =
        (BlocProvider.of<FocusProjectBloc>(context).state as ProjectLoaded)
                .prj
                .config
                ?.googleMapsKey ??
            '';

    final code = '''
    FutureBuilder<fp.Tuple2<Set<Polyline>, Set<Marker>>>(
                future: Future.delayed(Duration.zero, () async {
                  try {
                    final markersDataset =
                        ((datasets['$markersDatasetName'] as List<dynamic>?) ??
                            <dynamic>[]);
                    final mapMarkers = Set<Marker>();
                    final polyLines = <Polyline>{};

                                final bool showMyLocationMarker = $showMyLocationMarker;
                                final bool trackMyLocation = $trackMyLocation;
                                try {
                                  Location location = Location();
                                  final userLocation =
                                      await location.getLocation();

                                  if (showMyLocationMarker) {
                                    mapMarkers.add(
                                      Marker(
                                        markerId: const MarkerId('myLocation'),
                                        position: LatLng(
                                          userLocation.latitude!,
                                          userLocation.longitude!,
                                        ),
                                      ),
                                    );
                                  }

                                  if (trackMyLocation) {
                                    location.onLocationChanged.listen((event) {
                                      setState(() {});
                                    });
                                  }
                                } catch (e, st) {
                                  print(e);
                                  print(st);
                                }

                    for (final element in markersDataset) {
                      try {
                      final bool markerDrawPath = ((element['$markerDrawPath'] as String?) ?? 'false').toLowerCase() == 'true';
                      final String markerId = element['$markerId'];
                      final num markerLatitude = num.parse(element['$markerLatitude']);
                      final num markerLongitude = num.parse(element['$markerLongitude']);
                      final String? markerIconUrl = element['$markerIconUrl'];
                      final num markerIconWidth = num.parse(element['$markerIconWidth'] ?? '70');
                      BitmapDescriptor? markerIcon;

                      if(markerIconUrl != null) {
                        final File markerImageFile = await DefaultCacheManager()
                            .getSingleFile(markerIconUrl);
                        final Uint8List markerImageBytes = await markerImageFile
                            .readAsBytes();

                        Codec codec = await instantiateImageCodec(
                            markerImageBytes, targetWidth: markerIconWidth?.toInt());

                        final FrameInfo frameInfo = await codec.getNextFrame();
                        final ByteData? byteData = await frameInfo.image
                            .toByteData(
                          format: ImageByteFormat.png,
                        );

                        final Uint8List resizedMarkerImageBytes = byteData!
                            .buffer.asUint8List();

                        markerIcon = BitmapDescriptor.fromBytes(
                            resizedMarkerImageBytes);
                      }
                      if(markerDrawPath) {
                                    Location location = Location();
                                    final userLocation = await location.getLocation();

                                    final mLat = markerLatitude.toDouble();
                                    final mLon = markerLongitude.toDouble();

                                    PolylinePoints polylinePoints =
                                        PolylinePoints();

                                    PolylineResult result = await polylinePoints
                                        .getRouteBetweenCoordinates(
                                      '$googleMapsKey',
                                      PointLatLng(userLocation.latitude!, userLocation.longitude!),
                                      PointLatLng(
                                        mLat,
                                        mLon,
                                      ),
                                    );

                                    if (result.points.isNotEmpty) {
                                      polyLines.add(
                                        Polyline(
                                          polylineId: PolylineId(markerId),
                                          points: result.points
                                              .map(
                                                (e) => LatLng(
                                                  e.latitude,
                                                  e.longitude,
                                                ),
                                              )
                                              .toList(),
                                        ),
                                      );
                                    }
                                    }
                      final mLat = markerLatitude.toDouble();
                      final mLon = markerLongitude.toDouble();
                      mapMarkers.add(
                        Marker(
                          markerId: MarkerId(markerId),
                          position: LatLng(mLat, mLon,),
                          icon: markerIcon ?? BitmapDescriptor.defaultMarker,
                          onTap: () {},
                        ),
                      );
                      } catch (e) {
                       print('Marker: \$element failed.');
                      }
                    }
                    return fp.Tuple2(polyLines, mapMarkers);
                  } catch (e) {
                    return const fp.Tuple2(<Polyline>{}, <Marker>{});
                  }
                }),
                initialData: fp.Tuple2(<Polyline>{}, <Marker>{}),
                builder: (BuildContext context, AsyncSnapshot<fp.Tuple2<Set<Polyline>, Set<Marker>>> snapshot) {
                 final mapConfig =
                        ((datasets['$mapConfigDatasetName'] as List<dynamic>?) ??
                            <dynamic>[])[0];
                 final num initialPositionLat = num.parse(mapConfig['$initialPositionLat'] ?? '41.889221');
                 final num initialPositionLng = num.parse(mapConfig['$initialPositionLng'] ?? '12.493421');
                 final double initialZoom = double.parse(mapConfig['$initialZoomLevel'] as String? ?? '15.0');
                  return GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                        initialPositionLat.toDouble(),
                        initialPositionLng.toDouble(),
                      ),
                      zoom: initialZoom,
                    ),
                    polylines: snapshot.data?.value1 ?? <Polyline>{},
                    markers: snapshot.data?.value2 ?? <Marker>{},
                    onMapCreated: (cnt) {
                              $mapControllerName.complete(cnt);
                              cnt.setMapStyle(mapConfig['$customMapStyle'] ?? '');
                     },
                  );
                })
 ''';
    final res = FormatterTest.format(code);
    if (res) {
      return code;
    } else {
      return 'const SizedBox()';
    }
  }
}
