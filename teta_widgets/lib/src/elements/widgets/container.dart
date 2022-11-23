// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

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
    return TetaWidget(
      state: state,
      child: Container(
        margin: margins.get(context),
        padding: paddings.get(context),
        width: width.get(context: context, isWidth: true),
        height: height.get(context: context, isWidth: false),
        decoration: TetaBoxDecoration.get(
          context: context,
          fill: fill.get(context),
          borderRadius: borderRadius,
          shadow: shadows,
          borders: borders,
        ),
        child: ChildConditionBuilder(
          ValueKey('${state.node.nid} ${state.loop}'),
          state: state,
          child: child,
        ),
      ),
    );
  }
}
