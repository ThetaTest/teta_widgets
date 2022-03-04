// Flutter imports:
// ignore_for_file: public_member_api_docs, import_of_legacy_library_into_null_safe, lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// Package imports:
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
// Project imports:
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/index.dart';

class WIcon extends StatelessWidget {
  /// Returns a Icon widget in Teta
  const WIcon(
    Key? key, {
    required this.icon,
    required this.node,
    required this.width,
    required this.fill,
    required this.forPlay,
    required this.params,
    required this.states,
    required this.dataset,
    this.loop,
  }) : super(key: key);

  final CNode node;
  final FSize? width;
  final String icon;
  final FFill fill;
  final bool forPlay;
  final int? loop;

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
          child: Icon(
            MdiIcons.fromString(icon),
            color: HexColor(finalFill.levels!.first.color),
            size: width!.get(context: context, isWidth: true),
          ),
        );
      },
    );
  }
}
