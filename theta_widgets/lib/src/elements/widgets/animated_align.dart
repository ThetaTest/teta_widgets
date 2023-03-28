// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

// ignore_for_file: public_member_api_docs

class WAnimatedAlign extends StatelessWidget {
  /// Returns a [Align] widget in Teta
  const WAnimatedAlign(
    final Key? key, {
    required this.state,
    required this.align,
    required this.duration,
    this.child,
  }) : super(key: key);

  final TetaWidgetState state;
  final CNode? child;
  final FAlign align;
  final FTextTypeInput duration;

  @override
  Widget build(final BuildContext context) {
    final val = duration.get(
      state.params,
      state.states,
      state.dataset,
      state.forPlay,
      state.loop,
      context,
    );
    return TetaWidget(
      state: state,
      child: AnimatedAlign(
        duration: Duration(
          milliseconds: int.tryParse(val) != null ? int.parse(val) : 400,
        ),
        alignment: align.align!,
        child: ChildConditionBuilder(
          ValueKey(state.toKey),
          state: state,
          child: child,
        ),
      ),
    );
  }
}
