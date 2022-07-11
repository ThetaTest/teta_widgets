// Flutter imports:
// ignore_for_file: public_member_api_docs, import_of_legacy_library_into_null_safe, lines_longer_than_80_chars

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

class WLineIcon extends StatelessWidget {
  /// Returns a FontAwesome widget in Teta
  const WLineIcon(
    final Key? key, {
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
  Widget build(final BuildContext context) {
    return BlocBuilder<PaletteBloc, List<PaletteModel>>(
      builder: (final context, final state) {
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
            LineIcons.byName(icon),
            color: HexColor(finalFill.levels!.first.color),
            size: width!.get(context: context, isWidth: true),
          ),
        );
      },
    );
  }
}
