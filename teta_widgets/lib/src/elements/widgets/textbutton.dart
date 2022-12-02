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
          ValueKey('${state.node.nid} ${state.loop}'),
          state: state,
          child: child,
        ),
      ),
    );
  }
}
