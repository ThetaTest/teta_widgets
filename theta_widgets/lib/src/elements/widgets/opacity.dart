// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

class WOpacity extends StatelessWidget {
  /// Returns a Opacity widget
  const WOpacity(
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
    final opacityString = value.get(
      state.params,
      state.states,
      state.dataset,
      state.forPlay,
      state.loop,
      context,
    );
    final tempOpacity = double.tryParse(opacityString) ?? 1;
    final opacity = tempOpacity >= 0 && tempOpacity <= 1 ? tempOpacity : 1.0;
    return TetaWidget(
      state: state,
      child: Opacity(
        opacity: opacity,
        child: ChildConditionBuilder(
          ValueKey(state.toKey),
          state: state,
          child: child,
        ),
      ),
    );
  }
}
