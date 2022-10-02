// Flutter imports:
// ignore_for_file: unused_element, use_late_for_private_fields_and_variables

// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:dart_airtable/dart_airtable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/features/features.dart';
import 'package:teta_widgets/src/elements/features/google_maps_map_style.dart';

// Project imports:
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/widgets/google_maps/google_maps_base_widget.dart';
import 'package:teta_widgets/src/elements/widgets/google_maps/google_maps_cubit.dart';

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
    required this.cubitName,
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
  final String cubitName;
  final String markerId;
  final String markerLatitude;
  final String markerLongitude;
  final String markerIconUrl;
  final String markerIconWidth;
  final String markerIconHeight;
  final String drawPathFromUserGeolocationToMarker;
  final FGoogleMapsMapStyle mapStyle;
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
  late String googleMapsKey;
  late GoogleMapsCubit googleMapsCubit;
  Completer<GoogleMapController> googleMapsController = Completer();
  bool isInitialized = false;

  @override
  void initState() {
    super.initState();
    print('GoogleMapsInitData');
    initData();
  }

  @override
  Widget build(final BuildContext context) {
    return isInitialized
        ? BlocConsumer<GoogleMapsCubit, GoogleMapsState>(
            bloc: googleMapsCubit,
            builder: (final BuildContext context, final GoogleMapsState state) {
              if (state is GoogleMapsInitialState) {
                print('Initial state');
                googleMapsCubit.onEmitReloadDataState();
                return const CircularProgressIndicator();
              } else if (state is GoogleMapsErrorState) {
                return Container();
              } else {
                print('Build map state: $state');
                return GoogleMap(
                  initialCameraPosition: state.uiModel.cameraPosition,
                  polylines: state.uiModel.paths,
                  markers: state.uiModel.markers,
                  onMapCreated: (final cnt) {
                    googleMapsController.complete(cnt);

                    googleMapsCubit
                      ..onEmitNewMapStyle(widget.mapStyle.get)
                      ..onEmitReloadDataState();
                  },
                );
              }
            },
            buildWhen: (final p, final c) {
              final build = c is! GoogleMapsSetNewCameraPositionState &&
                  c is! GoogleMapsChangeMapStyleState &&
                  c is! GoogleMapsReloadDataState;
              print('Build when state($build): $c');
              return build;
            },
            listener: (final BuildContext context,
                final GoogleMapsState state) async {
              print('Listed state $state');
              if (state is GoogleMapsSetNewCameraPositionState) {
                if (googleMapsController.isCompleted) {
                  await (await googleMapsController.future).animateCamera(
                    CameraUpdate.newCameraPosition(
                      state.uiModel.cameraPosition,
                    ),
                  );
                }
              } else if (state is GoogleMapsChangeMapStyleState) {
                if (googleMapsController.isCompleted) {
                  await (await googleMapsController.future)
                      .setMapStyle(state.uiModel.style);
                }
              } else if (state is GoogleMapsReloadDataState) {
                print('Reload Map State');
                List<Map<String, dynamic>> markersDataset;
                try {
                  markersDataset = widget.dataset
                      .firstWhere(
                        (final element) =>
                            element.getName == widget.markersDatasetName,
                      )
                      .getMap;
                } catch (e) {
                  markersDataset = [];
                }

                unawaited(
                  googleMapsCubit.onLoadData(
                    markersDataset,
                    GoogleMapsConfigNames(
                      mapStyle: widget.mapStyle.get,
                      initialPositionLat: widget.initialPositionLat,
                      initialPositionLng: widget.initialPositionLng,
                      initialMapZoomLevel: widget.initialZoomLevel,
                      showMyLocationMarker: widget.showMyLocationMarker,
                      trackMyLocation: widget.trackMyLocation,
                      markerId: widget.markerId,
                      markerLocationLat: widget.markerLatitude,
                      markerLocationLng: widget.markerLongitude,
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
                  ),
                );
                print('Reload state finished');
              }
            },
          )
        : const Text('Add Google Maps Cubit to initialize map.');
  }

  Future<void> initData() async {
    try {
      googleMapsKey =
          (BlocProvider.of<FocusProjectBloc>(context).state as ProjectLoaded)
                  .prj
                  .config
                  ?.googleMapsKey ??
              '';
      final page = BlocProvider.of<PageCubit>(context).state;
      final VariableObject? variable;

      variable = page.states.firstWhereOrNull(
        (final e) => e.name == widget.cubitName,
      );

      if (variable == null) {
        // throw exception
      }

      if (variable!.googleMapsCubit == null) {
        variable.googleMapsCubit = GoogleMapsCubit();
      }

      variable.googleMapsCubit?.onEmitReloadDataState();

      googleMapsCubit = variable.googleMapsCubit!;

      BlocProvider.of<RefreshCubit>(context).stream.listen(
        (_) {
          print('Will load data with style ${widget.mapStyle}');
          googleMapsCubit.onEmitReloadDataState();
        },
      );
      setState(() {
        print('GoogleMapsInitData complete.');
        isInitialized = true;
      });
    } catch (e, st) {
      print('GoogleMapsInitData e:$e, stackTrace:$st');
    }
  }
}
