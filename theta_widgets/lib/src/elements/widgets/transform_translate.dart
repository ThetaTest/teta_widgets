// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:theta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:theta_widgets/src/elements/index.dart';

// ignore_for_file: public_member_api_docs

class WTransformTranslate extends StatelessWidget {
  /// Returns a tooltip widget in Teta
  const WTransformTranslate(
    final Key? key, {
    required this.state,
    required this.valueX,
    required this.valueY,
    this.child,
  }) : super(key: key);

  final TetaWidgetState state;
  final CNode? child;
  final FTextTypeInput valueX;
  final FTextTypeInput valueY;

  @override
  Widget build(final BuildContext context) {
    return TetaWidget(
      state: state,
      child: Transform.translate(
        offset: Offset(
          double.tryParse(
                valueX.get(
                  state.params,
                  state.states,
                  state.dataset,
                  state.forPlay,
                  state.loop,
                  context,
                ),
              ) ??
              0,
          double.tryParse(
                valueY.get(
                  state.params,
                  state.states,
                  state.dataset,
                  state.forPlay,
                  state.loop,
                  context,
                ),
              ) ??
              0,
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
