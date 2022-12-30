// Flutter imports:
// ignore_for_file: public_member_api_docs

// Package imports:
import 'package:bouncing_widget/bouncing_widget.dart';
// Flutter imports:
import 'package:flutter/material.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

class WBouncingWidget extends StatelessWidget {
  /// Returns a Container widget
  const WBouncingWidget(
    final Key? key, {
    required this.state,
    required this.action,
    required this.value,
    required this.valueOfCondition,
    this.child,
  }) : super(key: key);

  final TetaWidgetState state;
  final CNode? child;
  final FAction action;
  final FTextTypeInput value;
  final FTextTypeInput valueOfCondition;

  @override
  Widget build(final BuildContext context) {
    final val = value.get(
      state.params,
      state.states,
      state.dataset,
      state.forPlay,
      state.loop,
      context,
    );
    final scale = valueOfCondition.get(
      state.params,
      state.states,
      state.dataset,
      state.forPlay,
      state.loop,
      context,
    );
    return NodeSelectionBuilder(
      state: state,
      child: BouncingWidget(
        duration: Duration(milliseconds: int.tryParse(val) ?? 200),
        scaleFactor: double.tryParse(scale) ?? 1,
        onPressed: () => GestureBuilder.get(
          context: context,
          state: state,
          gesture: ActionGesture.onTap,
          action: action,
          actionValue: null,
        ),
        child: ChildConditionBuilder(
          ValueKey(state.toKey),
          state: state,
          child: child,
        ),
      ),
    );
  }
}
