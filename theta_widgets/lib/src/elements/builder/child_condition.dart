// Flutter imports:
import 'package:flutter/material.dart';
// Project imports:
import 'package:theta_widgets/src/core/teta_widget/index.dart';
import 'package:theta_widgets/src/elements/builder/placeholder_child.dart';
import '../../../../../../teta_open_classes/lib/src/nodes/node.dart';

/// Builder
class ChildConditionBuilder extends StatelessWidget {
  /// Returns the [child] widget or a placeholder with the name of the widget
  const ChildConditionBuilder(
    final Key? key, {
    required this.state,
    required this.child,
  }) : super(key: key);

  final TetaWidgetState state;

  /// The optional child
  final CNode? child;

  @override
  Widget build(final BuildContext context) {
    if (child != null) {
      return child!.toWidget(
        state: state,
      );
    }
    if (state.forPlay) {
      return const SizedBox();
    }
    return PlaceholderChildBuilder(
      name: state.node.intrinsicState.displayName,
      node: state.node,
      forPlay: state.forPlay,
    );
  }
}
