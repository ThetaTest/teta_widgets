// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:theta_widgets/src/core/teta_widget/teta_widget_state.dart';
import 'package:theta_widgets/src/elements/builder/gesture_detector_base.dart';
// Project imports:
import 'package:theta_widgets/src/elements/index.dart';

/// This widget doesn't work correctly.
/// Try to instantiate a Row and then as its children 2 Expanded.
/// They won't take all the space avaiable, as they are limited.

class WExpanded extends StatelessWidget {
  /// Returns a Expanded widget
  const WExpanded(
    final Key? key, {
    required this.state,
    this.child,
  }) : super(key: key);

  final TetaWidgetState state;
  final CNode? child;
  @override
  Widget build(final BuildContext context) {
    return Expanded(
      child: GestureBuilderBase.get(
        context: context,
        state: state,
        child: ChildConditionBuilder(
          ValueKey(state.toKey),
          state: state,
          child: child,
        ),
      ),
    );
  }
}
