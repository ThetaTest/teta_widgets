// Flutter imports:
// ignore_for_file: unused_element, use_late_for_private_fields_and_variables

// Dart imports:
import 'dart:async';
import 'dart:math';

// Package imports:
import 'package:collection/collection.dart';
// Flutter imports:
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlng/latlng.dart';
import 'package:map/map.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:teta_widgets/src/elements/builder/node_selection_builder.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/features/action.dart';
import 'package:teta_widgets/src/elements/features/dataset.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_widgets/src/elements/nodes/dynamic.dart';
import 'package:teta_widgets/src/elements/nodes/enum.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_front_end/teta_front_end.dart';
import 'package:theta_models/theta_models.dart';

// ignore_for_file: public_member_api_docs

class WMapBuilder extends StatefulWidget {
  /// Returns a [Map] widget in Teta
  const WMapBuilder(
    final Key? key, {
    required this.state,
    required this.controller,
    required this.action,
    required this.flag,
    required this.datasetInput,
    this.child,
  }) : super(key: key);

  final TetaWidgetState state;
  final CNode? child;
  final FTextTypeInput controller;
  final NodeGestureActions? action;
  final FDataset datasetInput;
  final bool flag;

  @override
  State<WMapBuilder> createState() => _WMapBuilderState();
}

