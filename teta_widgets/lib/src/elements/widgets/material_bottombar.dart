// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

// ignore_for_file: public_member_api_docs

class WMaterialBottomBar extends StatelessWidget {
  /// Returns a MaterialAppBar widget in Teta
  const WMaterialBottomBar(
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
      state: state,
      child: BottomNavigationBar(
        items: const [],
        backgroundColor: HexColor(fill.getHexColor(context)),
      ),
    );
  }
}
