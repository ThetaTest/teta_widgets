// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

///
class WAnimatedContainer extends StatelessWidget {
  /// Returns a Container widget
  const WAnimatedContainer(
    final Key? key, {
    required this.state,
    required this.width,
    required this.height,
    required this.margins,
    required this.paddings,
    required this.fill,
    required this.borderRadius,
    required this.shadows,
    required this.value,
    required this.duration,
    this.child,
  }) : super(key: key);

  final TetaWidgetState state;
  final CNode? child;
  final FSize width;
  final FSize height;
  final FMargins margins;
  final FMargins paddings;
  final FFill fill;
  final FBorderRadius borderRadius;
  final FShadow shadows;
  final FTextTypeInput value;
  final FTextTypeInput duration;

  @override
  Widget build(final BuildContext context) {
    final val = value.get(
      state.params,
      state.states,
      state.dataset,
      state.forPlay,
      state.loop,
      context,
    );
    return TetaWidget(
      state: state,
      child: AnimatedContainer(
        duration: Duration(
          milliseconds: int.tryParse(val) != null ? int.parse(val) : 400,
        ),
        margin: margins.get(
          context,
          forPlay: state.forPlay,
        ),
        padding: paddings.get(
          context,
          forPlay: state.forPlay,
        ),
        width: width.get(
          context: context,
          isWidth: true,
          forPlay: state.forPlay,
        ),
        height: height.get(
          context: context,
          isWidth: false,
          forPlay: state.forPlay,
        ),
        decoration: TetaBoxDecoration.get(
          context: context,
          forPlay: state.forPlay,
          fill: fill.get(context),
          borderRadius: borderRadius,
          shadow: shadows,
        ),
        child: ChildConditionBuilder(
          ValueKey(state.toKey),
          state: state,
          child: child,
        ),
      ),
    );
  }
}
