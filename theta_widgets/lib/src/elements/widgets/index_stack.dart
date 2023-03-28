// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:theta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:theta_widgets/src/elements/index.dart';

// ignore_for_file: public_member_api_docs

class WIndexedStack extends StatelessWidget {
  /// Returns [Column] widget in Teta
  const WIndexedStack(
    final Key? key, {
    required this.state,
    required this.children,
    required this.index,
  }) : super(key: key);

  final TetaWidgetState state;
  final List<CNode> children;
  final FTextTypeInput index;

  @override
  Widget build(final BuildContext context) {
    final val = index.get(
      state.params,
      state.states,
      state.dataset,
      state.forPlay,
      state.loop,
      context,
    );
    return TetaWidget(
      state: state,
      child: IndexedStack(
        index: int.tryParse(val) != null ? int.parse(val) : 0,
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
