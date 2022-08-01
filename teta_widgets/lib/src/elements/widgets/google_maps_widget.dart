// Flutter imports:
// ignore_for_file: unused_element, use_late_for_private_fields_and_variables

// Dart imports:
import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/file.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter_web/google_maps_flutter_web.dart';
import 'package:map/map.dart';
import 'package:teta_core/teta_core.dart';
import 'package:download_assets/download_assets.dart';

// Project imports:
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:universal_platform/universal_platform.dart';

// ignore_for_file: public_member_api_docs

class WGoogleMaps extends StatefulWidget {
  /// Returns a [Map] widget in Teta
  const WGoogleMaps(
    final Key? key, {
    required this.node,
    required this.forPlay,
    required this.params,
    required this.states,
    required this.dataset,
    required this.markersDatasetName,
    // required this.controller,
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

  // final FTextTypeInput controller;
  final String markersDatasetName;

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
    if (UniversalPlatform.isAndroid || UniversalPlatform.isIOS) {
      return _mobileMap();
    } else if (UniversalPlatform.isWeb) {
      return _webMap();
    } else {
      return _elseMap();
    }
  }

  Widget _webMap() => GoogleMap(
        zoomControlsEnabled: false,
        myLocationButtonEnabled: false,
        initialCameraPosition: const CameraPosition(
          target: LatLng(
            41.9028,
            12.4964,
          ),
          zoom: 15,
        ),
        markers: markers,
      );

  Widget _mobileMap() => GoogleMap(
        zoomControlsEnabled: false,
        myLocationButtonEnabled: false,
        initialCameraPosition: const CameraPosition(
          target: LatLng(
            41.9028,
            12.4964,
          ),
          zoom: 15,
        ),
        markers: markers,
      );

  Widget _elseMap() => const Center(
      child: THeadline3(
          'This platform does not support this Google map plugin, yet.'));

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
        final markerId = element['_id'] as String;
        final markerLatitude = num.parse(element['lat'] as String? ?? '0');
        final markerLongitude = num.parse(element['lng'] as String? ?? '0');
        final markerIconUrl = element['icon'] as String?;
        final markerIconWidth =
            num.parse(element['iconWidth'] as String? ?? '70');
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
      print('Markers -> $mapMarkers');
      setState(() {
        markers = mapMarkers;
        isInitialized = true;
      });
    } catch (e) {
      print('Markers error -> $e');
      setState(() {
        markers = <Marker>{};
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
