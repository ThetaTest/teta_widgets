// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

// ignore_for_file: public_member_api_docs

class WColumn extends StatelessWidget {
  /// Returns [Column] widget in Teta
  const WColumn(
    final Key? key, {
    required this.children,
    required this.node,
    required this.forPlay,
    required this.mainAxisAlignment,
    required this.crossAxisAlignment,
    required this.mainAxisSize,
    required this.params,
    required this.states,
    required this.dataset,
    this.loop,
  }) : super(key: key);

  final CNode node;
  final List<CNode> children;
  final bool forPlay;
  final FMainAxisAlignment mainAxisAlignment;
  final FCrossAxisAlignment crossAxisAlignment;
  final FMainAxisSize mainAxisSize;
  final int? loop;

  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

  @override
  Widget build(final BuildContext context) {
    return NodeSelectionBuilder(
      node: node,
      forPlay: forPlay,
      child: Column(
        mainAxisSize: mainAxisSize.get,
        mainAxisAlignment: mainAxisAlignment.get,
        crossAxisAlignment: crossAxisAlignment.get,
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
