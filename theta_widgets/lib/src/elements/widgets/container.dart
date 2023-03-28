// Flutter imports:
// ignore_for_file: public_member_api_docs, no_leading_underscores_for_local_identifiers

// Flutter imports:

import 'package:flutter/material.dart';
// Package imports:
import 'package:theta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:theta_widgets/src/elements/index.dart';

class WContainer extends StatelessWidget {
  /// Returns a Container widget
  const WContainer(
    final Key? key, {
    required this.state,
    required this.width,
    required this.height,
    required this.margins,
    required this.paddings,
    required this.fill,
    required this.borderRadius,
    required this.borders,
    required this.shadows,
    this.child,
  }) : super(key: key);

  final TetaWidgetState state;
  final CNode? child;
  final FSize width;
  final FSize height;
  final FMargins margins;
  final FMargins paddings;
  final FFill fill;
  final FBorderRadius borderRadius;
  final FBorder borders;
  final FShadow shadows;

  @override
  Widget build(final BuildContext context) {
    final _width = width.get(
      context: context,
      isWidth: true,
      forPlay: state.forPlay,
    );
    final _height = height.get(
      context: context,
      isWidth: false,
      forPlay: state.forPlay,
    );
    return TetaWidget(
      state: state,
      child: Container(
        margin: margins.get(
          context,
          forPlay: state.forPlay,
        ),
        padding: paddings.get(
          context,
          forPlay: state.forPlay,
        ),
        width: _width,
        height: _height,
        decoration: TetaBoxDecoration.get(
          context: context,
          forPlay: state.forPlay,
          fill: fill.get(context),
          borderRadius: borderRadius,
          shadow: shadows,
          borders: borders,
        ),
        child: ChildConditionBuilder(
          ValueKey(state.toKey),
          state: state,
          child: child,
        ),
      ),
    );
    /*
    if (mustBeWrappedInExpanded) {
      return Expanded(
        child: container,
      );
    }
    return container;
    */
  }
}
