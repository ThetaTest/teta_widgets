// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

// ignore_for_file: public_member_api_docs

class WMaterialAppBar extends StatelessWidget {
  /// Returns a MaterialAppBar widget in Teta
  const WMaterialAppBar(
    final Key? key, {
    required this.state,
    required this.fill,
    required this.children,
  }) : super(key: key);

  final TetaWidgetState state;
  final List<CNode> children;
  final FFill fill;

  @override
  Widget build(final BuildContext context) {
    return NodeSelectionBuilder(
      node: state.node,
      forPlay: state.forPlay,
      child: AppBar(
        elevation: 0,
        backgroundColor: HexColor(fill.getHexColor(context)),
        leading: children.length >= 2 ? children[1].toWidget(state: state) : null,
        title: children.isNotEmpty ? children[0].toWidget(state: state) : null,
        actions: [
          if (children.length >= 3) children[2].toWidget(state: state),
          if (children.length >= 4) children[3].toWidget(state: state),
          if (children.length >= 5) children[4].toWidget(state: state)
        ],
      ),
    );
  }
}
