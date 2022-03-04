// Flutter imports:
import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/index.dart';

// ignore_for_file: public_member_api_docs

class WAppBar extends StatelessWidget {
  /// Returns a empty widget which contains all the app bar widgets
  const WAppBar({
    Key? key,
    this.child,
    required this.node,
    required this.forPlay,
    this.loop,
    required this.params,
    required this.states,
    required this.dataset,
  }) : super(key: key);

  final CNode node;
  final CNode? child;
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
