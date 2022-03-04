// Flutter imports:
import 'package:flutter/material.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';
// ignore_for_file: public_member_api_docs

class WAnimatedAlign extends StatelessWidget {
  /// Returns a [Align] widget in Teta
  const WAnimatedAlign({
    Key? key,
    required this.node,
    required this.align,
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
  final FAlign align;
  final FTextTypeInput duration;
  final bool forPlay;
  final int? loop;

  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

  @override
  Widget build(BuildContext context) {
    final val = duration.get(params, states, dataset, forPlay, loop);
    return NodeSelectionBuilder(
      node: node,
      forPlay: forPlay,
      child: AnimatedAlign(
        duration: Duration(
          milliseconds: int.tryParse(val) != null ? int.parse(val) : 400,
        ),
        alignment: align.align!,
        child: ChildConditionBuilder(
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
