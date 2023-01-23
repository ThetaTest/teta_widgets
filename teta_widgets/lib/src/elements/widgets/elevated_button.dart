import 'package:flutter/material.dart';

import '../../core/teta_widget/index.dart';
import '../index.dart';

class WElevatedButton extends StatelessWidget {
  /// Returns a TextButton widget in Teta
  const WElevatedButton(
    final Key? key, {
    required this.state,
    this.child,
    this.action,
  }) : super(key: key);

  final TetaWidgetState state;
  final CNode? child;
  final FAction? action;

  @override
  Widget build(final BuildContext context) {
    return NodeSelectionBuilder(
      node: state.node,
      forPlay: state.forPlay,
      child: TextButton(
        onPressed: () => GestureBuilder.get(
          context: context,
          state: state,
          gesture: ActionGesture.onTap,
          actionValue: null,
          action: action,
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
