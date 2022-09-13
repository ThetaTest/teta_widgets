// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

/// Builder
class GestureBuilderBase {
  /// Get a gesture code based on FAction
  static Widget get({
    required final BuildContext context,
    required final CNode node,
    required final List<VariableObject> params,
    required final List<VariableObject> states,
    required final List<DatasetObject> dataset,
    required final bool forPlay,
    required final Widget child,
    final int? loop,
  }) {
    if (node.body.attributes[DBKeys.action] != null) {
      return GestureDetector(
        onTap: () {
          GestureBuilder.get(
            context: context,
            node: node,
            gesture: ActionGesture.onTap,
            action: node.body.attributes[DBKeys.action] as FAction,
            actionValue: null,
            params: params,
            states: states,
            dataset: dataset,
            loop: loop,
            forPlay: forPlay,
          );
        },
        onDoubleTap: () => GestureBuilder.get(
          context: context,
          node: node,
          gesture: ActionGesture.onDoubleTap,
          action: node.body.attributes[DBKeys.action] as FAction,
          actionValue: null,
          params: params,
          states: states,
          dataset: dataset,
          loop: loop,
          forPlay: forPlay,
        ),
        onLongPress: () => GestureBuilder.get(
          context: context,
          node: node,
          gesture: ActionGesture.onLongPress,
          action: node.body.attributes[DBKeys.action] as FAction,
          actionValue: null,
          params: params,
          states: states,
          dataset: dataset,
          loop: loop,
          forPlay: forPlay,
        ),
        child: child,
      );
    }
    return child;
  }
}
