// Flutter imports:
// ignore_for_file: unused_element, use_late_for_private_fields_and_variables

// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/features/features.dart';

// Project imports:
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/widgets/google_maps/google_maps_base_widget.dart';
import 'package:teta_widgets/src/elements/widgets/google_maps/google_maps_bloc.dart';
import 'package:teta_widgets/src/elements/widgets/google_maps/maps/map_style.dart';
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
    required this.markersDatasetName,
    required this.markerId,
    required this.markerLatitude,
    required this.markerLongitude,
    required this.markerIconUrl,
    required this.markerIconWidth,
    required this.markerIconHeight,
    required this.drawPathFromUserGeolocationToMarker,
    required this.mapStyle,
    required this.initialPositionLng,
    required this.initialPositionLat,
    required this.showMyLocationMarker,
    required this.trackMyLocation,
    required this.initialZoomLevel,
    required this.pathColor,
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
  final String markerId;
  final String markerLatitude;
  final String markerLongitude;
  final String markerIconUrl;
  final String markerIconWidth;
  final String markerIconHeight;
  final String drawPathFromUserGeolocationToMarker;
  final MapStyle mapStyle;
  final String initialPositionLng;
  final String initialPositionLat;
  final bool showMyLocationMarker;
  final bool trackMyLocation;
  final String initialZoomLevel;
  final FFill pathColor;

  @override
  State<WGoogleMaps> createState() => _WGoogleMapsState();
}

class _WGoogleMapsState extends State<WGoogleMaps> {
  final GoogleMapsBloc googleMapsBloc = GoogleMapsBloc();
  Completer<GoogleMapController> googleMapsController =
      Completer<GoogleMapController>();
  @override
  void initState() {
    super.initState();
    final googleMapsKey =
        (BlocProvider.of<FocusProjectBloc>(context).state as ProjectLoaded)
                .prj
                .config
                ?.googleMapsKey ??
            '';
    List<Map<String, dynamic>> markersDataset;
    try {

      markersDataset = widget.dataset
          .firstWhere(
            (final element) => element.getName == widget.markersDatasetName,
          )
          .getMap;
    } catch (e) {
      markersDataset = [];
    }

    googleMapsBloc.onLoadData(
      markersDataset,
      GoogleMapsConfigNames(
        mapStyle: widget.mapStyle,
        initialPositionLat: widget.initialPositionLat,
        initialPositionLng: widget.initialPositionLng,
        initialMapZoomLevel: widget.initialZoomLevel,
        showMyLocationMarker: widget.showMyLocationMarker,
        trackMyLocation: widget.trackMyLocation,
        markerId: widget.markerId,
        markerLocationLat: widget.markerLatitude,
        markerLoctionLng: widget.markerLongitude,
        markerIconUrl: widget.markerIconUrl,
        markerIconWidth: widget.markerIconWidth,
        markerIconHeight: widget.markerIconHeight,
        drawPathFromUserGeolocationToMarker:
            widget.drawPathFromUserGeolocationToMarker,
        googleMapsKey: googleMapsKey,
        pathColor: widget.pathColor.getHexColor(context),
      ),
      widget.dataset,
      context,
    );

    BlocProvider.of<RefreshCubit>(context).stream.listen((_) {
      googleMapsBloc.onLoadData(
        markersDataset,
        GoogleMapsConfigNames(
          mapStyle: widget.mapStyle,
          initialPositionLat: widget.initialPositionLat,
          initialPositionLng: widget.initialPositionLng,
          initialMapZoomLevel: widget.initialZoomLevel,
          showMyLocationMarker: widget.showMyLocationMarker,
          trackMyLocation: widget.trackMyLocation,
          markerId: widget.markerId,
          markerLocationLat: widget.markerLatitude,
          markerLoctionLng: widget.markerLongitude,
          markerIconUrl: widget.markerIconUrl,
          markerIconWidth: widget.markerIconWidth,
          markerIconHeight: widget.markerIconHeight,
          drawPathFromUserGeolocationToMarker:
          widget.drawPathFromUserGeolocationToMarker,
          googleMapsKey: googleMapsKey,
          pathColor: widget.pathColor.getHexColor(context),
        ),
        widget.dataset,
        context,
      );
    });
  }

