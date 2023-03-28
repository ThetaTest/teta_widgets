// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
import 'package:theta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:theta_widgets/src/elements/index.dart';
import 'package:teta_front_end/teta_front_end.dart';
import 'package:theta_models/theta_models.dart';

// ignore_for_file: public_member_api_docs

class WCard extends StatelessWidget {
  /// Returns a [Center] widget in Teta
  const WCard(
    final Key? key, {
    required this.state,
    required this.elevation,
    required this.color,
    required this.borderRadius,
    this.child,
  }) : super(key: key);

  final TetaWidgetState state;
  final CNode? child;
  final FTextTypeInput elevation;
  final FBorderRadius borderRadius;
  final FFill color;

  @override
  Widget build(final BuildContext context) {
    final val = elevation.get(
      state.params,
      state.states,
      state.dataset,
      state.forPlay,
      state.loop,
      context,
    );
    final isLight = context.watch<PaletteDarkLightCubit>().state;
    ColorStyleModel? model;
    context.watch<ColorStylesCubit>().state.forEach((final element) {
      if (element.id == color.paletteStyle) model = element;
      if (element.name == color.paletteStyle) model = element;
    });
    return TetaWidget(
      state: state,
      child: Card(
        color: _getCardColor(model, isLight),
        elevation: double.tryParse(val) != null ? double.parse(val) : 1,
        shape: TetaShapeCard.get(
            context: context,
            forPlay: state.forPlay,
            borderRadius: borderRadius),
        child: ChildConditionBuilder(
          ValueKey(state.toKey),
          state: state,
          child: child,
        ),
      ),
    );
  }

  // ignore: avoid_positional_boolean_parameters
  HexColor _getCardColor(final ColorStyleModel? model, final bool isLight) {
    if (model != null) {
      return isLight
          ? HexColor(model.light.levels!.first.color)
          : HexColor(model.fill.levels!.first.color);
    } else {
      return HexColor(color.levels!.first.color);
    }
  }
}
