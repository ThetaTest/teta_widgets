// Flutter imports:
// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:teta_core/teta_core.dart';

class WListView extends StatelessWidget {
  /// Returns a ListView in Teta
  const WListView({
    Key? key,
    this.nid,
    required this.children,
    required this.node,
    required this.forPlay,
    required this.flagValue,
    required this.value,
    this.loop,
    required this.isVertical,
    required this.params,
    required this.states,
    required this.dataset,
    required this.isPrimary,
    required this.shrinkWrap,
  }) : super(key: key);

  final CNode node;
  final String? nid;
  final List<CNode> children;
  final bool forPlay;
  final bool isVertical;
  final bool flagValue;
  final FTextTypeInput value;
  final bool isPrimary;
  final int? loop;
  final bool shrinkWrap;

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
    return ListView.builder(
      addAutomaticKeepAlives: false,
      addRepaintBoundaries: false,
      scrollDirection: isVertical ? Axis.vertical : Axis.horizontal,
      itemCount: children.isEmpty ? 1 : children.length,
      itemBuilder: (context, index) {
        return children.isNotEmpty
            ? children[index].toWidget(
                loop: loop,
                forPlay: forPlay,
                params: params,
                states: states,
                dataset: dataset,
              )
            : PlaceholderChildBuilder(name: node.intrinsicState.displayName);
      },
    );
  }
}
