// Flutter imports:

// Package imports:
import 'package:auth_buttons/auth_buttons.dart';
// Flutter imports:
import 'package:flutter/material.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

// ignore_for_file: public_member_api_docs

class WLoginWithTwitter extends StatelessWidget {
  /// Returns a Twitter login button
  const WLoginWithTwitter(
    final Key? key, {
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
  Widget build(final BuildContext context) {
    return NodeSelectionBuilder(
      node: node,
      forPlay: forPlay,
      child: SizedBox(
        width: width.get(context: context, isWidth: true),
        height: height.get(context: context, isWidth: false),
        child: TwitterAuthButton(
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
