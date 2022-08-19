// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

//ignore: must_be_immutable
class WCondition extends StatelessWidget {
  /// Returns a if condition widget
  const WCondition(
    final Key? key, {
    required this.children,
    required this.node,
    required this.value,
    required this.valueOfCond,
    required this.conditionType,
    required this.forPlay,
    required this.params,
    required this.states,
    required this.dataset,
    this.loop,
  }) : super(key: key);

  final CNode node;
  final List<CNode> children;
  final bool forPlay;
  final FTextTypeInput value;
  final FTextTypeInput valueOfCond;
  final ConditionType conditionType;
  final int? loop;

  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

  @override
  Widget build(final BuildContext context) {
    return NodeSelectionBuilder(
      node: node,
      forPlay: forPlay,
      child: _body(context),
    );
  }

  Widget _body(final BuildContext context) {
    final finalValue = value.get(
      params,
      states,
      dataset,
      forPlay,
      loop,
      context,
    );
    final finalValueOfCond = valueOfCond.get(
      params,
      states,
      dataset,
      forPlay,
      loop,
      context,
    );

    return (finalValue == finalValueOfCond)
        ? children.isNotEmpty
            ? children.first.toWidget(
                params: params,
                states: states,
                dataset: dataset,
                forPlay: forPlay,
              )
            : PlaceholderChildBuilder(
                name: node.intrinsicState.displayName,
                node: node,
                forPlay: forPlay,
              )
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
