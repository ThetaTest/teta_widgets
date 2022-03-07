// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:teta_core/teta_core.dart';

// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

// ignore_for_file: public_member_api_docs

class WOverFlowBox extends StatelessWidget {
  /// Returns a [Center] widget in Teta
  const WOverFlowBox(
    Key? key, {
    required this.node,
    required this.forPlay,
    required this.params,
    required this.states,
    required this.dataset,
    required this.minWidth,
    required this.maxWidth,
    required this.maxHeight,
    required this.minHeight,
    this.child,
    this.loop,
  }) : super(key: key);

  final CNode node;
  final CNode? child;
  final bool forPlay;
  final int? loop;
  final FSize minWidth;
  final FSize minHeight;
  final FSize maxWidth;
  final FSize maxHeight;

  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

  @override
  Widget build(BuildContext context) {
    return NodeSelectionBuilder(
      node: node,
      forPlay: forPlay,
      child: OverflowBox(
        minWidth: minWidth.get(context: context, isWidth: true) ?? 0,
        minHeight: minHeight.get(context: context, isWidth: false) ?? 0,
        maxWidth: maxWidth.get(context: context, isWidth: true) ?? 0,
        maxHeight: maxHeight.get(context: context, isWidth: false) ?? 0,
        child: ChildConditionBuilder(
          ValueKey('${node.nid} $loop'),
          name: node.intrinsicState.displayName,
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
}
