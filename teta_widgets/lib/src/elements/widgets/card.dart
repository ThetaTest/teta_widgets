// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

// ignore_for_file: public_member_api_docs

class WCard extends StatelessWidget {
  /// Returns a [Center] widget in Teta
  const WCard(
    final Key? key, {
    required this.node,
    required this.forPlay,
    required this.params,
    required this.states,
    required this.dataset,
    required this.elevation,
    required this.color,
    required this.borderRadius,
    this.child,
    this.loop,
  }) : super(key: key);

  final CNode node;
  final CNode? child;
  final bool forPlay;
  final int? loop;
  final FTextTypeInput elevation;
  final FBorderRadius borderRadius;
  final FFill color;
  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

  @override
  Widget build(final BuildContext context) {
    final val = elevation.get(
      params,
      states,
      dataset,
      forPlay,
      loop,
      context,
    );
    final isLight = BlocProvider.of<PaletteDarkLightCubit>(context).state;
    PaletteModel? model;
    BlocProvider.of<ColorStylesCubit>(context).state.forEach((final element) {
      if (element.id == color.paletteStyle) model = element;
      if (element.name == color.paletteStyle) model = element;
    });
    return NodeSelectionBuilder(
      node: node,
      forPlay: forPlay,
      child: Card(
        color: _getCardColor(model, isLight),
        elevation: double.tryParse(val) != null ? double.parse(val) : 1,
        shape: TetaShapeCard.get(context: context, borderRadius: borderRadius),
        child: ChildConditionBuilder(
          ValueKey('${node.nid} $loop'),
          name: node.intrinsicState.displayName,
          node: node,
          child: child,
          params: params,
          states: states,
          dataset: dataset,
          forPlay: forPlay,
          loop: loop,
        ),
      ),
    );
  }

  // ignore: avoid_positional_boolean_parameters
  HexColor _getCardColor(final PaletteModel? model, final bool isLight) {
    if (model != null) {
      return isLight
          ? HexColor(model.light!.levels!.first.color)
          : HexColor(model.fill!.levels!.first.color);
    } else {
      return HexColor(color.levels!.first.color);
    }
  }
}
