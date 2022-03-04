// Flutter imports:
// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
// Project imports:
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/index.dart';

class WLiquidSwipe extends StatelessWidget {
  /// Returns a LiquidSwipe widget
  const WLiquidSwipe({
    Key? key,
    required this.children,
    required this.node,
    this.loop,
    required this.forPlay,
    required this.params,
    required this.states,
    required this.dataset,
  }) : super(key: key);

  final CNode node;
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
      child: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return LiquidSwipe.builder(
      itemCount: children.isNotEmpty ? children.length : 3,
      itemBuilder: (context, index) {
        if (children.isEmpty) {
          return PlaceholderChildBuilder(name: node.intrinsicState.displayName);
        }
        return children[index].toWidget(
          loop: index,
          forPlay: forPlay,
          params: params,
          states: states,
          dataset: dataset,
        );
      },
    );
  }
}
