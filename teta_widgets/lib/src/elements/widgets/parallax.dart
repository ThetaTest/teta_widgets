// Flutter imports:
// ignore_for_file: public_member_api_docs, import_of_legacy_library_into_null_safe, lines_longer_than_80_chars

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

class WParallax extends StatelessWidget {
  /// Returns a SizedBox widget in Teta
  const WParallax(
    final Key? key, {
    required this.node,
    required this.height,
    required this.forPlay,
    required this.params,
    required this.states,
    required this.dataset,
    this.child,
    this.loop,
  }) : super(key: key);

  final CNode node;
  final CNode? child;
  final FSize height;
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
      child: const Center(
        child: CText(
          'Sorry, Parallax widget is deprecated',
          typography: CTypo.extraBold16(),
        ),
      ),
    ); /*Parallax.inside(
        mainAxisExtent: height.get(context: context, isWidth: false),
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
    );*/
  }
}
