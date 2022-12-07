// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
// Package imports:
import 'package:teta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

// Project imports:

// ignore_for_file: public_member_api_docs

class WFadeInAnimation extends StatelessWidget {
  /// Returns a [Align] widget in Teta
  const WFadeInAnimation(
    final Key? key, {
    required this.state,
    this.child,
  }) : super(key: key);

  final TetaWidgetState state;
  final CNode? child;

  @override
  Widget build(final BuildContext context) {
    return NodeSelectionBuilder(
      node: state.node,
      forPlay: state.forPlay,
      child: FadeInAnimation(
        child: ChildConditionBuilder(
          ValueKey('${state.node.nid} ${state.loop}'),
          state: state,
          child: child,
        ),
      ),
    );
  }
}
