// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

class WLiquidSwipe extends StatelessWidget {
  /// Returns a LiquidSwipe widget
  const WLiquidSwipe(
    final Key? key, {
    required this.state,
    required this.children,
  }) : super(key: key);

  final TetaWidgetState state;
  final List<CNode> children;

  @override
  Widget build(final BuildContext context) {
    return TetaWidget(
      state: state,
      child: LiquidSwipe.builder(
        itemCount: children.isNotEmpty ? children.length : 3,
        itemBuilder: (final context, final index) {
          if (children.isEmpty) {
            return PlaceholderChildBuilder(
              name: state.node.intrinsicState.displayName,
              node: state.node,
              forPlay: state.forPlay,
            );
          }
          return children[index].toWidget(state: state.copyWith(loop: index));
        },
      ),
    );
  }
}
