// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

// ignore_for_file: public_member_api_docs

class WOverFlowBox extends StatelessWidget {
  /// Returns a [Center] widget in Teta
  const WOverFlowBox(
    final Key? key, {
    required this.state,
    required this.minWidth,
    required this.maxWidth,
    required this.maxHeight,
    required this.minHeight,
    this.child,
  }) : super(key: key);

  final TetaWidgetState state;
  final CNode? child;
  final FSize minWidth;
  final FSize minHeight;
  final FSize maxWidth;
  final FSize maxHeight;

  @override
  Widget build(final BuildContext context) {
    return TetaWidget(
      state: state,
      child: OverflowBox(
        minWidth: minWidth.get(context: context, isWidth: true) ?? 0,
        minHeight: minHeight.get(context: context, isWidth: false) ?? 0,
        maxWidth: maxWidth.get(context: context, isWidth: true) ?? 0,
        maxHeight: maxHeight.get(context: context, isWidth: false) ?? 0,
        child: ChildConditionBuilder(
          ValueKey('${state.node.nid} ${state.loop}'),
          state: state,
          child: child,
        ),
      ),
    );
  }
}
