// Flutter imports:
// Package imports:
// ignore_for_file: implementation_imports

// Package imports:
import 'package:auth_buttons/auth_buttons.dart';
// Flutter imports:
import 'package:flutter/material.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

// ignore_for_file: public_member_api_docs

class WLoginWithApple extends StatelessWidget {
  /// Returns a Apple SignIn button
  const WLoginWithApple(
    final Key? key, {
    required this.state,
    required this.width,
    required this.height,
    this.child,
    this.action,
  }) : super(key: key);

  final TetaWidgetState state;
  final CNode? child;
  final NodeGestureActions? action;
  final FSize width;
  final FSize height;

  @override
  Widget build(final BuildContext context) {
    return NodeSelectionBuilder(
      state: state,
      child: SizedBox(
        width: width.get(
          context: context,
          isWidth: true,
          forPlay: state.forPlay,
        ),
        height: height.get(
          context: context,
          isWidth: false,
          forPlay: state.forPlay,
        ),
        child: AppleAuthButton(
          onPressed: () => GestureBuilder.get(
            context: context,
            state: state,
            gesture: ActionGesture.onTap,
            nodeGestureActions: action,
            actionValue: null,
          ),
          onLongPress: () => GestureBuilder.get(
            context: context,
            state: state,
            gesture: ActionGesture.onLongPress,
            nodeGestureActions: action,
            actionValue: null,
          ),
          style: const AuthButtonStyle(
            padding: EdgeInsets.symmetric(vertical: 16),
          ),
        ),
      ),
    );
  }
}
