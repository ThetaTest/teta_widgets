// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

// ignore_for_file: public_member_api_docs

class WAspectRatio extends StatelessWidget {
  /// Returns a [Center] widget in Teta
  const WAspectRatio(
    final Key? key, {
    required this.state,
    required this.aspectRatio,
    this.child,
  }) : super(key: key);

  final TetaWidgetState state;
  final CNode? child;
  final FTextTypeInput aspectRatio;

  @override
  Widget build(final BuildContext context) {
    final val = aspectRatio.get(
      state.params,
      state.states,
      state.dataset,
      state.forPlay,
      state.loop,
      context,
    );
    final rawDouble = double.tryParse(val) != null ? double.parse(val) : 0.5;
    return TetaWidget(
      state: state,
      child: AspectRatio(
        aspectRatio: rawDouble,
        child: ChildConditionBuilder(
          ValueKey('${state.node.nid} ${state.loop}'),
          state: state,
          child: child,
        ),
      ),
    );
  }
}
