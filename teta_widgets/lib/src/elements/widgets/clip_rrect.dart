// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

// ignore_for_file: public_member_api_docs

class WClipRRect extends StatelessWidget {
  /// Returns a [Center] widget in Teta
  const WClipRRect(
    final Key? key, {
    required this.state,
    required this.borderRadius,
    this.child,
  }) : super(key: key);

  final TetaWidgetState state;
  final FBorderRadius borderRadius;
  final CNode? child;

  @override
  Widget build(final BuildContext context) {
    return TetaWidget(
      state: state,
      child: ClipRRect(
        borderRadius: borderRadius.get(context),
        child: ChildConditionBuilder(
          ValueKey(state.toKey),
          state: state,
          child: child,
        ),
      ),
    );
  }
}
