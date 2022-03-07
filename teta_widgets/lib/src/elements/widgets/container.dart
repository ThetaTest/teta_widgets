// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:teta_core/teta_core.dart';

// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

class WContainer extends StatelessWidget {
  /// Returns a Container widget
  const WContainer(
    Key? key, {
    required this.node,
    required this.width,
    required this.height,
    required this.margins,
    required this.paddings,
    required this.fill,
    required this.borderRadius,
    required this.borders,
    required this.shadows,
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
  final FBorder borders;
  final FShadow shadows;
  final bool forPlay;
  final int? loop;

  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

  @override
  Widget build(BuildContext context) {
    return NodeSelectionBuilder(
      node: node,
      forPlay: forPlay,
      child: Container(
        margin: margins.get(context),
        padding: paddings.get(context),
        width: width.get(context: context, isWidth: true),
        height: height.get(context: context, isWidth: false),
        decoration: TetaBoxDecoration.get(
          context: context,
          fill: fill.get(context),
          borderRadius: borderRadius,
          shadow: shadows,
          borders: borders,
        ),
        child: ChildConditionBuilder(
          ValueKey('${node.nid} $loop'),
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
