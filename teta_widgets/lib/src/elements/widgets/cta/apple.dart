// Flutter imports:
// Package imports:
// ignore_for_file: implementation_imports

import 'package:auth_buttons/auth_buttons.dart';
import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/index.dart';

// ignore_for_file: public_member_api_docs

class WLoginWithApple extends StatelessWidget {
  /// Returns a Apple SignIn button
  const WLoginWithApple(
    Key? key, {
    required this.node,
    required this.forPlay,
    required this.width,
    required this.height,
    required this.params,
    required this.states,
    required this.dataset,
    this.child,
    this.loop,
    this.action,
  }) : super(key: key);

  final CNode node;
  final CNode? child;
  final bool forPlay;
  final int? loop;
  final FAction? action;
  final FSize width;
  final FSize height;

  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

  @override
  Widget build(BuildContext context) {
    return NodeSelectionBuilder(
      node: node,
      forPlay: forPlay,
      child: btn(context),
    );
  }

  /// Returns the button itself
  Widget btn(BuildContext context) {
    return AppleAuthButton(
      onPressed: () => GestureBuilder.get(
        context: context,
        node: node,
        gesture: ActionGesture.onTap,
        action: action,
        actionValue: null,
        params: params,
        states: states,
        dataset: dataset,
        forPlay: forPlay,
      ),
      onLongPress: () => GestureBuilder.get(
        context: context,
        node: node,
        gesture: ActionGesture.onLongPress,
        action: action,
        actionValue: null,
        params: params,
        states: states,
        dataset: dataset,
        forPlay: forPlay,
      ),
      style: AuthButtonStyle(
        padding: const EdgeInsets.symmetric(vertical: 16),
        width: width.get(context: context, isWidth: true),
        height: height.get(context: context, isWidth: false),
      ),
      // darkMode: false,
      //rtl: false,
    );
  }
}
