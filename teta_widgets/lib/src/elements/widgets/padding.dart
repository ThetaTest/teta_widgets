// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

class WPadding extends StatelessWidget {
  /// Returns a Padding widget
  const WPadding(
    final Key? key, {
    required this.state,
    required this.padding,
    this.child,
  }) : super(key: key);

  final TetaWidgetState state;
  final CNode? child;
  final FMargins padding;

  @override
  Widget build(final BuildContext context) {
    return TetaWidget(
      state: state,
      child: Padding(
        padding: padding.get(
          context,
          forPlay: state.forPlay,
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
