// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter_named/font_awesome_flutter_named.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

class WFontAwesome extends StatelessWidget {
  /// Returns a Icon widget in Teta
  const WFontAwesome(
    final Key? key, {
    required this.state,
    required this.icon,
    required this.width,
    required this.fill,
  }) : super(key: key);

  final TetaWidgetState state;
  final FSize? width;
  final String icon;
  final FFill fill;
  @override
  Widget build(final BuildContext context) {
    final isLight = BlocProvider.of<PaletteDarkLightCubit>(context).state;
    ColorStyleModel? model;
    BlocProvider.of<ColorStylesCubit>(context).state.forEach((final element) {
      if (element.id == fill.paletteStyle) model = element;
      if (element.name == fill.paletteStyle) model = element;
    });
    return TetaWidget(
      state: state,
      child: Icon(
        faIconNameMapping[icon],
        color: _getIconColor(model, isLight),
        size: width!.get(context: context, isWidth: true),
      ),
    );
  }

  // ignore: avoid_positional_boolean_parameters
  Color _getIconColor(final ColorStyleModel? model, final bool isLight) {
    final tempOpacity = fill.levels?.first.opacity ?? 1;
    if (model != null) {
      return isLight
          ? HexColor(model.light.levels!.first.color)
          : HexColor(model.fill.levels!.first.color);
    } else {
      return HexColor(fill.levels!.first.color).withOpacity(tempOpacity);
    }
  }
}
