// Flutter imports:
// ignore_for_file: import_of_legacy_library_into_null_safe, public_member_api_docs, lines_longer_than_80_chars

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';
import 'package:teta_front_end/teta_front_end.dart';
import 'package:teta_models/teta_models.dart';
import 'package:teta_models/teta_models.dart';

class WBottomBarItem extends StatelessWidget {
  /// Returns a Icon widget in Teta
  const WBottomBarItem(
    final Key? key, {
    required this.state,
    required this.icon,
    required this.width,
    required this.fill,
    required this.textStyle,
    required this.isFullWidth,
    required this.value,
    this.action,
  }) : super(key: key);

  final TetaWidgetState state;
  final NodeGestureActions? action;
  final FSize? width;
  final String icon;
  final FFill fill;
  final FTextTypeInput value;
  final FTextStyle textStyle;
  final bool isFullWidth;

  @override
  Widget build(final BuildContext context) {
    return NodeSelectionBuilder(
      state: state,
      child: GestureDetector(
        onTap: () => GestureBuilder.get(
          context: context,
          state: state,
          gesture: ActionGesture.onTap,
          nodeGestureActions: action,
          actionValue: null,
        ),
        onDoubleTap: () => GestureBuilder.get(
          context: context,
          state: state,
          gesture: ActionGesture.onDoubleTap,
          nodeGestureActions: action,
          actionValue: null,
        ),
        onLongPress: () => GestureBuilder.get(
          context: context,
          state: state,
          gesture: ActionGesture.onLongPress,
          nodeGestureActions: action,
          actionValue: null,
        ),
        child: Column(
          children: [
            BlocBuilder<ColorStylesCubit, List<ColorStyleModel>>(
              builder: (final context, final s) {
                final isLight = context.watch<PaletteDarkLightCubit>().state;
                ColorStyleModel? model;
                for (final element in s) {
                  if (element.id == fill.paletteStyle) model = element;
                  if (element.name == fill.paletteStyle) model = element;
                }
                return Icon(
                  MdiIcons.fromString(icon),
                  color: _getBottomBarItemColor(model, isLight),
                  size: width!.get(
                    context: context,
                    isWidth: true,
                    forPlay: state.forPlay,
                  ),
                );
              },
            ),
            TextBuilder(
              textStyle: textStyle,
              value: value,
              params: state.params,
              states: state.states,
              dataset: state.dataset,
              forPlay: state.forPlay,
            ),
          ],
        ),
      ),
    );
  }

  // ignore: avoid_positional_boolean_parameters
  HexColor _getBottomBarItemColor(
    final ColorStyleModel? model,
    final bool isLight,
  ) {
    if (model != null) {
      return isLight
          ? HexColor(model.light.levels!.first.color)
          : HexColor(model.fill.levels!.first.color);
    } else {
      return HexColor(fill.levels!.first.color);
    }
  }
}
