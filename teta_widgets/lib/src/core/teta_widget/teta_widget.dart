import 'package:flutter/material.dart';

import '../../elements/builder/gesture_detector_base.dart';
import '../../elements/index.dart';
import 'index.dart';

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
    return GestureBuilderBase.get(
      context: context,
      state: state,
      child: NodeSelectionBuilder(
        state: state,
        child: child ?? const SizedBox.shrink(),
      ),
    );
  }
}
