// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

// Project imports:

// ignore_for_file: public_member_api_docs

class WAnimationConfigGridView extends StatelessWidget {
  /// Returns a [Align] widget in Teta
  const WAnimationConfigGridView(
    final Key? key, {
    required this.node,
    required this.index,
    required this.duration,
    required this.numberColumns,
    required this.forPlay,
    required this.params,
    required this.states,
    required this.dataset,
    this.child,
    this.loop,
  }) : super(key: key);

  final CNode node;
  final CNode? child;
  final FTextTypeInput index;
  final FTextTypeInput duration;
  final FTextTypeInput numberColumns;
  final bool forPlay;
  final int? loop;

  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

  @override
  Widget build(final BuildContext context) {
    return NodeSelectionBuilder(
      node: node,
      forPlay: forPlay,
      child: AnimationConfiguration.staggeredGrid(
        columnCount: int.tryParse(
              numberColumns.get(
                params,
                states,
                dataset,
                forPlay,
                loop,
                context,
              ),
            ) ??
            2,
        position: int.tryParse(
              index.get(
                params,
                states,
                dataset,
                forPlay,
                loop,
                context,
              ),
            ) ??
            0,
        duration: Duration(
          milliseconds: int.tryParse(
                duration.get(
                  params,
                  states,
                  dataset,
                  forPlay,
                  loop,
                  context,
                ),
              ) ??
              375,
        ),
        child: ChildConditionBuilder(
          ValueKey('${node.nid} $loop'),
          name: node.intrinsicState.displayName,
          node: node,
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
