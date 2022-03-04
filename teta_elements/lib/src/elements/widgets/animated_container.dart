// Flutter imports:
// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_core/teta_core.dart';

///
class WAnimatedContainer extends StatelessWidget {
  /// Returns a Container widget
  const WAnimatedContainer({
    Key? key,
    required this.node,
    required this.width,
    required this.height,
    required this.margins,
    required this.paddings,
    required this.fill,
    required this.borderRadius,
    required this.shadows,
    required this.value,
    required this.duration,
    required this.forPlay,
    required this.params,
    required this.states,
    required this.dataset,
    this.child,
    this.loop,
  }) : super(key: key);

  final CNode node;
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
  final bool forPlay;
  final int? loop;

  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

  @override
  Widget build(BuildContext context) {
    final val = value.get(params, states, dataset, forPlay, loop);
    return NodeSelectionBuilder(
      node: node,
      forPlay: forPlay,
      child: AnimatedContainer(
        duration: Duration(
          milliseconds: int.tryParse(val) != null ? int.parse(val) : 400,
        ),
        margin: margins.get(context),
        padding: paddings.get(context),
        width: width.get(context: context, isWidth: true),
        height: height.get(context: context, isWidth: false),
        decoration: TetaBoxDecoration.get(
          context: context,
          fill: fill.get(context),
          borderRadius: borderRadius,
          shadow: shadows,
        ),
        child: ChildConditionBuilder(
          name: node.intrinsicState.displayName,
          child: child,
          params: params,
          states: states,
          dataset: dataset,
          forPlay: forPlay,
          loop: loop,
        ),
      ),
    );
  }
}
