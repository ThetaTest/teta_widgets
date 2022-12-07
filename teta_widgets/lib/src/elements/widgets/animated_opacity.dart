// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

class WAnimatedOpacity extends StatelessWidget {
  /// Returns a Opacity widget
  const WAnimatedOpacity(
    final Key? key, {
    required this.state,
    required this.value,
    required this.duration,
    this.child,
  }) : super(key: key);

  final TetaWidgetState state;
  final CNode? child;
  final FTextTypeInput value;
  final FTextTypeInput duration;

  @override
  Widget build(final BuildContext context) {
    final opacityString = value.get(
      state.params,
      state.states,
      state.dataset,
      state.forPlay,
      state.loop,
      context,
    );
    final rawDouble = double.tryParse(opacityString.replaceAll('-', '')) != null
        ? double.parse(opacityString.replaceAll('-', ''))
        : 1.0;
    return TetaWidget(
      state: state,
      child: AnimatedOpacity(
        duration: Duration(
          milliseconds: int.tryParse(opacityString) != null ? int.parse(opacityString) : 400,
        ),
        opacity: rawDouble < 0
            ? 0
            : rawDouble > 1
                ? 1
                : rawDouble,
        child: ChildConditionBuilder(
          ValueKey('${state.node.nid} ${state.loop}'),
          state: state,
          child: child,
        ),
      ),
    );
  }
}
