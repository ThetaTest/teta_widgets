// Flutter imports:
// ignore_for_file: unused_element, use_late_for_private_fields_and_variables

// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:teta_core/teta_core.dart';

// Project imports:
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/widgets/google_maps_base_widget.dart';
import 'package:universal_platform/universal_platform.dart';

// ignore_for_file: public_member_api_docs

class WGoogleMaps extends WGoogleMapsBase {
  /// Returns a [Map] widget in Teta
  const WGoogleMaps(
    final Key? key, {
    required this.node,
    required this.forPlay,
    required this.params,
    required this.states,
    required this.dataset,
    required this.mapControllerName,
    required this.mapConfigDatasetName,
    required this.markersDatasetName,
    required this.markerId,
    required this.markerLatitude,
    required this.markerLongitude,
    required this.markerIconUrl,
    required this.markerIconWidth,
    required this.customMapStyle,
    required this.initialPositionLng,
    required this.initialPositionLat,
    this.child,
    this.loop,
  }) : super(key: key);

  final CNode node;
  final CNode? child;
  final bool forPlay;
  final int? loop;

  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

  final String markersDatasetName;
  final String mapControllerName;
  final String mapConfigDatasetName;
  final String markerId;
  final String markerLatitude;
  final String markerLongitude;
  final String markerIconUrl;
  final String markerIconWidth;
  final String customMapStyle;
  final String initialPositionLng;
  final String initialPositionLat;

  @override
  State<WGoogleMaps> createState() => _WGoogleMapsState();
}

class _WGoogleMapsState extends State<WGoogleMaps> {
  bool isInitialized = false;
  VariableObject? variable;
  DatasetObject _map = DatasetObject(
    name: '',
    map: [<String, dynamic>{}],
  );
  Set<Marker> markers = <Marker>{};

  @override
  void initState() {
    super.initState();
    initMap();
  }

  @override
  Widget build(final BuildContext context) {
    if (isInitialized) {
      if (UniversalPlatform.isAndroid || UniversalPlatform.isIOS) {
        return _appMap(context);
      } else if (UniversalPlatform.isWeb) {
        return _appMap(context);
      } else {
        return _elseMap();
      }
    } else {
      return const Center(
        child: CircularProgressIndicator.adaptive(),
      );
    }
  }

  Widget _appMap(final BuildContext context) {
    Map<String, dynamic> mapConfig;
    try {
      mapConfig = widget.dataset
          .firstWhere(
            (final element) => element.getName == widget.mapConfigDatasetName,
      )
          .getMap[0];
    } catch (e) {
      mapConfig = <String, dynamic> {};
    }

    final initialPositionLat =
        num.parse(mapConfig[widget.initialPositionLat] as String? ?? '41.889221');
    final initialPositionLng =
        num.parse(mapConfig[widget.initialPositionLng] as String? ?? '12.493421');

    return GoogleMap(
      zoomControlsEnabled: false,
      myLocationButtonEnabled: false,
      initialCameraPosition: CameraPosition(
        target: LatLng(
          initialPositionLat.toDouble(),
          initialPositionLng.toDouble(),
        ),
        zoom: 15,
      ),
      markers: markers,
      onMapCreated: (cnt) {
        // $mapControllerName.complete(cnt);
        cnt.setMapStyle(mapConfig[widget.customMapStyle] as String?);
      },
    );
  }

  Widget _elseMap() => const Center(
        child: THeadline3(
          'This platform does not support this Google map plugin, yet.',
        ),
      );

  Future<void> initMap() async {
    try {
      final page = BlocProvider.of<FocusPageBloc>(context).state;

      _map = DatasetObject(
        name: widget.node.name ?? widget.node.intrinsicState.displayName,
        map: [<String, dynamic>{}],
      );

      final markersDataset = widget.dataset
          .firstWhere(
            (final element) => element.getName == widget.markersDatasetName,
          )
          .getMap;

      final mapMarkers = <Marker>{};

      for (final element in markersDataset) {
        final markerId = element[widget.markerId] as String;
        final markerLatitude = num.parse(element[widget.markerLatitude] as String? ?? '0');
        final markerLongitude = num.parse(element[widget.markerLongitude] as String? ?? '0');
        final markerIconUrl = element[widget.markerIconUrl] as String?;
        final markerIconWidth =
            num.parse(element[widget.markerIconWidth] as String? ?? '70');
        BitmapDescriptor? markerIcon;

        // if (markerIconUrl != null) {
        //   print('Markers0');
        //   final markerImageFile =
        //   await NetworkAssetBundle(Uri.parse(markerIconUrl)).load(markerIconUrl);
        //   print('Markers1');
        //
        //   final codec = await instantiateImageCodec(
        //     markerImageFile.buffer.asUint8List(),
        //     targetWidth: markerIconWidth.toInt(),
        //   );
        //   print('Markers2');
        //
        //   final frameInfo = await codec.getNextFrame();
        //   final byteData = await frameInfo.image.toByteData(
        //     format: ImageByteFormat.png,
        //   );
        //   print('Markers3');
        //
        //   final resizedMarkerImageBytes = byteData!.buffer.asUint8List();
        //   print('Markers4');
        //
        //   markerIcon = BitmapDescriptor.fromBytes(resizedMarkerImageBytes);
        //   print('Markers5');
        // }

        mapMarkers.add(
          Marker(
            markerId: MarkerId(markerId),
            position:
                LatLng(markerLatitude.toDouble(), markerLongitude.toDouble()),
            icon: markerIcon ?? BitmapDescriptor.defaultMarker,
            onTap: () {},
          ),
        );
      }
      setState(() {
        markers = mapMarkers;
        isInitialized = true;
      });
    } catch (e) {
      setState(() {
        markers = <Marker>{};
        isInitialized = true;
      });
    }
    // if (widget.controller.type == FTextTypeEnum.param) {
    //   variable = page.params
    //       .firstWhereOrNull((final e) => e.name == widget.controller.paramName);
    // } else {
    //   variable = page.states
    //       .firstWhereOrNull((final e) => e.name == widget.controller.stateName);
    // }
  }
}
