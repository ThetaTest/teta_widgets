// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

class WTextButton extends StatelessWidget {
  /// Returns a TextButton widget in Teta
  const WTextButton(
    final Key? key, {
    required this.state,
    this.child,
    this.action,
  }) : super(key: key);

  final TetaWidgetState state;
  final CNode? child;
  final NodeGestureActions? action;

  @override
  Widget build(final BuildContext context) {
    return NodeSelectionBuilder(
      state: state,
      child: TextButton(
        onPressed: () => GestureBuilder.get(
          context: context,
          state: state,
          gesture: ActionGesture.onTap,
          actionValue: null,
          nodeGestureActions: action,
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
