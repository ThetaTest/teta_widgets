// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

class WLiquidSwipe extends StatelessWidget {
  /// Returns a LiquidSwipe widget
  const WLiquidSwipe(
    final Key? key, {
    required this.children,
    required this.node,
    required this.forPlay,
    required this.params,
    required this.states,
    required this.dataset,
    this.loop,
  }) : super(key: key);

  final CNode node;
  final List<CNode> children;
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
    return LiquidSwipe.builder(
      itemCount: children.isNotEmpty ? children.length : 3,
      itemBuilder: (final context, final index) {
        if (children.isEmpty) {
          return PlaceholderChildBuilder(
            name: node.intrinsicState.displayName,
            node: node,
            forPlay: forPlay,
          );
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
