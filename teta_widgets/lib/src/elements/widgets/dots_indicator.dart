// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

/// This widget doesn't work correctly.
/// Try to instantiate a Row and then as its children 2 Expanded.
/// They won't take all the space avaiable, as they are limited.

class WDotsIndicator extends StatelessWidget {
  /// Returns a DotsIndicator widget
  const WDotsIndicator(
    final Key? key, {
    required this.node,
    required this.forPlay,
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
    required this.params,
    required this.states,
    required this.dataset,
    this.child,
    this.loop,
  }) : super(key: key);

  final CNode node;
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
  final bool forPlay;
  final int? loop;

  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

  @override
  Widget build(final BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0;
            i <
                (int.tryParse(
                      dotsCount.get(
                        params,
                        states,
                        dataset,
                        forPlay,
                        loop,
                        context,
                      ),
                    ) ??
                    3);
            i++)
          Container(
            margin: margins.get(context),
            width: width.get(context: context, isWidth: true),
            height: height.get(context: context, isWidth: false),
            decoration: TetaBoxDecoration.get(
              context: context,
              fill: i ==
                      (int.tryParse(
                            position.get(
                              params,
                              states,
                              dataset,
                              forPlay,
                              loop,
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
