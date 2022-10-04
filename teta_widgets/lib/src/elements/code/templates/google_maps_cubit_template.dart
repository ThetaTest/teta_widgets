import 'package:teta_widgets/src/elements/widgets/google_maps/maps/map_style.dart';

class GoogleMapsCubitTemplate {
  static String toCode({
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
    required final String googleMapsKey,
    required final String googleMapsCubitName,
    required final String pathColor,
  }) {
    final style = getMapToCodeName(customMapStyle);

    return '''
class ${googleMapsCubitName}Cubit extends Cubit<${googleMapsCubitName}State> {
  ${googleMapsCubitName}Cubit({final ${googleMapsCubitName}State? initialState})
      : super(
          initialState ??
              const ${googleMapsCubitName}InitialState(
                ${googleMapsCubitName}UiModel(
                  paths: <Polyline>{},
                  markers: <Marker>{},
                  cameraPosition: CameraPosition(
                    target: LatLng(
                      0,
                      0,
                    ),
                    zoom: 10,
                  ),
                  style: constantz.$style,
                ),
              ),
        ) {
    onEmitReloadDataState();
  }

  StreamSubscription? tracking;

  Future<void> onLoadData(
    final List<dynamic> markersDataset,
  ) async {
    try {
      final num initialPositionLat = $initialPositionLat;
      final num initialPositionLng = $initialPositionLng;
      final double initialZoom = $initialZoomLevel;
      final String mapStyle = constantz.$style;
      final bool trackMyLocation = $trackMyLocation;
      final String googleMapsKey = '$googleMapsKey';

      onEmitNewCameraPosition(
        initialPositionLat.toDouble(),
        initialPositionLng.toDouble(),
        initialZoom,
      );
      onEmitNewMapStyle(mapStyle);

      await Geolocator.requestPermission();
      final location = await Geolocator.getCurrentPosition(
      );
      
      if (trackMyLocation) {
        await tracking?.cancel();
        tracking = Geolocator.getPositionStream().listen(
          (final event) async {
            if (event.latitude != null) {
              // emit new location
              unawaited(
                _buildMarkersAndPath(
                  markersDataset: markersDataset,
                  initialPositionLat: initialPositionLat,
                  initialPositionLng: initialPositionLng,
                  zoom: initialZoom,
                  mapStyle: mapStyle,
                  userLocationLat: event.latitude,
                  userLocationLng: event.longitude,
                  googleMapsKey: googleMapsKey,
                ),
              );
            }
          },
        );
      } else {
        await tracking?.cancel();
      }

      await _buildMarkersAndPath(
        markersDataset: markersDataset,
        initialPositionLat: initialPositionLat,
        initialPositionLng: initialPositionLng,
        zoom: initialZoom,
        mapStyle: mapStyle,
        userLocationLat: location.latitude ?? initialPositionLat.toDouble(),
        userLocationLng: location.longitude ?? initialPositionLng.toDouble(),
        googleMapsKey: googleMapsKey,
      );
    } catch (e) {
      emit(
        ${googleMapsCubitName}ErrorState(
          ${googleMapsCubitName}UiModel(
            paths: state.uiModel.paths,
            markers: state.uiModel.markers,
            cameraPosition: state.uiModel.cameraPosition,
            style: state.uiModel.style,
          ),
        ),
      );
    }
  }

  Future<void> _buildMarkersAndPath({
    required final List<dynamic> markersDataset,
    required final num initialPositionLat,
    required final num initialPositionLng,
    required final double zoom,
    required final String mapStyle,
    required final double userLocationLat,
    required final double userLocationLng,
    required final String googleMapsKey,
  }) async {
    final polyLines = <Polyline>{};
    final mapMarkers = <Marker>{};

    try {
      if ($showMyLocationMarker) {
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
      print('Google Maps Show My Location Error.');
      print(e);
      print(st);
    }

    for (final element in markersDataset) {
      try {
        final markerDrawPath =
            ((element['$markerDrawPath']
                            as String?) ??
                        'false')
                    .toLowerCase() ==
                'true';
        final markerId = element['$markerId'] as String;
        final markerLatitude =
            num.parse(element['$markerLatitude'] as String);
        final markerLongitude =
            num.parse(element['$markerLongitude'] as String);
        final markerIconUrl = element['$markerIconUrl'] as String?;
        final markerIconWidth =
            num.parse(element['$markerIconWidth'] as String? ?? '70');
        BitmapDescriptor? markerIcon;

        try {
          if (markerIconUrl != null) {
          final File markerImageFile =
              await DefaultCacheManager().getSingleFile(markerIconUrl);
          final Uint8List markerImageBytes =
              await markerImageFile.readAsBytes();

          Codec codec = await instantiateImageCodec(markerImageBytes,
              targetWidth: markerIconWidth.toInt());

          final FrameInfo frameInfo = await codec.getNextFrame();
          final ByteData? byteData = await frameInfo.image.toByteData(
            format: ImageByteFormat.png,
          );

          final Uint8List resizedMarkerImageBytes =
              byteData!.buffer.asUint8List();

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
            );

            if (result.points.isNotEmpty) {
              polyLines.add(
                Polyline(
                  color: const Color(0x006A56B0),
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
              //
            },
          ),
        );
      } catch (e, st) {
        print('Marker: \$element failed. with error: \$e \$st');
      }
    }

    emit(
      ${googleMapsCubitName}LoadedState(
        state.uiModel.copyWith(
          paths: polyLines,
          markers: mapMarkers,
          cameraPosition: CameraPosition(
            target: LatLng(
              initialPositionLat.toDouble(),
              initialPositionLng.toDouble(),
            ),
            zoom: zoom,
          ),
          style: mapStyle,
        ),
      ),
    );
  }

  void onEmitReloadDataState() {
    emit(
      ${googleMapsCubitName}ReloadDataState(
        state.uiModel,
      ),
    );
  }

  void onEmitNewCameraPosition(
    final double lat,
    final double lng,
    final double zoom,
  ) {
    emit(
      ${googleMapsCubitName}SetNewCameraPositionState(
        state.uiModel.copyWith(
          cameraPosition: CameraPosition(
            target: LatLng(
              lat,
              lng,
            ),
            zoom: zoom,
          ),
        ),
      ),
    );
  }

  void onEmitNewMapStyle(final String style) {
    emit(
      ${googleMapsCubitName}ChangeMapStyleState(
        state.uiModel.copyWith(style: style),
      ),
    );
  }

  void onEmitNewMarkers(final Set<Marker> markers) {
    emit(
      ${googleMapsCubitName}ReloadMarkersState(
        state.uiModel.copyWith(
          markers: markers,
        ),
      ),
    );
  }
}

class ${googleMapsCubitName}UiModel extends Equatable {
  const ${googleMapsCubitName}UiModel({
    required this.paths,
    required this.markers,
    required this.cameraPosition,
    required this.style,
  });

  final Set<Polyline> paths;
  final Set<Marker> markers;
  final CameraPosition cameraPosition;
  final String style;

  ${googleMapsCubitName}UiModel copyWith({
    final Set<Polyline>? paths,
    final Set<Marker>? markers,
    final CameraPosition? cameraPosition,
    final double? initialZoom,
    final String? style,
    final bool? isError,
    final bool? isInitialState,
  }) =>
      ${googleMapsCubitName}UiModel(
        paths: paths ?? this.paths,
        markers: markers ?? this.markers,
        cameraPosition: cameraPosition ?? this.cameraPosition,
        style: style ?? this.style,
      );

  @override
  String toString() {
    return 'paths: \$paths\\n'
        'markers: \$markers\\n'
        'initialCameraPosition: \$cameraPosition\\n';
  }

  @override
  List<Object?> get props => [
        paths,
        markers,
        cameraPosition,
        style,
      ];
}

abstract class ${googleMapsCubitName}State extends Equatable {
  const ${googleMapsCubitName}State(this.uiModel);

  final ${googleMapsCubitName}UiModel uiModel;

  @override
  List<Object?> get props => [uiModel];
}

class ${googleMapsCubitName}InitialState extends ${googleMapsCubitName}State {
  const ${googleMapsCubitName}InitialState(final ${googleMapsCubitName}UiModel uiModel)
      : super(uiModel);
}

class ${googleMapsCubitName}ReloadDataState extends ${googleMapsCubitName}State {
  const ${googleMapsCubitName}ReloadDataState(final ${googleMapsCubitName}UiModel uiModel)
      : super(uiModel);
}

class ${googleMapsCubitName}LoadedState extends ${googleMapsCubitName}State {
  const ${googleMapsCubitName}LoadedState(final ${googleMapsCubitName}UiModel uiModel) : super(uiModel);
}

class ${googleMapsCubitName}ErrorState extends ${googleMapsCubitName}State {
  const ${googleMapsCubitName}ErrorState(final ${googleMapsCubitName}UiModel uiModel) : super(uiModel);
}

class ${googleMapsCubitName}SetNewCameraPositionState extends ${googleMapsCubitName}State {
  const ${googleMapsCubitName}SetNewCameraPositionState(final ${googleMapsCubitName}UiModel uiModel)
      : super(uiModel);
}

//Need to rebuild widget for this
class ${googleMapsCubitName}ReloadMarkersState extends ${googleMapsCubitName}State {
  const ${googleMapsCubitName}ReloadMarkersState(final ${googleMapsCubitName}UiModel uiModel)
      : super(uiModel);
}

//Need to rebuild widget for this
class ${googleMapsCubitName}ReloadPolyLinesState extends ${googleMapsCubitName}State {
  const ${googleMapsCubitName}ReloadPolyLinesState(final ${googleMapsCubitName}UiModel uiModel)
      : super(uiModel);
}

class ${googleMapsCubitName}ChangeMapStyleState extends ${googleMapsCubitName}State {
  const ${googleMapsCubitName}ChangeMapStyleState(final ${googleMapsCubitName}UiModel uiModel)
      : super(uiModel);
}
    ''';
  }
}
