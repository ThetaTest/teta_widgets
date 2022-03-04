// Flutter imports:
// ignore_for_file: import_of_legacy_library_into_null_safe, public_member_api_docs, lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// Package imports:
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
// Project imports:
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/index.dart';

class WBottomBarItem extends StatelessWidget {
  /// Returns a Icon widget in Teta
  const WBottomBarItem(
    Key? key, {
    required this.icon,
    required this.node,
    required this.width,
    required this.fill,
    required this.textStyle,
    required this.isFullWidth,
    required this.value,
    required this.forPlay,
    required this.params,
    required this.states,
    required this.dataset,
    this.action,
    this.loop,
  }) : super(key: key);

  final CNode node;
  final FAction? action;
  final FSize? width;
  final String icon;
  final FFill fill;
  final bool forPlay;
  final int? loop;
  final FTextTypeInput value;
  final FTextStyle textStyle;
  final bool isFullWidth;

  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaletteBloc, List<PaletteModel>>(
      builder: (context, state) {
        FFill? finalFill;
        if (state.isNotEmpty) {
          for (final e in state) {
            if (e.id == fill.paletteStyle) finalFill = e.fill;
          }
        }
        finalFill ??= fill;

        return NodeSelectionBuilder(
          node: node,
          forPlay: forPlay,
          child: GestureDetector(
            onTap: () => GestureBuilder.get(
              context: context,
              node: node,
              gesture: ActionGesture.onTap,
              action: action,
              actionValue: null,
              params: params,
              states: states,
              dataset: dataset,
              forPlay: forPlay,
            ),
            onDoubleTap: () => GestureBuilder.get(
              context: context,
              node: node,
              gesture: ActionGesture.onDoubleTap,
              action: action,
              actionValue: null,
              params: params,
              states: states,
              dataset: dataset,
              forPlay: forPlay,
            ),
            onLongPress: () => GestureBuilder.get(
              context: context,
              node: node,
              gesture: ActionGesture.onLongPress,
              action: action,
              actionValue: null,
              params: params,
              states: states,
              dataset: dataset,
              forPlay: forPlay,
            ),
            child: Column(
              children: [
                Icon(
                  MdiIcons.fromString(icon),
                  color: HexColor(finalFill.levels!.first.color),
                  size: width!.get(context: context, isWidth: true),
                ),
                TextBuilder(
                  textStyle: textStyle,
                  value: value,
                  params: params,
                  states: states,
                  dataset: dataset,
                  forPlay: forPlay,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
