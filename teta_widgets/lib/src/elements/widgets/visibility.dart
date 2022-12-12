// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
// Project imports:
import 'package:teta_widgets/src/core/teta_widget/index.dart';
import 'package:teta_widgets/src/elements/index.dart';

class WVisibility extends StatelessWidget {
  /// Returns a Opacity widget
  const WVisibility(
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
    final val = value.get(
      state.params,
      state.states,
      state.dataset,
      state.forPlay,
      state.loop,
      context,
    );
    return TetaWidget(
      state: state,
      child: Visibility(
        visible: val == 'true',
        child: ChildConditionBuilder(
          ValueKey(state.toKey),
          state: state,
          child: child,
        ),
      ),
    );
  }
}
