class GoogleMapsCubitTemplate {
  static String toCode({
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
    required final String googleMapsKey,
    required final String googleMapsBlocName,
  }) {
    return '''
    class ${googleMapsBlocName}Cubit extends Cubit<${googleMapsBlocName}State> {
  ${googleMapsBlocName}Cubit({${googleMapsBlocName}State? initialState})
      : super(
          initialState ??
              ${googleMapsBlocName}State(
                paths: <Polyline>{},
                markers: <Marker>{},
                initialCameraPosition: const CameraPosition(
                  target: LatLng(
                    0,
                    0,
                  ),
                ),
                initialZoom: 7,
                isError: false,
                mapStyle: '',
                isInitialState: true,
              ),
        );

  void onInitialState(
      List<dynamic> markersDataset, Map<String, dynamic> mapConfig) async {
    try {
      final num initialPositionLat =
          num.parse(mapConfig['$initialPositionLat'] ?? '41.889221');
      final num initialPositionLng =
          num.parse(mapConfig['$initialPositionLng'] ?? '12.493421');
      final double initialZoom =
          double.parse(mapConfig['$initialZoomLevel'] as String? ?? '7.0');
      final String mapStyle = mapConfig['$customMapStyle'] ?? '';

      final mapMarkers = Set<Marker>();
      final bool trackMyLocation = $trackMyLocation;

      Location location = Location();
      await location.requestPermission();
      await location.requestService();
      // await Future.delayed(const Duration(seconds: 2));
      // final userLocation = await location.getLocation();
      if (trackMyLocation) {
        location.onLocationChanged.listen((event) {
          // emit new location
          _buildMarkersAndPath(
            markersDataset: markersDataset,
            mapConfig: mapConfig,
            mapMarkers: mapMarkers,
            initialPositionLat: initialPositionLat,
            initialPositionLng: initialPositionLng,
            initialZoom: initialZoom,
            mapStyle: mapStyle,
            userLocationLat: event.latitude!,
            userLocationLng: event.longitude!,
          );
        });
      }

      _buildMarkersAndPath(
        markersDataset: markersDataset,
        mapConfig: mapConfig,
        mapMarkers: mapMarkers,
        initialPositionLat: initialPositionLat,
        initialPositionLng: initialPositionLng,
        initialZoom: initialZoom,
        mapStyle: mapStyle,
        userLocationLat: 41.889221,
        userLocationLng: 12.493421,
      );
    } catch (e) {
      emit(
        ${googleMapsBlocName}State(
          paths: <Polyline>{},
          markers: <Marker>{},
          initialCameraPosition: const CameraPosition(
            target: LatLng(
              0,
              0,
            ),
          ),
          initialZoom: 10,
          isError: true,
          mapStyle: '',
          isInitialState: false,
        ),
      );
    }
  }

  void _buildMarkersAndPath({
    required List<dynamic> markersDataset,
    required Map<String, dynamic> mapConfig,
    required Set<Marker> mapMarkers,
    required num initialPositionLat,
    required num initialPositionLng,
    required double initialZoom,
    required String mapStyle,
    required double userLocationLat,
    required double userLocationLng,
  }) async {
    final polyLines = <Polyline>{};
    final bool showMyLocationMarker = $showMyLocationMarker;

    try {
      if (showMyLocationMarker) {
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
        final bool markerDrawPath =
            ((element['$markerDrawPath'] as String?) ?? 'false').toLowerCase() ==
                'true';
        final String markerId = element['$markerId'];
        final num markerLatitude = num.parse(element['$markerLatitude']);
        final num markerLongitude = num.parse(element['$markerLongitude']);
        final String? markerIconUrl = element['$markerIconUrl'];
        final num markerIconWidth = num.parse(element['$markerIconWidth'] ?? '70');
        BitmapDescriptor? markerIcon;

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
        try {
          if (markerDrawPath) {
            final mLat = markerLatitude.toDouble();
            final mLon = markerLongitude.toDouble();

            PolylinePoints polylinePoints = PolylinePoints();

            PolylineResult result =
                await polylinePoints.getRouteBetweenCoordinates(
              '$googleMapsKey',
              PointLatLng(userLocationLat, userLocationLng),
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
            onTap: () {},
          ),
        );
      } catch (e) {
        print('Marker: \$element failed.');
      }
    }
    emit(
      ${googleMapsBlocName}State(
        paths: polyLines,
        markers: mapMarkers,
        initialCameraPosition: CameraPosition(
          target: LatLng(
            initialPositionLat.toDouble(),
            initialPositionLng.toDouble(),
          ),
        ),
        initialZoom: initialZoom,
        mapStyle: mapStyle,
        isError: false,
        isInitialState: false,
      ),
    );
  }
}

class ${googleMapsBlocName}State {
  final Set<Polyline> paths;
  final Set<Marker> markers;
  final CameraPosition initialCameraPosition;
  final double initialZoom;
  final String mapStyle;
  final bool isError;
  final bool isInitialState;

  ${googleMapsBlocName}State({
    required this.paths,
    required this.markers,
    required this.initialCameraPosition,
    required this.initialZoom,
    required this.mapStyle,
    required this.isError,
    required this.isInitialState,
  });

  ${googleMapsBlocName}State copyWith({
    Set<Polyline>? paths,
    Set<Marker>? markers,
    CameraPosition? initialCameraPosition,
    double? initialZoom,
    String? mapStyle,
    bool? isError,
    bool? isInitialState,
  }) =>
      ${googleMapsBlocName}State(
        paths: paths ?? this.paths,
        markers: markers ?? this.markers,
        initialCameraPosition:
            initialCameraPosition ?? this.initialCameraPosition,
        initialZoom: initialZoom ?? this.initialZoom,
        mapStyle: mapStyle ?? this.mapStyle,
        isError: isError ?? this.isError,
        isInitialState: isInitialState ?? this.isInitialState,
      );
}
    ''';
  }
}
