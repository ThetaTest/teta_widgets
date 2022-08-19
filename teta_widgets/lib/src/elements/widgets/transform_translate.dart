// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

// ignore_for_file: public_member_api_docs

class WTransformScale extends StatelessWidget {
  /// Returns a tooltip widget in Teta
  const WTransformScale(
    final Key? key, {
    required this.node,
    required this.valueX,
    required this.valueY,
    required this.forPlay,
    required this.params,
    required this.states,
    required this.dataset,
    this.child,
    this.loop,
  }) : super(key: key);

  final CNode node;
  final CNode? child;
  final FTextTypeInput valueX;
  final FTextTypeInput valueY;
  final bool forPlay;
  final int? loop;

  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

  @override
  Widget build(final BuildContext context) {
    return NodeSelectionBuilder(
      node: node,
      forPlay: forPlay,
      child: Transform.translate(
        offset: Offset(
          double.tryParse(
                valueX.get(
                  params,
                  states,
                  dataset,
                  forPlay,
                  loop,
                  context,
                ),
              ) ??
              0,
          double.tryParse(
                valueY.get(
                  params,
                  states,
                  dataset,
                  forPlay,
                  loop,
                  context,
                ),
              ) ??
              0,
        ),
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
}
