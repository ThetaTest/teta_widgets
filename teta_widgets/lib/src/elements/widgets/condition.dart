// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

//ignore: must_be_immutable
class WCondition extends StatelessWidget {
  /// Returns a if condition widget
  const WCondition(
    final Key? key, {
    required this.state,
    required this.children,
    required this.value,
    required this.valueOfCond,
    required this.conditionType,
  }) : super(key: key);

  final TetaWidgetState state;
  final List<CNode> children;
  final FTextTypeInput value;
  final FTextTypeInput valueOfCond;
  final ConditionType conditionType;

  @override
  Widget build(final BuildContext context) {
    return TetaWidget(
      state: state,
      child: _body(context),
    );
  }

  Widget _body(final BuildContext context) {
    final finalValue = value.get(
      state.params,
      state.states,
      state.dataset,
      state.forPlay,
      state.loop,
      context,
    );
    final finalValueOfCond = valueOfCond.get(
      state.params,
      state.states,
      state.dataset,
      state.forPlay,
      state.loop,
      context,
    );

    return (finalValue == finalValueOfCond)
        ? children.isNotEmpty
            ? children.first.toWidget(state: state)
            : PlaceholderChildBuilder(
                name: state.node.intrinsicState.displayName,
                node: state.node,
                forPlay: state.forPlay,
              )
        : children.isNotEmpty
            ? children.length > 1
                ? children.last.toWidget(state: state)
                : const SizedBox()
            : const SizedBox();
  }
}
