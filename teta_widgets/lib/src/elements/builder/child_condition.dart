// Flutter imports:
import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_widgets/src/core/teta_widget/index.dart';
import 'package:teta_widgets/src/elements/builder/placeholder_child.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';

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
    return (child != null)
        ? child!.toWidget(
            state: state,
          )
        : !state.forPlay
            ? PlaceholderChildBuilder(
                name: state.node.intrinsicState.displayName,
                node: state.node,
                forPlay: state.forPlay,
              )
            : const SizedBox();
  }
}
