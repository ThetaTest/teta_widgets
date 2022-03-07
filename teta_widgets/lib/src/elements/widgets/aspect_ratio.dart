// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:teta_core/teta_core.dart';

// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

// ignore_for_file: public_member_api_docs

class WAspectRatio extends StatelessWidget {
  /// Returns a [Center] widget in Teta
  const WAspectRatio(
    Key? key, {
    required this.node,
    required this.forPlay,
    required this.params,
    required this.states,
    required this.dataset,
    required this.aspectRatio,
    this.child,
    this.loop,
  }) : super(key: key);

  final CNode node;
  final CNode? child;
  final bool forPlay;
  final int? loop;
  final FTextTypeInput aspectRatio;

  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

  @override
  Widget build(BuildContext context) {
    final val = aspectRatio.get(params, states, dataset, forPlay, loop);
    final rawDouble = double.tryParse(val) != null ? double.parse(val) : 0.5;
    return NodeSelectionBuilder(
      node: node,
      forPlay: forPlay,
      child: AspectRatio(
        aspectRatio: rawDouble,
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
      ),
    );
  }
}
