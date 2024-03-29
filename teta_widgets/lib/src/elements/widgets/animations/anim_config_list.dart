// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
// Package imports:
import 'package:teta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

// Project imports:

// ignore_for_file: public_member_api_docs

class WAnimationConfigurationListView extends StatelessWidget {
  /// Returns a [Align] widget in Teta
  const WAnimationConfigurationListView(
    final Key? key, {
    required this.state,
    required this.index,
    required this.duration,
    this.child,
  }) : super(key: key);

  final TetaWidgetState state;
  final CNode? child;
  final FTextTypeInput index;
  final FTextTypeInput duration;

  @override
  Widget build(final BuildContext context) {
    return NodeSelectionBuilder(
      state: state,
      child: AnimationConfiguration.staggeredList(
        position: int.tryParse(
              index.get(
                state.params,
                state.states,
                state.dataset,
                state.forPlay,
                state.loop,
                context,
              ),
            ) ??
            0,
        duration: Duration(
          milliseconds: int.tryParse(
                duration.get(
                  state.params,
                  state.states,
                  state.dataset,
                  state.forPlay,
                  state.loop,
                  context,
                ),
              ) ??
              375,
        ),
        child: ChildConditionBuilder(
          ValueKey(state.toKey),
          state: state,
          child: child,
        ),
      ),
    );
  }
}
