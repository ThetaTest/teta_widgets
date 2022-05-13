// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

// Project imports:

// ignore_for_file: public_member_api_docs

class WAnimationConfigurationListView extends StatelessWidget {
  /// Returns a [Align] widget in Teta
  const WAnimationConfigurationListView(
    final Key? key, {
    required this.node,
    required this.index,
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
  final FTextTypeInput index;
  final FTextTypeInput duration;
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
      child: AnimationConfiguration.staggeredList(
        position: int.tryParse(
              index.get(params, states, dataset, forPlay, loop),
            ) ??
            0,
        duration: Duration(
          milliseconds: int.tryParse(
                duration.get(params, states, dataset, forPlay, loop),
              ) ??
              375,
        ),
        child: ChildConditionBuilder(
          ValueKey('${node.nid} $loop'),
          name: NodeType.name(NType.align),
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
