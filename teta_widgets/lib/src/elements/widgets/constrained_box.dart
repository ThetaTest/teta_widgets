// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

// ignore_for_file: public_member_api_docs

class WConstrainedBox extends StatelessWidget {
  /// Returns a [Center] widget in Teta
  const WConstrainedBox(
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
    final minW = minWidth.get(
          context: context,
          isWidth: true,
          forPlay: state.forPlay,
        ) ??
        0;
    final minH = minHeight.get(
          context: context,
          isWidth: false,
          forPlay: state.forPlay,
        ) ??
        0;
    final maxW = maxWidth.get(
          context: context,
          isWidth: true,
          forPlay: state.forPlay,
        ) ??
        double.infinity;
    final maxH = maxHeight.get(
          context: context,
          isWidth: false,
          forPlay: state.forPlay,
        ) ??
        double.infinity;

    return TetaWidget(
      state: state,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: minW,
          minHeight: minH,
          maxWidth: maxW,
          maxHeight: maxH,
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
