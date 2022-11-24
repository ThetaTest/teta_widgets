// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

// ignore_for_file: public_member_api_docs

class WAppBar extends StatelessWidget {
  /// Returns a empty widget which contains all the app bar widgets
  const WAppBar(
    final Key? key, {
    required this.state,
    this.child,
  }) : super(key: key);

  final TetaWidgetState state;
  final CNode? child;

  @override
  Widget build(final BuildContext context) {
    return TetaWidget(
      state: state,
      child: ChildConditionBuilder(
        ValueKey('${state.node.nid} ${state.loop}'),
        state: state,
        child: child,
      ),
    );
  }
}
