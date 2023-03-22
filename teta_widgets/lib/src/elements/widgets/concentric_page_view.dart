// Flutter imports:
// ignore_for_file: public_member_api_docs

// Package imports:
import 'package:concentric_transition/concentric_transition.dart';
// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';
import 'package:teta_front_end/teta_front_end.dart';
import 'package:teta_models/teta_models.dart';

class WConcentricPageView extends StatefulWidget {
  /// Returns a PageViewwidget
  const WConcentricPageView(
    final Key? key, {
    required this.state,
    required this.children,
    required this.fill,
  }) : super(key: key);

  final TetaWidgetState state;
  final List<CNode> children;
  final FFill fill;

  @override
  _WConcentricPageViewState createState() => _WConcentricPageViewState();
}

class _WConcentricPageViewState extends State<WConcentricPageView> {
  PageController? controller;

  @override
  void initState() {
    super.initState();
    controller = PageController();
  }

  @override
  Widget build(final BuildContext context) {
    final isLight = context.watch<PaletteDarkLightCubit>().state;
    ColorStyleModel? model;
    context.watch<ColorStylesCubit>().state.forEach((final element) {
      if (element.id == widget.fill.paletteStyle) model = element;
      if (element.name == widget.fill.paletteStyle) model = element;
    });
    return TetaWidget(
      state: widget.state,
      child: ConcentricPageView(
        colors: [
          _getConcentricPageColor(model, isLight),
          _getConcentricPageColor(model, isLight)
        ],
        itemCount: widget.children.length,
        itemBuilder: (final int index) {
          return widget.children[index].toWidget(state: widget.state);
        },
      ),
    );
  }

  // ignore: avoid_positional_boolean_parameters
  HexColor _getConcentricPageColor(
    final ColorStyleModel? model,
    final bool isLight,
  ) {
    if (model != null) {
      return isLight
          ? HexColor(model.light.levels!.first.color)
          : HexColor(model.fill.levels!.first.color);
    } else {
      return HexColor(widget.fill.levels!.first.color);
    }
  }
}
