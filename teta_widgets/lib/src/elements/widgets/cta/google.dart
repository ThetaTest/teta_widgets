// Flutter imports:

// Package imports:
import 'package:auth_buttons/auth_buttons.dart';
// Flutter imports:
import 'package:flutter/material.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

// ignore_for_file: public_member_api_docs

class WLoginWithGoogle extends StatelessWidget {
  /// Returns a Google SignIn button
  const WLoginWithGoogle(
    final Key? key, {
    required this.state,
    required this.width,
    required this.height,
    this.child,
    this.action,
  }) : super(key: key);

  final TetaWidgetState state;
  final CNode? child;
  final FAction? action;
  final FSize width;
  final FSize height;

  @override
  Widget build(final BuildContext context) {
    return NodeSelectionBuilder(
      node: state.node,
      forPlay: state.forPlay,
      child: SizedBox(
        width: width.get(context: context, isWidth: true),
        height: height.get(context: context, isWidth: false),
        child: GoogleAuthButton(
          onPressed: () => GestureBuilder.get(
            context: context,
            node: state.node,
            gesture: ActionGesture.onTap,
            action: action,
            actionValue: null,
            params: state.params,
            states: state.states,
            dataset: state.dataset,
            forPlay: state.forPlay,
          ),
          onLongPress: () => GestureBuilder.get(
            context: context,
            node: state.node,
            gesture: ActionGesture.onLongPress,
            action: action,
            actionValue: null,
            params: state.params,
            states: state.states,
            dataset: state.dataset,
            forPlay: state.forPlay,
          ),
          style: const AuthButtonStyle(
            padding: EdgeInsets.symmetric(vertical: 16),
          ),
        ),
      ),
    );
  }
}
