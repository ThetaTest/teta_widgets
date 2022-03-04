// Flutter imports:
// ignore_for_file: public_member_api_docs, import_of_legacy_library_into_null_safe, lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter_parallax/flutter_parallax.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/index.dart';

class WParallax extends StatelessWidget {
  /// Returns a SizedBox widget in Teta
  const WParallax({
    Key? key,
    this.child,
    required this.node,
    required this.height,
    this.nid,
    this.parent,
    required this.forPlay,
    this.loop,
    required this.params,
    required this.states,
    required this.dataset,
  }) : super(key: key);

  final CNode node;
  final String? nid;
  final String? parent;
  final CNode? child;
  final FSize height;
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
      child: Parallax.inside(
        mainAxisExtent: height.get(context: context, isWidth: false),
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