  @override
  Widget build(final BuildContext context) {
    if (UniversalPlatform.isAndroid || UniversalPlatform.isIOS) {
      return _buildGoogleMapsWidget(context);
    } else if (UniversalPlatform.isWeb) {
      return _buildGoogleMapsWidget(context);
    } else {
      return _elseMap();
    }
  }

  Widget _buildGoogleMapsWidget(final BuildContext context) {
    final googleMapsKey =
        (BlocProvider.of<FocusProjectBloc>(context).state as ProjectLoaded)
                .prj
                .config
                ?.googleMapsKey ??
            '';
    List<Map<String, dynamic>> markersDataset;
    try {
      markersDataset = widget.dataset
          .firstWhere(
            (final element) => element.getName == widget.markersDatasetName,
          )
          .getMap;
    } catch (e) {
      markersDataset = [];
    }

    return BlocConsumer<GoogleMapsBloc, GoogleMapsState>(
      bloc: googleMapsBloc,
      builder: (final BuildContext context, final GoogleMapsState state) {
        if (state.isInitialState) {
          googleMapsBloc.onLoadData(
            markersDataset,
            GoogleMapsConfigNames(
              mapStyle: widget.mapStyle,
              initialPositionLat: widget.initialPositionLat,
              initialPositionLng: widget.initialPositionLng,
              initialMapZoomLevel: widget.initialZoomLevel,
              showMyLocationMarker: widget.showMyLocationMarker,
              trackMyLocation: widget.trackMyLocation,
              markerId: widget.markerId,
              markerLocationLat: widget.markerLatitude,
              markerLoctionLng: widget.markerLongitude,
              markerIconUrl: widget.markerIconUrl,
              markerIconWidth: widget.markerIconWidth,
              markerIconHeight: widget.markerIconHeight,
              drawPathFromUserGeolocationToMarker:
                  widget.drawPathFromUserGeolocationToMarker,
              googleMapsKey: googleMapsKey,
              pathColor: widget.pathColor.getHexColor(context),
            ),
            widget.dataset,
            context,
          );
          return const CircularProgressIndicator.adaptive();
        } else if (state.isError) {
          return Container();
        } else {
          return GoogleMap(
            initialCameraPosition: state.initialCameraPosition,
            polylines: state.paths,
            markers: state.markers,
            onMapCreated: (final cnt) {
              googleMapsController.complete(cnt);
              cnt.setMapStyle(state.mapStyle);
            },
          );
        }
      },
      buildWhen: (final p, final c) {
        return !c.isSetNewCameraPositionState;
      },
      listener:
          (final BuildContext context, final GoogleMapsState state) async {
        try {
          await (await googleMapsController.future).setMapStyle(state.mapStyle);
        } catch(e, st){
          print(e);
          print(st);
        }
        if (state.isInitialState) {
          unawaited(
            googleMapsBloc.onLoadData(
              markersDataset,
              GoogleMapsConfigNames(
                mapStyle: widget.mapStyle,
                initialPositionLat: widget.initialPositionLat,
                initialPositionLng: widget.initialPositionLng,
                initialMapZoomLevel: widget.initialZoomLevel,
                showMyLocationMarker: widget.showMyLocationMarker,
                trackMyLocation: widget.trackMyLocation,
                markerId: widget.markerId,
                markerLocationLat: widget.markerLatitude,
                markerLoctionLng: widget.markerLongitude,
                markerIconUrl: widget.markerIconUrl,
                markerIconWidth: widget.markerIconWidth,
                markerIconHeight: widget.markerIconHeight,
                drawPathFromUserGeolocationToMarker:
                    widget.drawPathFromUserGeolocationToMarker,
                googleMapsKey: googleMapsKey,
                pathColor: '',
              ),
              widget.dataset,
              context,
            ),
          );
        } else if (state.isSetNewCameraPositionState) {
          await (await googleMapsController.future).animateCamera(
            CameraUpdate.newCameraPosition(
              state.initialCameraPosition,
            ),
          );
        }
      },
    );
  }

  Widget _elseMap() => const Center(
        child: THeadline3(
          'This platform does not support this Google map plugin, yet.',
        ),
      );
}
