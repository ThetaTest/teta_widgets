// Flutter imports:
// ignore_for_file: public_member_api_docs

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

class WDivider extends StatelessWidget {
  /// Returns a Divider widget
  const WDivider(
    final Key? key, {
    required this.state,
    required this.height,
    required this.fill,
    this.child,
  }) : super(key: key);

  final TetaWidgetState state;
  final CNode? child;
  final FSize height;
  final FFill fill;

  @override
  Widget build(final BuildContext context) {
    final isLight = context.watch<PaletteDarkLightCubit>().state;
    ColorStyleModel? model;
    context.watch<ColorStylesCubit>().state.forEach((final element) {
      if (element.id == fill.paletteStyle) model = element;
      if (element.name == fill.paletteStyle) model = element;
    });
    final h = height.get(
      context: context,
      isWidth: false,
      forPlay: state.forPlay,
    );
    return TetaWidget(
      state: state,
      child: Divider(
        height: (h ?? 0) <= 0 ? 1.0 : h,
        color: _getDividerColor(model, isLight),
      ),
    );
  }

  // ignore: avoid_positional_boolean_parameters
  HexColor _getDividerColor(final ColorStyleModel? model, final bool isLight) {
    if (model != null) {
      return isLight
          ? HexColor(model.light.levels!.first.color)
          : HexColor(model.fill.levels!.first.color);
    } else {
      return HexColor(fill.levels!.first.color);
    }
  }
}
