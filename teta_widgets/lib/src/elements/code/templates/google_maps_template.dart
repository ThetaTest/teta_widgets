// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_core/teta_core.dart';

// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Map Template

class GoogleMapsTemplate {
  static String toCode({
    required final String mapControllerName,
    required final String mapConfigDatasetName,
    required final String markersDatasetName,
    required final String markerId,
    required final String markerLatitude,
    required final String markerLongitude,
    required final String markerIconUrl,
    required final String markerIconWidth,
    required final String customMapStyle,
    required final String initialPositionLng,
    required final String initialPositionLat,
  }) {
    return '''
    FutureBuilder<Set<Marker>>(
                future: Future.delayed(Duration.zero, () async {
                  try {
                    final markersDataset =
                        ((datasets['$markersDatasetName'] as List<dynamic>?) ??
                            <dynamic>[]);
                    final mapMarkers = Set<Marker>();

                    for (final element in markersDataset) {
                      final String markerId = element['$markerId'];
                      final num markerLatitude = num.parse(element['$markerLatitude'] ?? '0');
                      final num markerLongitude = num.parse(element['$markerLongitude'] ?? '0');
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

                      mapMarkers.add(
                        Marker(
                          markerId: MarkerId(markerId),
                          position: LatLng(markerLatitude.toDouble(), markerLongitude.toDouble()),
                          icon: markerIcon ?? BitmapDescriptor.defaultMarker,
                          onTap: () {},
                        ),
                      );
                    }
                    return mapMarkers;
                  } catch (e) {
                    return Set<Marker>();
                  }
                }),
                initialData: Set<Marker>(),
                builder: (BuildContext context,
                    AsyncSnapshot<Set<Marker>> snapshot) {
                 final mapConfig =
                        ((datasets['$mapConfigDatasetName'] as List<dynamic>?) ??
                            <dynamic>[])[0];
                 final num initialPositionLat = num.parse(mapConfig['$initialPositionLat'] ?? '41.889221');
                 final num initialPositionLng = num.parse(mapConfig['$initialPositionLng'] ?? '12.493421');
                 
                  return GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                        initialPositionLat.toDouble(),
                        initialPositionLng.toDouble(),
                      ),
                      zoom: 15
                    ),
                    markers: snapshot.data ?? Set<Marker>(),
                    onMapCreated: (cnt) {
                              $mapControllerName.complete(cnt);
                              cnt.setMapStyle(mapConfig['$customMapStyle'] ?? '');
                     },
                  );
                })
 ''';
  }
}
