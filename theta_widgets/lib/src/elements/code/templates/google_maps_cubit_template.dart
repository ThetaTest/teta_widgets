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
class ${googleMapsCubitName.replaceAll(' ', '')}Cubit extends Cubit<${googleMapsCubitName.replaceAll(' ', '')}State> {
  ${googleMapsCubitName.replaceAll(' ', '')}Cubit({final ${googleMapsCubitName.replaceAll(' ', '')}State? initialState})
      : super(
          initialState ??
              const ${googleMapsCubitName.replaceAll(' ', '')}InitialState(
                ${googleMapsCubitName.replaceAll(' ', '')}UiModel(
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

      final isLocationEnabled = await Geolocator.isLocationServiceEnabled();
      Position? location;
      if(isLocationEnabled) {
      await Geolocator.requestPermission();
     location = await Geolocator.getCurrentPosition();
      
      if (trackMyLocation) {
        await tracking?.cancel();
        tracking = Geolocator.getPositionStream().listen(
          (final event) async {
            if (event.latitude != null) {
              // emit new location
              unawaited(
                _buildMarkersAndPath(
                  markersDataset: markersDataset,
                  initialPositionLat: event.latitude,
                  initialPositionLng: event.longitude,
                  zoom: initialZoom,
                  mapStyle: mapStyle,
                  userLocationLat: event.latitude,
                  userLocationLng: event.longitude,
                  googleMapsKey: googleMapsKey,
                  moveCameraToUserLocation: true,
                ),
              );
            }
          },
        );
      } else {
        await tracking?.cancel();
      }
    }
      await _buildMarkersAndPath(
        markersDataset: markersDataset,
        initialPositionLat: initialPositionLat,
        initialPositionLng: initialPositionLng,
        zoom: initialZoom,
        mapStyle: mapStyle,
        userLocationLat: location?.latitude ?? initialPositionLat.toDouble(),
        userLocationLng: location?.longitude ?? initialPositionLng.toDouble(),
        googleMapsKey: googleMapsKey,
        moveCameraToUserLocation: trackMyLocation,
      );
    } catch (e) {
      emit(
        ${googleMapsCubitName.replaceAll(' ', '')}ErrorState(
          ${googleMapsCubitName.replaceAll(' ', '')}UiModel(
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
    required final bool moveCameraToUserLocation,
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
                      .toList() as List<LatLng>,
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
      ${googleMapsCubitName.replaceAll(' ', '')}LoadedState(
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
   if(moveCameraToUserLocation) {
      onEmitNewCameraPosition(
        userLocationLat,
        userLocationLng,
        zoom,
      );
    }
  }

  void onEmitReloadDataState() {
    emit(
      ${googleMapsCubitName.replaceAll(' ', '')}ReloadDataState(
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
      ${googleMapsCubitName.replaceAll(' ', '')}SetNewCameraPositionState(
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
      ${googleMapsCubitName.replaceAll(' ', '')}ChangeMapStyleState(
        state.uiModel.copyWith(style: style),
      ),
    );
  }

  void onEmitNewMarkers(final Set<Marker> markers) {
    emit(
      ${googleMapsCubitName.replaceAll(' ', '')}ReloadMarkersState(
        state.uiModel.copyWith(
          markers: markers,
        ),
      ),
    );
  }
}

class ${googleMapsCubitName.replaceAll(' ', '')}UiModel extends Equatable {
  const ${googleMapsCubitName.replaceAll(' ', '')}UiModel({
    required this.paths,
    required this.markers,
    required this.cameraPosition,
    required this.style,
  });

  final Set<Polyline> paths;
  final Set<Marker> markers;
  final CameraPosition cameraPosition;
  final String style;

  ${googleMapsCubitName.replaceAll(' ', '')}UiModel copyWith({
    final Set<Polyline>? paths,
    final Set<Marker>? markers,
    final CameraPosition? cameraPosition,
    final double? initialZoom,
    final String? style,
    final bool? isError,
    final bool? isInitialState,
  }) =>
      ${googleMapsCubitName.replaceAll(' ', '')}UiModel(
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

abstract class ${googleMapsCubitName.replaceAll(' ', '')}State extends Equatable {
  const ${googleMapsCubitName.replaceAll(' ', '')}State(this.uiModel);

  final ${googleMapsCubitName.replaceAll(' ', '')}UiModel uiModel;

  @override
  List<Object?> get props => [uiModel];
}

class ${googleMapsCubitName.replaceAll(' ', '')}InitialState extends ${googleMapsCubitName.replaceAll(' ', '')}State {
  const ${googleMapsCubitName.replaceAll(' ', '')}InitialState(final ${googleMapsCubitName.replaceAll(' ', '')}UiModel uiModel)
      : super(uiModel);
}

class ${googleMapsCubitName.replaceAll(' ', '')}ReloadDataState extends ${googleMapsCubitName.replaceAll(' ', '')}State {
  const ${googleMapsCubitName.replaceAll(' ', '')}ReloadDataState(final ${googleMapsCubitName.replaceAll(' ', '')}UiModel uiModel)
      : super(uiModel);
}

class ${googleMapsCubitName.replaceAll(' ', '')}LoadedState extends ${googleMapsCubitName.replaceAll(' ', '')}State {
  const ${googleMapsCubitName.replaceAll(' ', '')}LoadedState(final ${googleMapsCubitName.replaceAll(' ', '')}UiModel uiModel) : super(uiModel);
}

class ${googleMapsCubitName.replaceAll(' ', '')}ErrorState extends ${googleMapsCubitName.replaceAll(' ', '')}State {
  const ${googleMapsCubitName.replaceAll(' ', '')}ErrorState(final ${googleMapsCubitName.replaceAll(' ', '')}UiModel uiModel) : super(uiModel);
}

class ${googleMapsCubitName.replaceAll(' ', '')}SetNewCameraPositionState extends ${googleMapsCubitName.replaceAll(' ', '')}State {
  const ${googleMapsCubitName.replaceAll(' ', '')}SetNewCameraPositionState(final ${googleMapsCubitName.replaceAll(' ', '')}UiModel uiModel)
      : super(uiModel);
}

//Need to rebuild widget for this
class ${googleMapsCubitName.replaceAll(' ', '')}ReloadMarkersState extends ${googleMapsCubitName.replaceAll(' ', '')}State {
  const ${googleMapsCubitName.replaceAll(' ', '')}ReloadMarkersState(final ${googleMapsCubitName.replaceAll(' ', '')}UiModel uiModel)
      : super(uiModel);
}

//Need to rebuild widget for this
class ${googleMapsCubitName.replaceAll(' ', '')}ReloadPolyLinesState extends ${googleMapsCubitName.replaceAll(' ', '')}State {
  const ${googleMapsCubitName.replaceAll(' ', '')}ReloadPolyLinesState(final ${googleMapsCubitName.replaceAll(' ', '')}UiModel uiModel)
      : super(uiModel);
}

class ${googleMapsCubitName.replaceAll(' ', '')}ChangeMapStyleState extends ${googleMapsCubitName.replaceAll(' ', '')}State {
  const ${googleMapsCubitName.replaceAll(' ', '')}ChangeMapStyleState(final ${googleMapsCubitName.replaceAll(' ', '')}UiModel uiModel)
      : super(uiModel);
}
    ''';
  }
}
