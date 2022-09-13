// Flutter imports:
import 'package:flutter/cupertino.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/builder/gesture_detector_base.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

// ignore_for_file: public_member_api_docs

class WCupertinoAppBar extends StatelessWidget {
  /// Returns a MaterialAppBar widget in Teta
  const WCupertinoAppBar(
    final Key? key, {
    required this.node,
    required this.fill,
    required this.forPlay,
    required this.params,
    required this.states,
    required this.dataset,
    required this.children,
    this.loop,
  }) : super(key: key);

  final CNode node;
  final List<CNode> children;
  final FFill fill;
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
      child: GestureBuilderBase.get(
        context: context,
        node: node,
        params: params,
        states: states,
        dataset: dataset,
        forPlay: forPlay,
        loop: loop,
        child: CupertinoNavigationBar(
          backgroundColor: HexColor(fill.getHexColor(context)),
          leading: children.isNotEmpty
              ? children[0].toWidget(
                  params: params,
                  states: states,
                  dataset: dataset,
                  forPlay: forPlay,
                )
              : null,
          middle: children.length >= 2
              ? children[1].toWidget(
                  params: params,
                  states: states,
                  dataset: dataset,
                  forPlay: forPlay,
                )
              : null,
          trailing: children.length >= 3
              ? children[2].toWidget(
                  params: params,
                  states: states,
                  dataset: dataset,
                  forPlay: forPlay,
                )
              : null,
        ),
      ),
    );
  }
}
