// Flutter imports:

// Package imports:
import 'package:auth_buttons/auth_buttons.dart';
// Flutter imports:
import 'package:flutter/material.dart';
import 'package:theta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:theta_widgets/src/elements/index.dart';

// ignore_for_file: public_member_api_docs

class WLoginWithMicrosoft extends StatelessWidget {
  /// Returns a Facebook login button
  const WLoginWithMicrosoft(
    final Key? key, {
    required this.state,
    required this.width,
    required this.height,
    this.child,
    this.action,
  }) : super(key: key);

  final TetaWidgetState state;
  final FSize width;
  final FSize height;
  final CNode? child;
  final NodeGestureActions? action;

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
        child: MicrosoftAuthButton(
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
