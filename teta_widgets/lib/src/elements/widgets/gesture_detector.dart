// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

class WGestureDetector extends StatelessWidget {
  /// Returns a Gesture Detector
  const WGestureDetector(
    final Key? key, {
    required this.node,
    required this.forPlay,
    required this.params,
    required this.states,
    required this.dataset,
    this.loop,
    this.child,
    this.action,
  }) : super(key: key);

  final CNode node;
  final CNode? child;
  final bool forPlay;
  final int? loop;
  final FAction? action;

  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

  @override
  Widget build(final BuildContext context) {
    return GestureDetector(
      onTap: () {
        GestureBuilder.get(
          context: context,
          node: node,
          gesture: ActionGesture.onTap,
          action: action,
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
        action: action,
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
        action: action,
        actionValue: null,
        params: params,
        states: states,
        dataset: dataset,
        loop: loop,
        forPlay: forPlay,
      ),
      child: ChildConditionBuilder(
        ValueKey('${node.nid} $loop'),
        name: node.intrinsicState.displayName,
        child: child,
        params: params,
        states: states,
        dataset: dataset,
        forPlay: forPlay,
        loop: loop,
      ),
    );
  }
}
