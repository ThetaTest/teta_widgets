/*import 'package:flutter/material.dart';

// Package imports:
import 'package:mouse_parallax/mouse_parallax.dart';

// Project imports:
import 'package:mobile_editor/src/elements/builder/node_selection_builder.dart';
import 'package:mobile_editor/src/elements/builder/placeholder_child.dart';
import 'package:mobile_editor/src/elements/nodes/node.dart';
import 'package:mobile_editor/src/models/dataset.dart';
import 'package:mobile_editor/src/models/variable.dart';

class WParallaxStack extends StatelessWidget {
  final CNode node;
  final String? nid;
  final List<CNode> children;
  final bool forPlay;
  final double? index;
  final String? component;
  final int? loop;

  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

  const WParallaxStack({
    this.nid,
    required this.children,
    required this.node,
    required this.forPlay,
    this.index,
    this.component,
    this.loop,
    required this.params,
    required this.states,
    required this.dataset,
  });

  @override
  Widget build(BuildContext context) {
    return NodeSelectionBuilder(
      node: node,
      forPlay: forPlay,
      child: ParallaxStack(
        layers: children.length > 0
            ? children
                .map((e) => e.toWidget(
                      loop: loop,
                      forPlay: forPlay,
                      params: params,
                      states: states,
                      dataset: dataset,
                    ))
                .toList()
            : [PlaceholderChildBuilder(name: node.intrinsicState.displayName)],
      ),
    );
  }
}
*/
