// Flutter imports:
// ignore_for_file: public_member_api_docs

import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_core/teta_core.dart';

class WBouncingWidget extends StatelessWidget {
  /// Returns a Container widget
  const WBouncingWidget({
    Key? key,
    required this.node,
    required this.action,
    required this.value,
    required this.valueOfCondition,
    required this.forPlay,
    required this.params,
    required this.states,
    required this.dataset,
    this.child,
    this.loop,
  }) : super(key: key);

  final CNode node;
  final CNode? child;
  final FAction action;
  final FTextTypeInput value;
  final FTextTypeInput valueOfCondition;
  final bool forPlay;
  final int? loop;

  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

  @override
  Widget build(BuildContext context) {
    final val = value.get(params, states, dataset, forPlay, loop);
    final scale = valueOfCondition.get(params, states, dataset, forPlay, loop);
    return NodeSelectionBuilder(
      node: node,
      forPlay: forPlay,
      child: BouncingWidget(
        duration: Duration(milliseconds: int.tryParse(val) ?? 200),
        scaleFactor: double.tryParse(scale) ?? 1,
        onPressed: () => GestureBuilder.get(
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
        child: ChildConditionBuilder(
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
