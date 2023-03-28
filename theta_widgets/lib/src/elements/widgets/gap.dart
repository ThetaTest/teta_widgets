import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
import 'package:teta_widgets/src/elements/index.dart';

class WGap extends StatelessWidget {
  const WGap(
    final Key? key, {
    required this.state,
    required this.mainAxisExtent,
    required this.crossAxisExtent,
    this.isExpanded = false,
  }) : super(key: key);

  final TetaWidgetState state;
  final FSize mainAxisExtent;
  final FSize crossAxisExtent;
  final bool isExpanded;

  @override
  Widget build(final BuildContext context) {
    return TetaWidget(
      state: state,
      child: isExpanded
          ? Gap.expand(
              mainAxisExtent.get(
                    context: context,
                    isWidth: true,
                    forPlay: state.forPlay,
                  ) ??
                  0,
            )
          : Gap(
              mainAxisExtent.get(
                    context: context,
                    isWidth: true,
                    forPlay: state.forPlay,
                  ) ??
                  0,
              crossAxisExtent: crossAxisExtent.get(
                context: context,
                isWidth: true,
                forPlay: state.forPlay,
              ),
            ),
    );
  }
}
