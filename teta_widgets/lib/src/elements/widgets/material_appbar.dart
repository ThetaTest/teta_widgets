// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:teta_core/teta_core.dart';

// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

// ignore_for_file: public_member_api_docs

class WMaterialAppBar extends StatelessWidget {
  /// Returns a MaterialAppBar widget in Teta
  const WMaterialAppBar(
    Key? key, {
    required this.node,
    required this.fill,
    required this.forPlay,
    required this.params,
    required this.states,
    required this.dataset,
    required this.children,
    this.loop,
  }) : super(key: key);

  final CNode node;
  final List<CNode> children;
  final FFill fill;
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
      child: AppBar(
        elevation: 0,
        backgroundColor: HexColor(fill.getHexColor(context)),
        leading: children.length >= 2
            ? children[1].toWidget(
                params: params,
                states: states,
                dataset: dataset,
                forPlay: forPlay,
              )
            : null,
        title: children.isNotEmpty
            ? children[0].toWidget(
                params: params,
                states: states,
                dataset: dataset,
                forPlay: forPlay,
              )
            : null,
        actions: [
          if (children.length >= 3)
            children[2].toWidget(
              params: params,
              states: states,
              dataset: dataset,
              forPlay: forPlay,
            ),
          if (children.length >= 4)
            children[3].toWidget(
              params: params,
              states: states,
              dataset: dataset,
              forPlay: forPlay,
            ),
          if (children.length >= 5)
            children[4].toWidget(
              params: params,
              states: states,
              dataset: dataset,
              forPlay: forPlay,
            )
        ],
      ),
    );
  }
}
