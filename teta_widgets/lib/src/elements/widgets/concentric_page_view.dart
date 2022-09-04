// Flutter imports:
// ignore_for_file: public_member_api_docs

// Package imports:
import 'package:concentric_transition/concentric_transition.dart';
// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

class WConcentricPageView extends StatefulWidget {
  /// Returns a PageViewwidget
  const WConcentricPageView(
    final Key? key, {
    required this.children,
    required this.fill,
    required this.node,
    required this.forPlay,
    required this.params,
    required this.states,
    required this.dataset,
    this.loop,
  }) : super(key: key);

  final CNode node;
  final List<CNode> children;
  final FFill fill;
  final bool forPlay;
  final int? loop;
  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

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
    final isLight = BlocProvider.of<PaletteDarkLightCubit>(context).state;
    PaletteModel? model;
    BlocProvider.of<ColorStylesCubit>(context).state.forEach((final element) {
      if (element.id == widget.fill.paletteStyle) model = element;
      if (element.name == widget.fill.paletteStyle) model = element;
    });
    return NodeSelectionBuilder(
      node: widget.node,
      forPlay: widget.forPlay,
      child: ConcentricPageView(
        colors: [
          _getConcentricPageColor(model, isLight),
          _getConcentricPageColor(model, isLight)
        ],
        itemCount: widget.children.length,
        itemBuilder: (final int index) {
          return widget.children[index].toWidget(
            params: widget.params,
            states: widget.states,
            dataset: widget.dataset,
            forPlay: widget.forPlay,
          );
        },
      ),
    );
  }

  // ignore: avoid_positional_boolean_parameters
  HexColor _getConcentricPageColor(
    final PaletteModel? model,
    final bool isLight,
  ) {
    if (model != null) {
      return isLight
          ? HexColor(model.light!.levels!.first.color)
          : HexColor(model.fill!.levels!.first.color);
    } else {
      return HexColor(widget.fill.levels!.first.color);
    }
  }
}