class _WMapBuilderState extends State<WMapBuilder> {
  VariableObject? variable;
  DatasetObject map = DatasetObject.empty();
  bool isInitialized = false;

  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 1), (final dynamic t) {
      if (mounted) {
        setState(() {});
      }
    });
    init();
    super.initState();
  }

  Future<void> init() async {
    if (widget.controller.type == FTextTypeEnum.param) {
      variable = widget.state.params
          .firstWhereOrNull((final e) => e.name == widget.controller.paramName);
    } else {
      variable = widget.state.states
          .firstWhereOrNull((final e) => e.name == widget.controller.stateName);
    }
    variable = variable!.copyWith(
      mapController: MapController(
        location: LatLng(41.52, 12.30),
        zoom: 4,
      ),
    );
    setState(() {});
  }

  void _gotoDefault() {
    variable!.mapController!.center = LatLng(41.52, 12.30);
    setState(() {});
  }

  void _onDoubleTap() {
    variable!.mapController!.zoom += 0.5;
    setState(() {});
  }

  Offset? _dragStart;
  double _scaleStart = 1;
  void _onScaleStart(final ScaleStartDetails details) {
    _dragStart = details.focalPoint;
    _scaleStart = 1.0;
  }

  void _onScaleUpdate(final ScaleUpdateDetails details) {
    final scaleDiff = details.scale - _scaleStart;
    _scaleStart = details.scale;

    if (scaleDiff > 0) {
      variable!.mapController!.zoom += 0.02;
      setState(() {});
    } else if (scaleDiff < 0) {
      variable!.mapController!.zoom -= 0.02;
      setState(() {});
    } else {
      final now = details.focalPoint;
      final diff = now - _dragStart!;
      _dragStart = now;
      variable!.mapController!.drag(diff.dx, diff.dy);
      setState(() {});
    }
  }

  Widget _buildMarkerWidget(
    final Offset pos,
    final Color color, [
    final IconData icon = Icons.location_on,
  ]) {
    return Positioned(
      left: pos.dx - 24,
      top: pos.dy - 24,
      child: GestureDetector(
        child: Icon(
          icon,
          color: color,
          size: 48,
        ),
      ),
    );
  }

  @override
  Widget build(final BuildContext context) {
    /*controller = MapController(
      location: LatLng(lat, lng),
      zoom: 4,
    );*/

    if (variable?.mapController == null) {
      return const Center(
        child: THeadline3(
          'Implement a Map Controller state',
        ),
      );
    }

    if (widget.child == null) {
      return const Center(
        child: THeadline3(
          'Implement a child',
        ),
      );
    }

    _setDataset();
    final index = widget.datasetInput.datasetName != null
        ? widget.state.dataset.indexWhere(
            (final element) =>
                element.getName == widget.datasetInput.datasetName,
          )
        : -1;
    final db =
        index != -1 ? widget.state.dataset[index] : DatasetObject.empty();

    return NodeSelectionBuilder(
      state: widget.state,
      child: !(BlocProvider.of<ConfigCubit>(context).state as ConfigStateLoaded)
              .config
              .mapEnabled
          ? const DecoratedBox(
              decoration: BoxDecoration(color: Colors.black),
              child: Center(
                child: THeadline3(
                  'Integrate your MapBox key',
                ),
              ),
            )
          : MapLayoutBuilder(
              controller: variable!.mapController!,
              builder: (final context, final transformer) {
                final markers = <LatLng>[];

                for (var i = 0; i < db.getMap.length; i++) {
                  if ((widget.child as NDynamic?)?.intrinsicState.type ==
                      NType.marker) {
                    final lat = (widget.child!.body.attributes[DBKeys.latitude]
                            as FTextTypeInput)
                        .get(
                      widget.state.params,
                      widget.state.states,
                      widget.state.dataset,
                      widget.state.forPlay,
                      i,
                      context,
                    );
                    final lng = (widget.child!.body.attributes[DBKeys.longitude]
                            as FTextTypeInput)
                        .get(
                      widget.state.params,
                      widget.state.states,
                      widget.state.dataset,
                      widget.state.forPlay,
                      i,
                      context,
                    );
                    markers.add(
                      LatLng(
                        double.tryParse(lat) ?? 0.0,
                        double.tryParse(lng) ?? 0.0,
                      ),
                    );
                  }
                }

                final markersChildren = db.getMap;
                final markersWidgets = <Widget>[];
                final normalWidgets = db.getMap
                    .map(
                      (final e) =>
                          widget.child!.intrinsicState.type != NType.marker
                              ? widget.child!.toWidget(state: widget.state)
                              : const SizedBox(),
                    )
                    .toList();

                for (var i = 0; i < markersChildren.length; i++) {
                  if ((widget.child as NDynamic?)?.intrinsicState.type ==
                      NType.marker) {
                    markersWidgets.add(
                      widget.child!.toWidget(state: widget.state),
                    );
                  }
                }

                return GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onDoubleTap: _onDoubleTap,
                  onScaleStart: _onScaleStart,
                  onScaleUpdate: _onScaleUpdate,
                  child: Listener(
                    behavior: HitTestBehavior.opaque,
                    onPointerSignal: (final event) {
                      if (event is PointerScrollEvent) {
                        final delta = event.scrollDelta;

                        variable!.mapController!.zoom -= delta.dy / 1000.0;
                        setState(() {});
                      }
                    },
                    child: Stack(
                      children: [
                        if (variable != null && variable?.mapController != null)
                          Map(
                            controller: variable!.mapController!,
                            builder:
                                (final context, final x, final y, final z) {
                              final config = (context.read<ConfigCubit>().state
                                      as ConfigStateLoaded)
                                  .config;
                              final url =
                                  'https://api.mapbox.com/styles/v1/mapbox/streets-v11/tiles/$z/$x/$y?access_token=${config.mapboxKey}';
                              final darkUrl =
                                  'https://api.mapbox.com/styles/v1/mapbox/dark-v10/tiles/$z/$x/$y?access_token=${config.mapboxKey}';
                              return CNetworkImage(
                                nid: widget.state.node.nid,
                                src: widget.flag ? darkUrl : url,
                                loop: widget.state.loop ?? 0,
                                width: double.maxFinite,
                                height: double.maxFinite,
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                        ...markersWidgets,
                        ...normalWidgets,
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  void _setDataset() {
    try {
      final index = widget.state.dataset.indexWhere(
        (final element) => element.getName == widget.datasetInput.datasetName,
      );
      final db =
          index != -1 ? widget.state.dataset[index] : DatasetObject.empty();
      if (mounted) {
        if (db.getName != '') {
          setState(() {
            map = db;
          });
        }
      }
    } catch (_) {}
  }
}

class DayNightCalculator {
  static DayNightBorder calculate(
    final DateTime time, [
    final int resolution = 2,
  ]) {
    final julianDay = _julian(time.millisecondsSinceEpoch);
    final gst = _gmst(julianDay);
    final latLng = <LatLng>[];

    final sunEclPos = _sunEclipticPosition(julianDay);
    final eclObliq = _eclipticObliquity(julianDay);
    final sunEqPos = _sunEquatorialPosition(sunEclPos.lambda, eclObliq);
    for (var i = 0; i <= 360 * resolution; i++) {
      final lng = -180 + i / resolution;
      final ha = _hourAngle(lng, sunEqPos, gst);
      latLng.add(LatLng(_latitude(ha, sunEqPos), lng));
    }

    return DayNightBorder._(latLng, sunEqPos.delta);
  }
}

const double _r2d = 180 / pi;
const double d2r = pi / 180;

void setTime(final DateTime date) {
  //var latLng = _compute(date);
  //setLatLngs(latLng);
}

_LambdaRadius _sunEclipticPosition(final double julianDay) {
  /* Compute the position of the Sun in ecliptic coordinates at
			 julianDay.  Following
			 http://en.wikipedia.org/wiki/Position_of_the_Sun */
  // Days since start of J2000.0
  final n = julianDay - 2451545.0;
  // mean longitude of the Sun
  var L = 280.460 + 0.9856474 * n;
  L %= 360;
  // mean anomaly of the Sun
  var g = 357.528 + 0.9856003 * n;
  g %= 360;
  // ecliptic longitude of Sun
  final lambda = L + 1.915 * sin(g * d2r) + 0.02 * sin(2 * g * d2r);
  // distance from Sun in AU
  final R = 1.00014 - 0.01671 * cos(g * d2r) - 0.0014 * cos(2 * g * d2r);
  return _LambdaRadius(lambda: lambda, r: R);
}

double _eclipticObliquity(final double julianDay) {
  // Following the short term expression in
  // http://en.wikipedia.org/wiki/Axial_tilt#Obliquity_of_the_ecliptic_.28Earth.27s_axial_tilt.29
  final n = julianDay - 2451545.0;
  // Julian centuries since J2000.0
  final T = n / 36525;
  final epsilon = 23.43929111 -
      T *
          (46.836769 / 3600 -
              T *
                  (0.0001831 / 3600 +
                      T *
                          (0.00200340 / 3600 -
                              T * (0.576e-6 / 3600 - T * 4.34e-8 / 3600))));
  return epsilon;
}

_AlphaDelta _sunEquatorialPosition(
  final double sunEclLng,
  final double eclObliq,
) {
  /* Compute the Sun's equatorial position from its ecliptic
		 * position. Inputs are expected in degrees. Outputs are in
		 * degrees as well. */
  var alpha = atan(cos(eclObliq * d2r) * tan(sunEclLng * d2r)) * _r2d;
  final delta = asin(sin(eclObliq * d2r) * sin(sunEclLng * d2r)) * _r2d;

  final lQuadrant = (sunEclLng / 90.0).floor() * 90;
  final raQuadrant = (alpha / 90.0).floor() * 90;
  alpha = alpha + (lQuadrant - raQuadrant);

  return _AlphaDelta(alpha: alpha, delta: delta);
}

double _hourAngle(
  final double lng,
  final _AlphaDelta sunPos,
  final double gst,
) {
  /* Compute the hour angle of the sun for a longitude on
		 * Earth. Return the hour angle in degrees. */
  final lst = gst + lng / 15;
  return lst * 15 - sunPos.alpha;
}

double _latitude(final double ha, final _AlphaDelta sunPos) {
  /* For a given hour angle and sun position, compute the
		 * latitude of the terminator in degrees. */
  final lat = atan(-cos(ha * d2r) / tan(sunPos.delta * d2r)) * _r2d;
  return lat;
}

double _julian(final int date) {
  /* Calculate the present UTC Julian Date. Function is valid after
	 * the beginning of the UNIX epoch 1970-01-01 and ignores leap
	 * seconds. */
  return (date / 86400000.0) + 2440587.5;
}

double _gmst(final double julianDay) {
  /* Calculate Greenwich Mean Sidereal Time according to 
		 http://aa.usno.navy.mil/faq/docs/GAST.php */
  final d = julianDay - 2451545.0;
  // Low precision equation is good enough for our purposes.
  return (18.697374558 + 24.06570982441908 * d) % 24;
}

class _LambdaRadius {
  _LambdaRadius({required this.lambda, required this.r});

  final double lambda;
  final double r;
}

class _AlphaDelta {
  _AlphaDelta({required this.alpha, required this.delta});

  final double alpha;
  final double delta;
}

class DayNightBorder {
  DayNightBorder._(this.polyline, this.delta);
  final List<LatLng> polyline;
  final double delta;
}
