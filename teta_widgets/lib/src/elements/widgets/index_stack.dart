// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:teta_core/teta_core.dart';

// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

// ignore_for_file: public_member_api_docs

class WIndexedStack extends StatelessWidget {
  /// Returns [Column] widget in Teta
  const WIndexedStack(
    Key? key, {
    required this.children,
    required this.node,
    required this.forPlay,
    required this.index,
    required this.params,
    required this.states,
    required this.dataset,
    this.loop,
  }) : super(key: key);

  final CNode node;
  final List<CNode> children;
  final bool forPlay;
  final FTextTypeInput index;

  final int? loop;

  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

  @override
  Widget build(BuildContext context) {
    final val = index.get(params, states, dataset, forPlay, loop);
    return NodeSelectionBuilder(
      node: node,
      forPlay: forPlay,
      child: IndexedStack(
        index: int.tryParse(val) != null ? int.parse(val) : 0,
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
            : [
                PlaceholderChildBuilder(name: node.intrinsicState.displayName),
              ],
      ),
    );
  }
}
