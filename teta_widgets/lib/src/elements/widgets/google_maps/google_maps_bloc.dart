import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:teta_cms/teta_cms.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/widgets/google_maps/maps/map_style.dart';

class GoogleMapsBloc extends Cubit<GoogleMapsState> {
  GoogleMapsBloc({final GoogleMapsState? initialState})
      : super(
          initialState ??
              const GoogleMapsState(
                paths: <Polyline>{},
                markers: <Marker>{},
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                    0,
                    0,
                  ),
                  zoom: 13,
                ),
                initialZoom: 13,
                isError: false,
                mapStyle: '',
                isInitialState: true,
                isSetNewCameraPositionState: false,
              ),
        );

  Future<void> onLoadData(
    final List<dynamic> markersDataset,
    final GoogleMapsConfigNames configNames,
    final List<DatasetObject> datasets,
    final BuildContext context,
  ) async {
    try {
      final initialPositionLat = num.parse(configNames.initialPositionLat);
      final initialPositionLng = num.parse(configNames.initialPositionLng);
      final initialZoom = double.parse(configNames.initialMapZoomLevel);
      final mapStyle = getMap(configNames.mapStyle);

      final mapMarkers = <Marker>{};

      final location = Location();
      final loc = await location.getLocation();
      await location.requestPermission();
      await location.requestService();
      if (configNames.trackMyLocation) {
        location.onLocationChanged.listen((final event) async {
          if (event.latitude != null) {
            // emit new location
            await location.changeSettings(interval: 10000, distanceFilter: 50);
            _buildMarkersAndPath(
              markersDataset: markersDataset,
              mapMarkers: mapMarkers,
              initialPositionLat: initialPositionLat,
              initialPositionLng: initialPositionLng,
              initialZoom: initialZoom,
              mapStyle: mapStyle,
              userLocationLat: event.latitude!,
              userLocationLng: event.longitude!,
              googleMapsKey: configNames.googleMapsKey,
              configNames: configNames,
              datasets: datasets,
            );
          }
        });
      }

      _buildMarkersAndPath(
        markersDataset: markersDataset,
        mapMarkers: mapMarkers,
        initialPositionLat: initialPositionLat,
        initialPositionLng: initialPositionLng,
        initialZoom: initialZoom,
        mapStyle: mapStyle,
        userLocationLat: loc.latitude ?? 41.889221,
        userLocationLng: loc.longitude ?? 12.493421,
        googleMapsKey: configNames.googleMapsKey,
        configNames: configNames,
        datasets: datasets,
      );
    } catch (e) {
      emit(
        GoogleMapsState(
          paths: state.paths,
          markers: state.markers,
          initialCameraPosition: state.initialCameraPosition,
          initialZoom: state.initialZoom,
          isError: true,
          mapStyle: state.mapStyle,
          isInitialState: false,
          isSetNewCameraPositionState: false,
        ),
      );
    }
  }

  void _buildMarkersAndPath({
    required final List<dynamic> markersDataset,
    required final Set<Marker> mapMarkers,
    required final num initialPositionLat,
    required final num initialPositionLng,
    required final double initialZoom,
    required final String mapStyle,
    required final double userLocationLat,
    required final double userLocationLng,
    required final String googleMapsKey,
    required final GoogleMapsConfigNames configNames,
    required final List<DatasetObject> datasets,
  }) async {
    final polyLines = <Polyline>{};
    final cms = TetaCMS.instance.client;

    try {
      if (configNames.showMyLocationMarker) {
        mapMarkers.add(
          Marker(
            markerId: const MarkerId('myLocation'),
            position: LatLng(
              userLocationLat,
              userLocationLng,
            ),
          ),
        );
      }
    } catch (e, st) {
      print(e);
      print(st);
    }
    for (final element in markersDataset) {
      try {
        final markerDrawPath =
            ((element[configNames.drawPathFromUserGeolocationToMarker]
                            as String?) ??
                        'false')
                    .toLowerCase() ==
                'true';
        final markerId = element[configNames.markerId] as String;
        final markerLatitude =
            num.parse(element[configNames.markerLocationLat] as String);
        final markerLongitude =
            num.parse(element[configNames.markerLoctionLng] as String);
        final markerIconUrl = element[configNames.markerIconUrl] as String?;
        final markerIconWidth =
            num.parse(element[configNames.markerIconWidth] as String? ?? '70');
        final markerIconHeight =
            num.parse(element[configNames.markerIconHeight] as String? ?? '70');
        BitmapDescriptor? markerIcon;

        try {
          if (markerIconUrl != null) {
            final markerImageFile = await http.get(Uri.parse(markerIconUrl));
            final codec = await instantiateImageCodec(
              markerImageFile.bodyBytes,
              targetWidth: markerIconWidth.toInt(),
              targetHeight: markerIconHeight.toInt(),
            );
            final frameInfo = await codec.getNextFrame();
            final byteData = await frameInfo.image.toByteData(
              format: ImageByteFormat.png,
            );
            final resizedMarkerImageBytes = byteData!.buffer.asUint8List();
            markerIcon = BitmapDescriptor.fromBytes(resizedMarkerImageBytes);
          }
        } catch (e, st) {
          print(e);
          print(st);
        }
        try {
          if (markerDrawPath) {
            final mLat = markerLatitude.toDouble();
            final mLon = markerLongitude.toDouble();

            final polylinePoints = PolylinePoints();

            final result = await polylinePoints.getRouteBetweenCoordinates(
              googleMapsKey,
              PointLatLng(userLocationLat, userLocationLng),
              PointLatLng(
                mLat,
                mLon,
              ),
              requestProxy:
                  (final String url, final Map<String, String> headers) async {
                return cms.proxy(url, headers);
              },
            );

            if (result.points.isNotEmpty) {
              polyLines.add(
                Polyline(
                  color: HexColor(configNames.pathColor),
                  polylineId: PolylineId(markerId),
                  points: result.points
                      .map(
                        (final e) => LatLng(
                          e.latitude,
                          e.longitude,
                        ),
                      )
                      .toList(),
                ),
              );
            }
          }
        } catch (e, st) {
          print(e);
          print(st);
        }
        final mLat = markerLatitude.toDouble();
        final mLon = markerLongitude.toDouble();
        mapMarkers.add(
          Marker(
            markerId: MarkerId(markerId),
            position: LatLng(
              mLat,
              mLon,
            ),
            icon: markerIcon ?? BitmapDescriptor.defaultMarker,
            onTap: () {
              // addDataset(context, datasets, _map);
            },
          ),
        );
      } catch (e, st) {
        print('Marker: $element failed. with error: $e $st');
      }
    }
    emit(
      GoogleMapsState(
        paths: polyLines,
        markers: mapMarkers,
        initialCameraPosition: CameraPosition(
          target: LatLng(
            initialPositionLat.toDouble(),
            initialPositionLng.toDouble(),
          ),
          zoom: initialZoom,
        ),
        initialZoom: initialZoom,
        mapStyle: mapStyle,
        isError: false,
        isInitialState: false,
        isSetNewCameraPositionState: false,
      ),
    );
    onEmitNewCameraPosition(initialPositionLat.toDouble(), initialPositionLng.toDouble(), initialZoom);
  }

  void onResetToInitialState() {
    emit(state.copyWith(isInitialState: true));
  }

  void onEmitNewCameraPosition(
    final double lat,
    final double lng,
    final double zoom,
  ) {
    emit(
      state.copyWith(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            lat,
            lng,
          ),
          zoom: zoom,
        ),
        isSetNewCameraPositionState: true,
      ),
    );
    emit(state.copyWith(isSetNewCameraPositionState: false));
  }
}

