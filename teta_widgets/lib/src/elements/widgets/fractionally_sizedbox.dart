// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/builder/gesture_detector_base.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

class WFractionallySizedBox extends StatelessWidget {
  /// Returns a FractionallySizedBox widget in Teta
  const WFractionallySizedBox(
    final Key? key, {
    required this.node,
    required this.forPlay,
    required this.widthFactor,
    required this.heightFactor,
    required this.params,
    required this.states,
    required this.dataset,
    this.child,
    this.loop,
  }) : super(key: key);

  /// Node params
  final CNode node;
  final CNode? child;
  final bool forPlay;
  final int? loop;

  // Widget params
  final FSize? widthFactor;
  final FSize? heightFactor;

  // Widget states (inherit from page state)
  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

  @override
  Widget build(final BuildContext context) {
    return NodeSelectionBuilder(
      node: node,
      forPlay: forPlay,
      child: GestureBuilderBase.get(
        context: context,
        node: node,
        params: params,
        states: states,
        dataset: dataset,
        forPlay: forPlay,
        loop: loop,
        child: FractionallySizedBox(
          widthFactor: widthFactor?.get(context: context, isWidth: true),
          heightFactor: heightFactor?.get(context: context, isWidth: false),
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
      ),
    );
  }
}
