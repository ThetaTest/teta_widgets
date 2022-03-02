// Flutter imports:
import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_core/teta_core.dart';

// ignore_for_file: public_member_api_docs

class WColumn extends StatelessWidget {
  /// Returns [Column] widget in Teta
  const WColumn({
    Key? key,
    this.nid,
    required this.children,
    required this.node,
    required this.forPlay,
    required this.mainAxisAlignment,
    required this.crossAxisAlignment,
    required this.mainAxisSize,
    this.loop,
    required this.params,
    required this.states,
    required this.dataset,
  }) : super(key: key);

  final CNode node;
  final String? nid;
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
  Widget build(BuildContext context) {
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
