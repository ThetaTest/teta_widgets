// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

class WDivider extends StatelessWidget {
  /// Returns a Divider widget
  const WDivider(
    final Key? key, {
    required this.node,
    required this.height,
    required this.fill,
    required this.forPlay,
    required this.params,
    required this.states,
    required this.dataset,
    this.child,
    this.loop,
  }) : super(key: key);

  final CNode node;
  final CNode? child;
  final FSize height;
  final FFill fill;
  final bool forPlay;
  final int? loop;

  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

  @override
  Widget build(final BuildContext context) {
    final isLight = BlocProvider.of<PaletteDarkLightCubit>(context).state;
    PaletteModel? model;
    BlocProvider.of<PaletteBloc>(context).state.forEach((final element) {
      if (element.id == fill.paletteStyle) model = element;
    });
    return NodeSelectionBuilder(
      node: node,
      forPlay: forPlay,
      child: Divider(
        height: height.get(context: context, isWidth: false),
        color: _getDividerColor(model, isLight),
      ),
    );
  }

  // ignore: avoid_positional_boolean_parameters
  HexColor _getDividerColor(final PaletteModel? model, final bool isLight) {
    if (model != null) {
      return isLight
          ? HexColor(model.light!.levels!.first.color)
          : HexColor(model.fill!.levels!.first.color);
    } else {
      return HexColor(fill.levels!.first.color);
    }
  }
}
