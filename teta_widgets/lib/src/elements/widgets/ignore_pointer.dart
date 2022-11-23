// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

class WIgnorePointer extends StatelessWidget {
  /// Returns a IgnorePointer
  const WIgnorePointer(
    final Key? key, {
    required this.state,
    required this.flag,
    this.child,
  }) : super(key: key);

  final TetaWidgetState state;
  final CNode? child;
  final bool flag;

  @override
  Widget build(final BuildContext context) {
    return TetaWidget(
      state: state,
      child: IgnorePointer(
        ignoring: flag,
        child: ChildConditionBuilder(
          ValueKey('${state.node.nid} ${state.loop}'),
          state: state,
          child: child,
        ),
      ),
    );
  }
}
