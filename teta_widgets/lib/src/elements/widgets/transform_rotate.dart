// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

// ignore_for_file: public_member_api_docs

class WTransformRotate extends StatelessWidget {
  /// Returns a tooltip widget in Teta
  const WTransformRotate(
    final Key? key, {
    required this.state,
    required this.value,
    this.child,
  }) : super(key: key);

  final TetaWidgetState state;
  final CNode? child;
  final FTextTypeInput value;

  @override
  Widget build(final BuildContext context) {
    return TetaWidget(
      state: state,
      child: Transform.rotate(
        angle: double.tryParse(
              value.get(
                state.params,
                state.states,
                state.dataset,
                state.forPlay,
                state.loop,
                context,
              ),
            ) ??
            0,
        child: ChildConditionBuilder(
          ValueKey(state.toKey),
          state: state,
          child: child,
        ),
      ),
    );
  }
}
