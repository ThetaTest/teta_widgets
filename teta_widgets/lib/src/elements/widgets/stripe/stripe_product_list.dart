// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

// Project imports:

// ignore_for_file: public_member_api_docs

class WStripeProductsList extends StatelessWidget {
  /// Returns a [Align] widget in Teta
  const WStripeProductsList(
    final Key? key, {
    required this.node,
    required this.forPlay,
    required this.params,
    required this.states,
    required this.dataset,
    required this.children,
    this.child,
    this.loop,
  }) : super(key: key);

  final CNode node;
  final CNode? child;

  final bool forPlay;
  final int? loop;

  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;
  /// The opzional child of this widget
  final List<CNode> children;

  @override
  Widget build(final BuildContext context) {
    return NodeSelectionBuilder(
      node: node,
      forPlay: forPlay,
      child: Stack(
        children: children.isNotEmpty
            ? children
                .map(
                  (final e) => e.toWidget(
                    loop: loop,
                    forPlay: forPlay,
                    params: params,
                    states: states,
                    dataset: dataset,
                  ),
                )
                .toList()
            : [
                PlaceholderChildBuilder(name: node.intrinsicState.displayName),
              ],
      ),
    );
  }
}
