// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:theta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:theta_widgets/src/elements/index.dart';

class WFittedBox extends StatelessWidget {
  /// Returns a Container widget
  const WFittedBox(
    final Key? key, {
    required this.state,
    required this.boxFit,
    this.child,
  }) : super(key: key);

  final TetaWidgetState state;
  final CNode? child;
  final FBoxFit boxFit;

  @override
  Widget build(final BuildContext context) {
    return TetaWidget(
      state: state,
      child: FittedBox(
        child: ChildConditionBuilder(
          ValueKey(state.toKey),
          state: state,
          child: child,
        ),
      ),
    );
  }
}
