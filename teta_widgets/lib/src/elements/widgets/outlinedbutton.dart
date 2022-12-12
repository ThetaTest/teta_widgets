// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

class WOutlinedButton extends StatelessWidget {
  /// Returns a OutlinedButton
  const WOutlinedButton(
    final Key? key, {
    required this.state,
    this.action,
    this.child,
  }) : super(key: key);

  final TetaWidgetState state;
  final CNode? child;
  final FAction? action;

  @override
  Widget build(final BuildContext context) {
    return TetaWidget(
      state: state,
      child: OutlinedButton(
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
