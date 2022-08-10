// Flutter imports:
// ignore_for_file: unused_element, use_late_for_private_fields_and_variables
// Flutter imports:
import 'package:flutter/material.dart';
import 'package:teta_core/teta_core.dart';

// Project imports:
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/widgets/google_maps_base_widget.dart';

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
  @override
  Widget build(final BuildContext context) {
    print('Google maps stub implementation.');
    return const Center(
      child: Text('This platform is not supported for Google Maps'),
    );
  }
}
