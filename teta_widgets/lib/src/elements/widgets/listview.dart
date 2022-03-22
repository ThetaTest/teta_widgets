// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

class WListView extends StatelessWidget {
  /// Returns a ListView in Teta
  const WListView(
    final Key? key, {
    required this.children,
    required this.node,
    required this.forPlay,
    required this.flagValue,
    required this.value,
    required this.isVertical,
    required this.params,
    required this.states,
    required this.dataset,
    required this.isPrimary,
    required this.shrinkWrap,
    this.loop,
  }) : super(key: key);

  final CNode node;
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
  Widget build(final BuildContext context) {
    return NodeSelectionBuilder(
      node: node,
      forPlay: forPlay,
      child: ListView.builder(
        addAutomaticKeepAlives: false,
        addRepaintBoundaries: false,
        scrollDirection: isVertical ? Axis.vertical : Axis.horizontal,
        itemCount: children.isEmpty ? 1 : children.length,
        itemBuilder: (final context, final index) {
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
      ),
    );
  }
}
