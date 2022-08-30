// Flutter imports:

// Package imports:
import 'package:badges/badges.dart';
// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

// ignore_for_file: public_member_api_docs

class WBadge extends StatelessWidget {
  /// Returns a [Badge] widget in Teta
  const WBadge(
    final Key? key, {
    required this.value,
    required this.node,
    required this.textStyle,
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
  final FTextTypeInput value;
  final FTextStyle textStyle;
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
      if (element.name == fill.paletteStyle) model = element;
    });
    return NodeSelectionBuilder(
      node: node,
      forPlay: forPlay,
      child: Badge(
        badgeContent: TextBuilder(
          textStyle: textStyle,
          value: value,
          params: params,
          states: states,
          dataset: dataset,
          forPlay: forPlay,
        ),
        badgeColor: _getbadgeColor(model, isLight),
        child: ChildConditionBuilder(
          ValueKey('${node.nid} $loop'),
          name: node.intrinsicState.displayName,
          node: node,
          child: child,
          params: params,
          states: states,
          dataset: dataset,
          forPlay: forPlay,
          loop: loop,
        ),
      ),
    );
  }

  // ignore: avoid_positional_boolean_parameters
  HexColor _getbadgeColor(final PaletteModel? model, final bool isLight) {
    if (model != null) {
      return isLight
          ? HexColor(model.light!.levels!.first.color)
          : HexColor(model.fill!.levels!.first.color);
    } else {
      return HexColor(fill.levels!.first.color);
    }
  }
}
