// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

class WAnimatedOpacity extends StatelessWidget {
  /// Returns a Opacity widget
  const WAnimatedOpacity(
    final Key? key, {
    required this.node,
    required this.value,
    required this.duration,
    required this.forPlay,
    required this.params,
    required this.states,
    required this.dataset,
    this.child,
    this.loop,
  }) : super(key: key);

  final CNode node;
  final CNode? child;
  final FTextTypeInput value;
  final FTextTypeInput duration;
  final bool forPlay;
  final int? loop;

  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

  @override
  Widget build(final BuildContext context) {
    return NodeSelectionBuilder(
      node: node,
      forPlay: forPlay,
      child: _body(context),
    );
  }

  Widget _body(final BuildContext context) {
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
        ValueKey('${node.nid} $loop'),
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
