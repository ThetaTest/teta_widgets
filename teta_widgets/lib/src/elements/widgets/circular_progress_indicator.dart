// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

// ignore_for_file: public_member_api_docs
import 'package:teta_front_end/teta_front_end.dart';
import 'package:teta_models/teta_models.dart';

class WCircularProgressIndicator extends StatelessWidget {
  /// Returns a [Center] widget in Teta
  const WCircularProgressIndicator(
    final Key? key, {
    required this.state,
    required this.fill,
  }) : super(key: key);

  final TetaWidgetState state;
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
      child: CircularProgressIndicator(
        valueColor:
            AlwaysStoppedAnimation<Color>(_getCircularColor(model, isLight)),
      ),
    );
  }

  // ignore: avoid_positional_boolean_parameters
  HexColor _getCircularColor(final ColorStyleModel? model, final bool isLight) {
    if (model != null) {
      return isLight
          ? HexColor(model.light.levels!.first.color)
          : HexColor(model.fill.levels!.first.color);
    } else {
      return HexColor(fill.levels!.first.color);
    }
  }
}
