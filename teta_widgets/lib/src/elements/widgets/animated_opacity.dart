// Flutter imports:
// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

class WAnimatedOpacity extends StatelessWidget {
  /// Returns a Opacity widget
  const WAnimatedOpacity({
    Key? key,
    this.child,
    required this.node,
    required this.value,
    required this.duration,
    this.nid,
    this.parent,
    required this.forPlay,
    this.index,
    this.component,
    this.loop,
    required this.params,
    required this.states,
    required this.dataset,
  }) : super(key: key);

  final CNode node;
  final String? nid;
  final String? parent;
  final CNode? child;
  final FTextTypeInput value;
  final FTextTypeInput duration;
  final bool forPlay;
  final double? index;
  final String? component;
  final int? loop;

  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

  @override
  Widget build(BuildContext context) {
    return NodeSelectionBuilder(
      node: node,
      forPlay: forPlay,
      child: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    final opacityString = value.get(params, states, dataset, forPlay, loop);
    final rawDouble = double.tryParse(opacityString.replaceAll('-', '')) != null
        ? double.parse(opacityString.replaceAll('-', ''))
        : 1.0;
    return AnimatedOpacity(
      duration: Duration(
        milliseconds: int.tryParse(opacityString) != null
            ? int.parse(opacityString)
            : 400,
      ),
      opacity: rawDouble < 0
          ? 0
          : rawDouble > 1
              ? 1
              : rawDouble,
      child: ChildConditionBuilder(
        name: node.intrinsicState.displayName,
        child: child,
        params: params,
        states: states,
        dataset: dataset,
        forPlay: forPlay,
        loop: loop,
      ),
    );
  }
}
