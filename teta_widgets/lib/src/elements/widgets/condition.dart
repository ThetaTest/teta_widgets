// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
import 'package:teta_widgets/src/elements/features/condition_type.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';
import 'package:teta_models/teta_models.dart';

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
  final FConditionType conditionType;

  @override
  Widget build(final BuildContext context) {
    return TetaWidget(
      state: state,
      child: _body(context),
    );
  }

  Widget _body(final BuildContext context) {
    final condition = conditionType.get;
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

    if (condition == ConditionType.equal) {
      if (finalValue == finalValueOfCond) {
        return children.isNotEmpty
            ? children.first.toWidget(state: state)
            : PlaceholderChildBuilder(
                name: state.node.intrinsicState.displayName,
                node: state.node,
                forPlay: state.forPlay,
              );
      } else {
        return children.isNotEmpty
            ? children.length > 1
                ? children.last.toWidget(state: state)
                : const SizedBox()
            : const SizedBox();
      }
    } else if (condition == ConditionType.notEqual) {
      if (finalValue != finalValueOfCond) {
        return children.isNotEmpty
            ? children.first.toWidget(state: state)
            : PlaceholderChildBuilder(
                name: state.node.intrinsicState.displayName,
                node: state.node,
                forPlay: state.forPlay,
              );
      } else {
        return children.isNotEmpty
            ? children.length > 1
                ? children.last.toWidget(state: state)
                : const SizedBox()
            : const SizedBox();
      }
    } else if (condition == ConditionType.isNull) {
      if (finalValue == 'null') {
        return children.isNotEmpty
            ? children.first.toWidget(state: state)
            : PlaceholderChildBuilder(
                name: state.node.intrinsicState.displayName,
                node: state.node,
                forPlay: state.forPlay,
              );
      } else {
        return children.isNotEmpty
            ? children.length > 1
                ? children.last.toWidget(state: state)
                : const SizedBox()
            : const SizedBox();
      }
    } else if (condition == ConditionType.notNull) {
      if (finalValue != 'null') {
        return children.isNotEmpty
            ? children.first.toWidget(state: state)
            : PlaceholderChildBuilder(
                name: state.node.intrinsicState.displayName,
                node: state.node,
                forPlay: state.forPlay,
              );
      } else {
        return children.isNotEmpty
            ? children.length > 1
                ? children.last.toWidget(state: state)
                : const SizedBox()
            : const SizedBox();
      }
    } else if (condition == ConditionType.greaterThan) {
      if ((double.tryParse(finalValue) ?? 0) >
          (double.tryParse(finalValueOfCond) ?? 0)) {
        return children.isNotEmpty
            ? children.first.toWidget(state: state)
            : PlaceholderChildBuilder(
                name: state.node.intrinsicState.displayName,
                node: state.node,
                forPlay: state.forPlay,
              );
      } else {
        return children.isNotEmpty
            ? children.length > 1
                ? children.last.toWidget(state: state)
                : const SizedBox()
            : const SizedBox();
      }
    } else if (condition == ConditionType.greaterOrEqualThan) {
      if ((double.tryParse(finalValue) ?? 0) >=
          (double.tryParse(finalValueOfCond) ?? 0)) {
        return children.isNotEmpty
            ? children.first.toWidget(state: state)
            : PlaceholderChildBuilder(
                name: state.node.intrinsicState.displayName,
                node: state.node,
                forPlay: state.forPlay,
              );
      } else {
        return children.isNotEmpty
            ? children.length > 1
                ? children.last.toWidget(state: state)
                : const SizedBox()
            : const SizedBox();
      }
    } else if (condition == ConditionType.lessThan) {
      if ((double.tryParse(finalValue) ?? 0) <
          (double.tryParse(finalValueOfCond) ?? 0)) {
        return children.isNotEmpty
            ? children.first.toWidget(state: state)
            : PlaceholderChildBuilder(
                name: state.node.intrinsicState.displayName,
                node: state.node,
                forPlay: state.forPlay,
              );
      } else {
        return children.isNotEmpty
            ? children.length > 1
                ? children.last.toWidget(state: state)
                : const SizedBox()
            : const SizedBox();
      }
    } else if (condition == ConditionType.lessOrEqualThan) {
      if ((double.tryParse(finalValue) ?? 0) <=
          (double.tryParse(finalValueOfCond) ?? 0)) {
        return children.isNotEmpty
            ? children.first.toWidget(state: state)
            : PlaceholderChildBuilder(
                name: state.node.intrinsicState.displayName,
                node: state.node,
                forPlay: state.forPlay,
              );
      } else {
        return children.isNotEmpty
            ? children.length > 1
                ? children.last.toWidget(state: state)
                : const SizedBox()
            : const SizedBox();
      }
    } else if (condition == ConditionType.contains) {
      if (finalValue.contains(finalValueOfCond)) {
        return children.isNotEmpty
            ? children.first.toWidget(state: state)
            : PlaceholderChildBuilder(
                name: state.node.intrinsicState.displayName,
                node: state.node,
                forPlay: state.forPlay,
              );
      } else {
        return children.isNotEmpty
            ? children.length > 1
                ? children.last.toWidget(state: state)
                : const SizedBox()
            : const SizedBox();
      }
    } else if (condition == ConditionType.startsWith) {
      if (finalValue.startsWith(finalValueOfCond)) {
        return children.isNotEmpty
            ? children.first.toWidget(state: state)
            : PlaceholderChildBuilder(
                name: state.node.intrinsicState.displayName,
                node: state.node,
                forPlay: state.forPlay,
              );
      } else {
        return children.isNotEmpty
            ? children.length > 1
                ? children.last.toWidget(state: state)
                : const SizedBox()
            : const SizedBox();
      }
    } else if (condition == ConditionType.endsWith) {
      if (finalValue.endsWith(finalValueOfCond)) {
        return children.isNotEmpty
            ? children.first.toWidget(state: state)
            : PlaceholderChildBuilder(
                name: state.node.intrinsicState.displayName,
                node: state.node,
                forPlay: state.forPlay,
              );
      } else {
        return children.isNotEmpty
            ? children.length > 1
                ? children.last.toWidget(state: state)
                : const SizedBox()
            : const SizedBox();
      }
    }
    return const SizedBox();
  }
}
