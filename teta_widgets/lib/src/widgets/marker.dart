// Flutter imports:
// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:teta_core/teta_core.dart';

class WMarker extends StatelessWidget {
  /// Returns a Icon widget in Teta
  const WMarker({
    Key? key,
    this.child,
    required this.icon,
    required this.node,
    required this.width,
    required this.fill,
    required this.forPlay,
    this.loop,
    required this.params,
    required this.states,
    required this.dataset,
    required this.latitude,
    required this.longitude,
  }) : super(key: key);

  final CNode node;
  final CNode? child;
  final FSize? width;
  final String icon;
  final FFill fill;
  final bool forPlay;
  final int? loop;
  final FTextTypeInput latitude;
  final FTextTypeInput longitude;

  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: ChildConditionBuilder(
        name: node.intrinsicState.displayName,
        child: child,
        params: params,
        states: states,
        dataset: dataset,
        forPlay: forPlay,
        loop: loop,
      ),
    );
  }
}
