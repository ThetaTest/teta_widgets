// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

class WMarker extends StatelessWidget {
  /// Returns a Icon widget in Teta
  const WMarker(
    final Key? key, {
    required this.icon,
    required this.node,
    required this.width,
    required this.fill,
    required this.forPlay,
    required this.params,
    required this.states,
    required this.dataset,
    required this.latitude,
    required this.longitude,
    this.child,
    this.loop,
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
  Widget build(final BuildContext context) {
    return GestureDetector(
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
    );
  }
}
