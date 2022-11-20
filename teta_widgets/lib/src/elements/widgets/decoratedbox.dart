// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/builder/gesture_detector_base.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';
import 'package:teta_widgets/src/core/teta_widget/teta_widget.dart';
import 'package:teta_widgets/src/core/teta_widget/teta_widget_state.dart';

class WDecoratedBox extends StatelessWidget {
  /// Returns a DecoratedBox widget
  const WDecoratedBox(
    final Key? key, {
    required this.state,
    // Widget params
    required this.fill,
    required this.borderRadius,
    required this.shadows,
    this.child,
  }) : super(key: key);

  final TetaWidgetState state;

  final FFill fill;
  final FBorderRadius borderRadius;
  final FShadow shadows;
  final CNode? child;

  @override
  Widget build(final BuildContext context) {
    return TetaWidget(
      state: state,
      child: DecoratedBox(
        decoration: TetaBoxDecoration.get(
          context: context,
          fill: fill.get(context),
          borderRadius: borderRadius,
          shadow: shadows,
        ),
        child: ChildConditionBuilder(
          ValueKey('${state.node.nid} ${state.loop}'),
          state: state,
          child: child,
        ),
      ),
    );
  }
}
