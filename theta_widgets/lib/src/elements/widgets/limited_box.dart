// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
// Package imports:
import 'package:theta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:theta_widgets/src/elements/index.dart';

class WLimitedBox extends StatefulWidget {
  /// Returns a LimitedBox widget
  const WLimitedBox(
    final Key? key, {
    required this.state,
    required this.maxWidth,
    required this.maxHeight,
    this.child,
  }) : super(key: key);

  final TetaWidgetState state;
  final CNode? child;
  final FSize maxWidth;
  final FSize maxHeight;

  @override
  State<WLimitedBox> createState() => _WLimitedBoxState();
}

class _WLimitedBoxState extends State<WLimitedBox> with AfterLayoutMixin {
  late final double maxW;
  late final double maxH;

  @override
  FutureOr<void> afterFirstLayout(final BuildContext context) {
    setState(() {
      maxW = widget.maxWidth.get(
            context: context,
            isWidth: true,
            forPlay: widget.state.forPlay,
          ) ??
          double.infinity;
      maxH = widget.maxHeight.get(
            context: context,
            isWidth: false,
            forPlay: widget.state.forPlay,
          ) ??
          double.infinity;
    });
  }

  @override
  Widget build(final BuildContext context) {
    return TetaWidget(
      state: widget.state,
      child: LimitedBox(
        maxWidth: maxW,
        maxHeight: maxH,
        child: ChildConditionBuilder(
          ValueKey('${widget.state.node.nid} ${widget.state.loop}'),
          state: widget.state,
          child: widget.child,
        ),
      ),
    );
  }
}
