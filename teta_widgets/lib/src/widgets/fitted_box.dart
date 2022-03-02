// Flutter imports:
// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_core/teta_core.dart';

class WFittedBox extends StatelessWidget {
  /// Returns a Container widget
  const WFittedBox({
    Key? key,
    required this.node,
    required this.boxFit,
    required this.forPlay,
    required this.params,
    required this.states,
    required this.dataset,
    this.child,
    this.loop,
  }) : super(key: key);

  final CNode node;
  final CNode? child;
  final FBoxFit boxFit;
  final bool forPlay;
  final int? loop;

  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

  @override
  Widget build(BuildContext context) {
    return NodeSelectionBuilder(
      node: node,
      forPlay: forPlay,
      child: FittedBox(
        child: ChildConditionBuilder(
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
