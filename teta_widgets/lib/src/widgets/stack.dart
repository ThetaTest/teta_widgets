// Flutter imports:
// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:teta_core/teta_core.dart';

class WStack extends StatelessWidget {
  /// Returns a Stack widget in Teta
  const WStack({
    Key? key,
    this.nid,
    required this.children,
    required this.node,
    required this.forPlay,
    this.loop,
    required this.params,
    required this.states,
    required this.dataset,
  }) : super(key: key);

  final CNode node;
  final String? nid;
  final List<CNode> children;
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
      child: Stack(
        children: children.isNotEmpty
            ? children
                .map(
                  (e) => e.toWidget(
                    loop: loop,
                    forPlay: forPlay,
                    params: params,
                    states: states,
                    dataset: dataset,
                  ),
                )
                .toList()
            : [PlaceholderChildBuilder(name: node.intrinsicState.displayName)],
      ),
    );
  }
}
