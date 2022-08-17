// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

// ignore_for_file: public_member_api_docs

class WConstrainedBox extends StatelessWidget {
  /// Returns a [Center] widget in Teta
  const WConstrainedBox(
    final Key? key, {
    required this.node,
    required this.forPlay,
    required this.params,
    required this.states,
    required this.dataset,
    required this.minWidth,
    required this.maxWidth,
    required this.maxHeight,
    required this.minHeight,
    this.child,
    this.loop,
  }) : super(key: key);

  final CNode node;
  final CNode? child;
  final bool forPlay;
  final int? loop;
  final FSize minWidth;
  final FSize minHeight;
  final FSize maxWidth;
  final FSize maxHeight;

  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

  @override
  Widget build(final BuildContext context) {
    final minW = minWidth.get(context: context, isWidth: true) ?? 0;
    final minH = minHeight.get(context: context, isWidth: false) ?? 0;
    final maxW =
        maxWidth.get(context: context, isWidth: true) ?? double.infinity;
    final maxH =
        maxHeight.get(context: context, isWidth: false) ?? double.infinity;

    return NodeSelectionBuilder(
      node: node,
      forPlay: forPlay,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: minW,
          minHeight: minH,
          maxWidth: maxW,
          maxHeight: maxH,
        ),
        child: ChildConditionBuilder(
          ValueKey('${node.nid} $loop'),
          name: node.intrinsicState.displayName,
          node: node,
          child: child,
          params: params,
          states: states,
          dataset: dataset,
          forPlay: forPlay,
          loop: loop,
        ),
      ),
    );
  }
}