class GoogleMapsConfigNames {
  GoogleMapsConfigNames({
    required this.mapStyle,
    required this.initialPositionLat,
    required this.initialPositionLng,
    required this.initialMapZoomLevel,
    required this.showMyLocationMarker,
    required this.trackMyLocation,
    required this.markerId,
    required this.markerLocationLat,
    required this.markerLoctionLng,
    required this.markerIconUrl,
    required this.markerIconWidth,
    required this.markerIconHeight,
    required this.drawPathFromUserGeolocationToMarker,
    required this.googleMapsKey,
    required this.pathColor,
  });

// Maps Config
  final MapStyle mapStyle;
  final String initialPositionLat;
  final String initialPositionLng;
  final String initialMapZoomLevel;
  final bool showMyLocationMarker;
  final bool trackMyLocation;

// Markers Config
  final String markerId;
  final String markerLocationLat;
  final String markerLoctionLng;
  final String markerIconUrl;
  final String markerIconWidth;
  final String markerIconHeight;
  final String drawPathFromUserGeolocationToMarker;
  final String pathColor;

  // Keys
  final String googleMapsKey;
}

class GoogleMapsState extends Equatable {
  const GoogleMapsState({
    required this.paths,
    required this.markers,
    required this.initialCameraPosition,
    required this.initialZoom,
    required this.mapStyle,
    required this.isError,
    required this.isInitialState,
    required this.isSetNewCameraPositionState,
  });

  final Set<Polyline> paths;
  final Set<Marker> markers;
  final CameraPosition initialCameraPosition;
  final double initialZoom;
  final String mapStyle;
  final bool isError;
  final bool isInitialState;
  final bool isSetNewCameraPositionState;

  GoogleMapsState copyWith({
    final Set<Polyline>? paths,
    final Set<Marker>? markers,
    final CameraPosition? initialCameraPosition,
    final double? initialZoom,
    final String? mapStyle,
    final bool? isError,
    final bool? isInitialState,
    final bool? isSetNewCameraPositionState,
  }) =>
      GoogleMapsState(
        paths: paths ?? this.paths,
        markers: markers ?? this.markers,
        initialCameraPosition:
            initialCameraPosition ?? this.initialCameraPosition,
        initialZoom: initialZoom ?? this.initialZoom,
        mapStyle: mapStyle ?? this.mapStyle,
        isError: isError ?? this.isError,
        isInitialState: isInitialState ?? this.isInitialState,
        isSetNewCameraPositionState:
            isSetNewCameraPositionState ?? this.isSetNewCameraPositionState,
      );

  @override
  String toString() {
    return 'paths: $paths\n'
        'markers: $markers\n'
        'initialCameraPosition: $initialCameraPosition\n'
        'initialZoom: $initialZoom\n'
        'isError: $isError\n'
        'isInitialState: $isInitialState\n'
        'isSetNewCameraPositionState: $isSetNewCameraPositionState\n';
  }

  @override
  List<Object?> get props => [
        paths,
        markers,
        initialCameraPosition,
        initialZoom,
        mapStyle,
        isError,
        isInitialState,
        isSetNewCameraPositionState,
      ];
}
