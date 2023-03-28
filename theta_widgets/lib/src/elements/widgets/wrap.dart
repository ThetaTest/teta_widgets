// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:theta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:theta_widgets/src/elements/index.dart';

class WWrap extends StatelessWidget {
  /// Returns a Wrap widget in Teta
  const WWrap(
    final Key? key, {
    required this.children,
    required this.state,
  }) : super(key: key);

  final TetaWidgetState state;
  final List<CNode> children;

  @override
  Widget build(final BuildContext context) {
    return TetaWidget(
      state: state,
      child: Wrap(
        children: children.isNotEmpty
            ? children.map((final e) => e.toWidget(state: state)).toList()
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
