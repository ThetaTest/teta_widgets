// Flutter imports:
import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_core/teta_core.dart';

// ignore_for_file: public_member_api_docs

class WAlign extends StatelessWidget {
  /// Returns a [Align] widget in Teta
  const WAlign({
    Key? key,
    required this.node,
    required this.align,
    required this.forPlay,
    required this.params,
    required this.states,
    required this.dataset,
    this.child,
    this.loop,
  }) : super(key: key);

  final CNode node;
  final CNode? child;
  final FAlign align;
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
      child: Align(
        alignment: align.align!,
        child: ChildConditionBuilder(
          name: NodeType.name(NType.align),
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
