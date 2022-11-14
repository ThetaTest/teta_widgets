import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/builder/gesture_detector_base.dart';
import 'package:teta_widgets/src/elements/index.dart';

class WGap extends StatelessWidget {
  const WGap(
    final Key? key, {
    required this.node,
    required this.params,
    required this.states,
    required this.dataset,
    required this.forPlay,
    required this.mainAxisExtent,
    this.crossAxisExtent,
    this.color,
    this.loop,
    this.isExpanded = false,
  }) : super(key: key);

  final CNode node;
  final bool forPlay;
  final FSize mainAxisExtent;
  final FSize? crossAxisExtent;
  final Color? color;
  final int? loop;
  final bool isExpanded;

  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

  @override
  Widget build(final BuildContext context) {
    return NodeSelectionBuilder(
      node: node,
      forPlay: forPlay,
      child: GestureBuilderBase.get(
        context: context,
        node: node,
        params: params,
        states: states,
        dataset: dataset,
        forPlay: forPlay,
        loop: loop,
        child: isExpanded
            ? Gap.expand(
                mainAxisExtent.get(context: context, isWidth: true)!,
                color: color,
              )
            : Gap(
                mainAxisExtent.get(context: context, isWidth: true)!,
                color: color,
                crossAxisExtent:
                    crossAxisExtent?.get(context: context, isWidth: true),
              ),
      ),
    );
  }
}
