// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

class WOffStage extends StatelessWidget {
  /// Returns a Container widget
  const WOffStage(
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
    final val = value
        .get(
          state.params,
          state.states,
          state.dataset,
          state.forPlay,
          state.loop,
          context,
        )
        .replaceAll(' ', '');
    return TetaWidget(
      state: state,
      child: Offstage(
        offstage: val == 'true',
        child: ChildConditionBuilder(
          ValueKey(state.toKey),
          state: state,
          child: child,
        ),
      ),
    );
  }
}
