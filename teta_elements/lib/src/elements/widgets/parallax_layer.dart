/*import 'package:flutter/material.dart';

// Package imports:
import 'package:mouse_parallax/mouse_parallax.dart';

// Project imports:
import 'package:mobile_editor/src/elements/builder/child_condition.dart';
import 'package:mobile_editor/src/elements/builder/node_selection_builder.dart';
import 'package:mobile_editor/src/elements/nodes/node.dart';
import 'package:mobile_editor/src/models/dataset.dart';
import 'package:mobile_editor/src/models/variable.dart';

class WParallaxLayer extends StatelessWidget {
  const WParallaxLayer({
    this.child,
    required this.node,
    this.nid,
    this.parent,
    required this.xRotation,
    required this.yRotation,
    required this.zRotation,
    required this.xOffset,
    required this.yOffset,
    required this.forPlay,
    this.index,
    this.component,
    this.loop,
    required this.params,
    required this.states,
    required this.dataset,
  });

  final CNode node;
  final String? nid;
  final String? parent;
  final CNode? child;
  final double xRotation, yRotation, zRotation;
  final double xOffset, yOffset;
  final bool forPlay;
  final double? index;
  final String? component;
  final int? loop;

  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

  Widget build(BuildContext context) {
    return NodeSelectionBuilder(
      node: node,
      forPlay: forPlay,
      child: ParallaxLayer(
        xRotation: xRotation,
        yRotation: yRotation,
        zRotation: zRotation,
        xOffset: xOffset,
        yOffset: yOffset,
        child: ChildConditionBuilder(
          name: node.intrinsicState.displayName,
          child: child,
          params: params,
          states: states,
          dataset: dataset,
          forPlay: forPlay,
        ),
      ),
    );
  }
}
*/
