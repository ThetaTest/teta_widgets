// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:theta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:theta_widgets/src/elements/index.dart';

// ignore_for_file: public_member_api_docs

class WTransformScale extends StatelessWidget {
  /// Returns a tooltip widget in Teta
  const WTransformScale(
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
      child: Transform.scale(
        scale: double.tryParse(
              value.get(
                state.params,
                state.states,
                state.dataset,
                state.forPlay,
                state.loop,
                context,
              ),
            ) ??
            1,
        child: ChildConditionBuilder(
          ValueKey(state.toKey),
          state: state,
          child: child,
        ),
      ),
    );
  }
}
