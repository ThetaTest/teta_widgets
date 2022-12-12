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
    required this.offStage,
    this.child,
  }) : super(key: key);

  final TetaWidgetState state;
  final CNode? child;
  final bool offStage;

  @override
  Widget build(final BuildContext context) {
    return TetaWidget(
      state: state,
      child: Offstage(
        offstage: offStage,
        child: ChildConditionBuilder(
          ValueKey(state.toKey),
          state: state,
          child: child,
        ),
      ),
    );
  }
}
