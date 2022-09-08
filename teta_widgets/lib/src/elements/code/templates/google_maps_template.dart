// Flutter imports:
import 'package:flutter/material.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';

// Project imports:

/// Map Template

class GoogleMapsTemplate {
  static String toCodeOnInit({
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
    required final String googleMapsBlocName,
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
    required final String googleMapsBlocName,
  }) async {
    final code = '''
BlocConsumer<${googleMapsBlocName}Cubit, ${googleMapsBlocName}State>(
                          bloc: $googleMapsBlocName,
                          builder:
                              (BuildContext context, ${googleMapsBlocName}State state) {
                            if (state.isInitialState) {
                              final markersDataset =
                                  ((datasets['$markersDatasetName'] as List<dynamic>?) ??
                                      <dynamic>[]);
                              final mapConfig =
                                  ((datasets['$mapConfigDatasetName'] as List<dynamic>?) ??
                                      <dynamic>[])[0];
                              ${googleMapsBlocName}.onInitialState(
                                markersDataset,
                                mapConfig,
                              );
                              return const CircularProgressIndicator.adaptive();
                            } else if (state.isError) {
                              return Container();
                            } else {
                              return GoogleMap(
                                initialCameraPosition:
                                    state.initialCameraPosition,
                                polylines: state.paths,
                                markers: state.markers,
                                onMapCreated: (cnt) {
                                  $mapControllerName.complete(cnt);
                                  cnt.setMapStyle(state.mapStyle);
                                },
                              );
                            }
                          },
                          listener:
                              (BuildContext context, ${googleMapsBlocName}State state) {
                            if (state.isInitialState) {
                              final markersDataset =
                                  ((datasets['$markersDatasetName'] as List<dynamic>?) ??
                                      <dynamic>[]);
                              final mapConfig =
                                  ((datasets['$mapConfigDatasetName'] as List<dynamic>?) ??
                                      <dynamic>[])[0];
                              ${googleMapsBlocName}.onInitialState(
                                markersDataset,
                                mapConfig,
                              );
                            }
                          },
                        )
 ''';
    final res = FormatterTest.format(code);
    if (res) {
      return code;
    } else {
      return 'const SizedBox()';
    }
  }
}
