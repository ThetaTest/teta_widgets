// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

// ignore_for_file: public_member_api_docs

class WColumn extends StatelessWidget {
  /// Returns [Column] widget in Teta
  const WColumn(
    final Key? key, {
    required this.state,
    required this.children,
    required this.mainAxisAlignment,
    required this.crossAxisAlignment,
    required this.mainAxisSize,
  }) : super(key: key);

  final TetaWidgetState state;
  final List<CNode> children;
  final FMainAxisAlignment mainAxisAlignment;
  final FCrossAxisAlignment crossAxisAlignment;
  final FMainAxisSize mainAxisSize;

  @override
  Widget build(final BuildContext context) {
    return TetaWidget(
      state: state,
      child: Column(
        mainAxisSize: mainAxisSize.get,
        mainAxisAlignment: mainAxisAlignment.get,
        crossAxisAlignment: crossAxisAlignment.get,
        children: children.isNotEmpty
            ? children
                .map(
                  (final e) => e.toWidget(state: state),
                )
                .toList()
            : [
                PlaceholderChildBuilder(
                  name: state.node.intrinsicState.displayName,
                  node: state.node,
                  forPlay: state.forPlay,
                ),
              ],
      ),
    );
  }
}
