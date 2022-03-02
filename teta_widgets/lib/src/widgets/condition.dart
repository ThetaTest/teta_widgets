// Flutter imports:
// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_core/teta_core.dart';

//ignore: must_be_immutable
class WCondition extends StatelessWidget {
  /// Returns a if condition widget
  const WCondition({
    Key? key,
    this.nid,
    required this.children,
    required this.node,
    required this.value,
    required this.valueOfCond,
    required this.conditionType,
    required this.forPlay,
    this.index,
    this.component,
    this.loop,
    required this.params,
    required this.states,
    required this.dataset,
  }) : super(key: key);

  final CNode node;
  final String? nid;
  final List<CNode> children;
  final double? index;
  final bool forPlay;
  final FTextTypeInput value;
  final FTextTypeInput valueOfCond;
  final ConditionType conditionType;
  final String? component;
  final int? loop;

  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

  @override
  Widget build(BuildContext context) {
    return NodeSelectionBuilder(
      node: node,
      forPlay: forPlay,
      child: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    final finalValue = value.get(params, states, dataset, forPlay, loop);
    final finalValueOfCond =
        valueOfCond.get(params, states, dataset, forPlay, loop);

    return (finalValue == finalValueOfCond)
        ? children.isNotEmpty
            ? children.first.toWidget(
                params: params,
                states: states,
                dataset: dataset,
                forPlay: forPlay,
              )
            : PlaceholderChildBuilder(name: node.intrinsicState.displayName)
        : children.isNotEmpty
            ? children.length > 1
                ? children.last.toWidget(
                    params: params,
                    states: states,
                    dataset: dataset,
                    forPlay: forPlay,
                  )
                : const SizedBox()
            : const SizedBox();
  }
}
