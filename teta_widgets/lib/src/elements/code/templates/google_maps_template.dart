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
    required final String googleMapsCubitName,
    required final String pathColor,
  }) async {
    final style = getMapToCodeName(customMapStyle);
    final code = '''
    BlocConsumer<${googleMapsCubitName}Cubit, ${googleMapsCubitName}State>(
  bloc: $googleMapsCubitName,
  builder: (final BuildContext context, final ${googleMapsCubitName}State state) {
    if (state is ${googleMapsCubitName}InitialState) {
      $googleMapsCubitName.onEmitReloadDataState();
      return const CircularProgressIndicator();
    } else if (state is ${googleMapsCubitName}ErrorState) {
      return Container();
    } else {
      return GoogleMap(
        initialCameraPosition: state.uiModel.cameraPosition,
        polylines: state.uiModel.paths,
        markers: state.uiModel.markers,
        onMapCreated: (final cnt) {
          $mapControllerName.complete(cnt);

          $googleMapsCubitName
            ..onEmitNewMapStyle(constantz.$style)
            ..onEmitReloadDataState();
        },
      );
    }
  },
  buildWhen: (final p, final c) {
    final build = c is! ${googleMapsCubitName}SetNewCameraPositionState &&
        c is! ${googleMapsCubitName}ChangeMapStyleState &&
        c is! ${googleMapsCubitName}ReloadDataState;
    return build;
  },
  listener: (
    final BuildContext context,
    final ${googleMapsCubitName}State state,
  ) async {
  
     if (state is ${googleMapsCubitName}InitialState) {
      $googleMapsCubitName.onEmitReloadDataState();
    }
    
    if (state is ${googleMapsCubitName}SetNewCameraPositionState) {
      if ($mapControllerName.isCompleted) {
        await (await $mapControllerName.future).animateCamera(
          CameraUpdate.newCameraPosition(
            state.uiModel.cameraPosition,
          ),
        );
      }
    } else if (state is ${googleMapsCubitName}ChangeMapStyleState) {
      if ($mapControllerName.isCompleted) {
        await (await $mapControllerName.future)
            .setMapStyle(state.uiModel.style);
      }
    } else if (state is ${googleMapsCubitName}ReloadDataState) {
      List<dynamic> markersDataset;
      try {
        markersDataset =
            ((datasets['$markersDatasetName'] as List<dynamic>?) ?? <dynamic>[]);
      } catch (e) {
        markersDataset = [];
      }

      await $googleMapsCubitName.onLoadData(
        markersDataset,
      );
    }
  },
);
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
