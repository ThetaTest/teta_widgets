// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:theta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:theta_widgets/src/elements/index.dart';

// ignore_for_file: public_member_api_docs

class WRotatedBox extends StatelessWidget {
  /// Returns a [Center] widget in Teta
  const WRotatedBox(
    final Key? key, {
    required this.state,
    required this.quarterTurns,
    this.child,
  }) : super(key: key);

  final TetaWidgetState state;
  final CNode? child;
  final FTextTypeInput quarterTurns;

  @override
  Widget build(final BuildContext context) {
    final val = quarterTurns.get(
      state.params,
      state.states,
      state.dataset,
      state.forPlay,
      state.loop,
      context,
    );
    return TetaWidget(
      state: state,
      child: RotatedBox(
        quarterTurns: int.tryParse(val) ?? 0,
        child: ChildConditionBuilder(
          ValueKey(state.toKey),
          state: state,
          child: child,
        ),
      ),
    );
  }
}
