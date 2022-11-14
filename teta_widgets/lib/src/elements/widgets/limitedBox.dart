// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';
import 'package:teta_widgets/src/elements/builder/gesture_detector_base.dart';

class WLimitedBox extends StatelessWidget {
  /// Returns a LimitedBox widget
  const WLimitedBox(
    final Key? key, {
    required this.node,
    required this.forPlay,
    required this.params,
    required this.states,
    required this.dataset,
    required this.maxWidth,
    required this.maxHeight,
    this.child,
    this.loop,
  }) : super(key: key);

  final CNode node;
  final CNode? child;
  final bool forPlay;
  final int? loop;
  final FSize maxWidth;
  final FSize maxHeight;

  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

  @override
  Widget build(final BuildContext context) {
    final maxW =
        maxWidth.get(context: context, isWidth: true) ?? double.infinity;
    final maxH =
        maxHeight.get(context: context, isWidth: false) ?? double.infinity;
    return NodeSelectionBuilder(
      node: node,
      forPlay: forPlay,
      child: GestureBuilderBase.get(
        context: context,
        node: node,
        params: params,
        states: states,
        dataset: dataset,
        forPlay: forPlay,
        loop: loop,
        child: LimitedBox(
          maxWidth: maxW,
          maxHeight: maxH,
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
      ),
    );
  }
}
