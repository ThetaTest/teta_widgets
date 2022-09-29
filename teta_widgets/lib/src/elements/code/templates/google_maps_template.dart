// Flutter imports:
import 'package:flutter/material.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';
import 'package:teta_widgets/src/elements/widgets/google_maps/maps/map_style.dart';

// Project imports:

/// Map Template

class GoogleMapsTemplate {
  static String toCodeOnInit({
    required final String mapControllerName,
    required final String markersDatasetName,
    required final String markerId,
    required final String markerLatitude,
    required final String markerLongitude,
    required final String markerIconUrl,
    required final String markerIconWidth,
    required final String markerDrawPath,
    required final MapStyle customMapStyle,
    required final String initialPositionLng,
    required final String initialPositionLat,
    required final bool showMyLocationMarker,
    required final bool trackMyLocation,
    required final String initialZoomLevel,
    required final String googleMapsBlocName,
    required final String pathColor,
  }) {
    return '';
  }

  static Future<String> toCode({
    required final BuildContext context,
    required final String mapControllerName,
    required final String markersDatasetName,
    required final String markerId,
    required final String markerLatitude,
    required final String markerLongitude,
    required final String markerIconUrl,
    required final String markerIconWidth,
    required final String markerDrawPath,
    required final MapStyle customMapStyle,
    required final String initialPositionLng,
    required final String initialPositionLat,
    required final bool showMyLocationMarker,
    required final bool trackMyLocation,
    required final String initialZoomLevel,
    required final String googleMapsBlocName,
    required final String pathColor,
  }) async {
    final code = '''
BlocConsumer<${googleMapsBlocName}Cubit, ${googleMapsBlocName}State>(
                          bloc: $googleMapsBlocName,
                          buildWhen: (final p, final c) {
                               return !c.isSetNewCameraPositionState;
                          },
                          builder:
                              (BuildContext context, ${googleMapsBlocName}State state) {
                            if (state.isInitialState) {
                              final markersDataset =
                                  ((datasets['$markersDatasetName'] as List<dynamic>?) ??
                                      <dynamic>[]);
                              ${googleMapsBlocName}.onInitialState(
                                markersDataset,
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
                              (BuildContext context, ${googleMapsBlocName}State state) async {
                            if (state.isInitialState) {
                              final markersDataset =
                                  ((datasets['$markersDatasetName'] as List<dynamic>?) ??
                                      <dynamic>[]);
                              ${googleMapsBlocName}.onInitialState(
                                markersDataset,
                              );
                            } else if (state.isSetNewCameraPositionState) {
                              await (await $mapControllerName.future).animateCamera(CameraUpdate.newCameraPosition(state.initialCameraPosition,),);
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

  static void testCode() {}
}
