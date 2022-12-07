// Flutter imports:
import 'package:flutter/cupertino.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

// ignore_for_file: public_member_api_docs

class WCupertinoAppBar extends StatelessWidget {
  /// Returns a MaterialAppBar widget in Teta
  const WCupertinoAppBar(
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
    return TetaWidget(
      state: state,
      child: CupertinoNavigationBar(
        backgroundColor: HexColor(fill.getHexColor(context)),
        leading: children.isNotEmpty ? children[0].toWidget(state: state) : null,
        middle: children.length >= 2 ? children[1].toWidget(state: state) : null,
        trailing: children.length >= 3 ? children[2].toWidget(state: state) : null,
      ),
    );
  }
}
