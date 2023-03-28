// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:theta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:theta_widgets/src/elements/index.dart';

/// This widget doesn't work correctly.
/// Try to instantiate a Row and then as its children 2 Expanded.
/// They won't take all the space avaiable, as they are limited.

class WDotsIndicator extends StatelessWidget {
  /// Returns a DotsIndicator widget
  const WDotsIndicator(
    final Key? key, {
    required this.state,
    required this.dotsCount,
    required this.position,
    required this.margins,
    required this.width,
    required this.height,
    required this.borderRadius,
    required this.border,
    required this.activeBorder,
    required this.color,
    required this.activeColor,
    required this.shadow,
    this.child,
  }) : super(key: key);

  final TetaWidgetState state;
  final CNode? child;
  final FTextTypeInput dotsCount;
  final FTextTypeInput position;
  final FBorderRadius borderRadius;
  final FBorder border;
  final FBorder activeBorder;
  final FMargins margins;
  final FShadow shadow;
  final FSize width;
  final FSize height;
  final FFill color;
  final FFill activeColor;

  @override
  Widget build(final BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0;
            i <
                (int.tryParse(
                      dotsCount.get(
                        state.params,
                        state.states,
                        state.dataset,
                        state.forPlay,
                        state.loop,
                        context,
                      ),
                    ) ??
                    3);
            i++)
          Container(
            margin: margins.get(
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
              fill: i ==
                      (int.tryParse(
                            position.get(
                              state.params,
                              state.states,
                              state.dataset,
                              state.forPlay,
                              state.loop,
                              context,
                            ),
                          ) ??
                          1)
                  ? color.get(context)
                  : activeColor.get(context),
              borderRadius: borderRadius,
              shadow: shadow,
            ),
          ),
      ],
    );
  }
}
