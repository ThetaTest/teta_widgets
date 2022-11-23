// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_widgets/src/core/teta_widget/index.dart';
import 'package:teta_widgets/src/elements/builder/gesture_detector_base.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

class WGestureDetector extends StatelessWidget {
  /// Returns a Gesture Detector
  const WGestureDetector(
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
    return GestureDetector(
      onTap: () {
        GestureBuilder.get(
          context: context,
          node: state.node,
          gesture: ActionGesture.onTap,
          action: action,
          actionValue: null,
          params: state.params,
          states: state.states,
          dataset: state.dataset,
          loop: state.loop,
          forPlay: state.forPlay,
        );
      },
      onDoubleTap: () => GestureBuilder.get(
        context: context,
        node: state.node,
        gesture: ActionGesture.onDoubleTap,
        action: action,
        actionValue: null,
        params: state.params,
        states: state.states,
        dataset: state.dataset,
        loop: state.loop,
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
        loop: state.loop,
        forPlay: state.forPlay,
      ),
      child: GestureBuilderBase.get(
        context: context,
        state: state,
        child: ChildConditionBuilder(
          ValueKey('${state.node.nid} ${state.loop}'),
          state: state,
          child: child,
        ),
      ),
    );
  }
}
