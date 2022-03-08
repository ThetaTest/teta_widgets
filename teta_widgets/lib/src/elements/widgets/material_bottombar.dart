// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

// ignore_for_file: public_member_api_docs

class WMaterialBottomBar extends StatelessWidget {
  /// Returns a MaterialAppBar widget in Teta
  const WMaterialBottomBar(
    final Key? key, {
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
  Widget build(final BuildContext context) {
    return NodeSelectionBuilder(
      node: node,
      forPlay: forPlay,
      child: BottomNavigationBar(
        items: const [],
        backgroundColor: HexColor(fill.getHexColor(context)),
      ),
    );
  }
}
