import 'package:flutter/material.dart';
import 'package:teta_widgets/src/elements/builder/gesture_detector_base.dart';
import 'package:teta_widgets/src/elements/index.dart';
import 'package:teta_widgets/src/elements/widgets/teta_widget/teta_widget_state.dart';

class TetaWidget extends StatelessWidget {
  const TetaWidget({
    required this.state,
    required this.child,
    super.key,
  });

  final TetaWidgetState state;
  final Widget? child;

  @override
  Widget build(final BuildContext context) {
    return NodeSelectionBuilder(
      node: state.node,
      forPlay: state.forPlay,
      child: GestureBuilderBase.get(
        context: context,
        node: state.node,
        params: state.params,
        states: state.states,
        dataset: state.dataset,
        forPlay: state.forPlay,
        loop: state.loop,
        child: child ?? const SizedBox.shrink(),
      ),
    );
  }
}
