// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:teta_core/teta_core.dart';

// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

// ignore_for_file: public_member_api_docs

class WCard extends StatelessWidget {
  /// Returns a [Center] widget in Teta
  const WCard(
    Key? key, {
    required this.node,
    required this.forPlay,
    required this.params,
    required this.states,
    required this.dataset,
    required this.elevation,
    required this.color,
    this.child,
    this.loop,
  }) : super(key: key);

  final CNode node;
  final CNode? child;
  final bool forPlay;
  final int? loop;
  final FTextTypeInput elevation;
  final FFill color;
  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

  @override
  Widget build(BuildContext context) {
    final val = elevation.get(params, states, dataset, forPlay, loop);
    return NodeSelectionBuilder(
      node: node,
      forPlay: forPlay,
      child: Card(
        color: HexColor(color.getHexColor(context)),
        elevation: double.tryParse(val) != null ? double.parse(val) : 1,
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