// Flutter imports:

// Package imports:
import 'package:auth_buttons/auth_buttons.dart';
// Flutter imports:
import 'package:flutter/material.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

// ignore_for_file: public_member_api_docs

class WLoginWithGitHub extends StatelessWidget {
  /// Returns a GitHub login button
  const WLoginWithGitHub(
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
        child: GithubAuthButton(
          onPressed: () => GestureBuilder.get(
            context: context,
            state: state,
            gesture: ActionGesture.onTap,
            action: action,
            actionValue: null,
          ),
          onLongPress: () => GestureBuilder.get(
            context: context,
            state: state,
            gesture: ActionGesture.onLongPress,
            action: action,
            actionValue: null,
          ),
          style: const AuthButtonStyle(
            padding: EdgeInsets.symmetric(vertical: 16),
          ),
          // darkMode: false,
          //rtl: false,
        ),
      ),
    );
  }
}
