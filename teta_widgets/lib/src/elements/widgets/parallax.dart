// Flutter imports:
// ignore_for_file: public_member_api_docs, import_of_legacy_library_into_null_safe, lines_longer_than_80_chars

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
import 'package:teta_widgets/src/elements/builder/gesture_detector_base.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

class WParallax extends StatelessWidget {
  /// Returns a SizedBox widget in Teta
  const WParallax(
    final Key? key, {
    required this.state,
    required this.height,
    this.child,
  }) : super(key: key);

  final TetaWidgetState state;
  final CNode? child;
  final FSize height;

  @override
  Widget build(final BuildContext context) {
    return TetaWidget(
      state: state,
      child: const Center(
        child: TParagraph(
          'Sorry, Parallax widget is deprecated',
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
