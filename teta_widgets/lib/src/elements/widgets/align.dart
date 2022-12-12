// ignore_for_file: public_member_api_docs
// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

class WAlign extends StatelessWidget {
  /// Returns a [Align] widget in Teta
  const WAlign(
    final Key? key, {
    required this.state,
    required this.align,
    this.child,
  }) : super(key: key);

  final TetaWidgetState state;
  final CNode? child;
  final FAlign align;

  @override
  Widget build(final BuildContext context) {
    return TetaWidget(
      state: state,
      child: Align(
        alignment: align.get(context),
        child: ChildConditionBuilder(
          ValueKey(state.toKey),
          state: state,
          child: child,
        ),
      ),
    );
  }
}
