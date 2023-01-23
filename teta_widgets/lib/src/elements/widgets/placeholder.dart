// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

// ignore_for_file: public_member_api_docs

class WPlaceholder extends StatelessWidget {
  /// Returns a [Center] widget in Teta
  const WPlaceholder(
    final Key? key, {
    required this.state,
    required this.value,
    required this.color,
    required this.width,
    required this.height,
    this.child,
  }) : super(key: key);

  final TetaWidgetState state;
  final CNode? child;
  final FTextTypeInput value;
  final FFill color;
  final FSize width;
  final FSize height;

  @override
  Widget build(final BuildContext context) {
    final val = value.get(
      state.params,
      state.states,
      state.dataset,
      state.forPlay,
      state.loop,
      context,
    );
    final isLight = BlocProvider.of<PaletteDarkLightCubit>(context).state;
    ColorStyleModel? model;
    BlocProvider.of<ColorStylesCubit>(context).state.forEach((final element) {
      if (element.id == color.paletteStyle) model = element;
      if (element.name == color.paletteStyle) model = element;
    });
    return TetaWidget(
      state: state,
      child: SizedBox(
        width: width.get(context: context, isWidth: true) ?? 400,
        height: height.get(context: context, isWidth: false) ?? 400,
        child: Placeholder(
          strokeWidth: double.tryParse(val) != null ? double.parse(val) : 2.0,
          color: _getPlaceHolderColor(model, isLight),
        ),
      ),
    );
  }

  // ignore: avoid_positional_boolean_parameters
  HexColor _getPlaceHolderColor(
    final ColorStyleModel? model,
    final bool isLight,
  ) {
    if (model != null) {
      return isLight
          ? HexColor(model.light.levels!.first.color)
          : HexColor(model.fill.levels!.first.color);
    } else {
      return HexColor(color.levels!.first.color);
    }
  }
}
