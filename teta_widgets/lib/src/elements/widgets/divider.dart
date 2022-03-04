// Flutter imports:
// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/index.dart';

class WDivider extends StatelessWidget {
  /// Returns a Divider widget
  const WDivider({
    Key? key,
    this.child,
    required this.node,
    required this.height,
    required this.fill,
    this.nid,
    this.parent,
    required this.forPlay,
    this.index,
    this.component,
    this.loop,
    required this.params,
    required this.states,
    required this.dataset,
  }) : super(key: key);

  final CNode node;
  final String? nid;
  final String? parent;
  final CNode? child;
  final FSize height;
  final FFill fill;
  final bool forPlay;
  final double? index;
  final String? component;
  final int? loop;

  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

  @override
  Widget build(BuildContext context) {
    return NodeSelectionBuilder(
      node: node,
      forPlay: forPlay,
      child: Divider(
        height: height.get(context: context, isWidth: false),
        color: HexColor(fill.get(context).levels!.first.color),
      ),
    );
  }
}
