// Flutter imports:

// Package imports:
import 'package:badges/badges.dart';
// Flutter imports:
import 'package:flutter/material.dart' hide Badge;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';
import 'package:teta_front_end/teta_front_end.dart';
import 'package:teta_models/teta_models.dart';

// ignore_for_file: public_member_api_docs

class WBadge extends StatelessWidget {
  /// Returns a [Badge] widget in Teta
  const WBadge(
    final Key? key, {
    required this.state,
    required this.value,
    required this.textStyle,
    required this.fill,
    this.child,
  }) : super(key: key);

  final TetaWidgetState state;
  final CNode? child;
  final FTextTypeInput value;
  final FTextStyle textStyle;
  final FFill fill;

  @override
  Widget build(final BuildContext context) {
    final isLight = context.watch<PaletteDarkLightCubit>().state;
    ColorStyleModel? model;
    context.watch<ColorStylesCubit>().state.forEach((final element) {
      if (element.id == fill.paletteStyle) model = element;
      if (element.name == fill.paletteStyle) model = element;
    });
    return TetaWidget(
      state: state,
      child: Badge(
        badgeContent: TextBuilder(
          textStyle: textStyle,
          value: value,
          params: state.params,
          states: state.states,
          dataset: state.dataset,
          forPlay: state.forPlay,
        ),
        badgeColor: _getbadgeColor(model, isLight),
        child: ChildConditionBuilder(
          ValueKey(state.toKey),
          state: state,
          child: child,
        ),
      ),
    );
  }

  // ignore: avoid_positional_boolean_parameters
  HexColor _getbadgeColor(final ColorStyleModel? model, final bool isLight) {
    if (model != null) {
      return isLight
          ? HexColor(model.light.levels!.first.color)
          : HexColor(model.fill.levels!.first.color);
    } else {
      return HexColor(fill.levels!.first.color);
    }
  }
}
