// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_widgets/src/core/teta_widget/index.dart';
import 'package:teta_widgets/src/elements/index.dart';

class WFractionallySizedBox extends StatelessWidget {
  /// Returns a FractionallySizedBox widget in Teta
  const WFractionallySizedBox(
    final Key? key, {
    required this.state,
    // Widget params
    required this.heightFactor,
    required this.widthFactor,
    this.child,
  }) : super(key: key);

  final TetaWidgetState state;

  // Widget params
  final FSize? widthFactor;
  final FSize? heightFactor;
  final CNode? child;

  @override
  Widget build(final BuildContext context) {
    return TetaWidget(
      state: state,
      child: FractionallySizedBox(
        widthFactor: widthFactor?.get(context: context, isWidth: true),
        heightFactor: heightFactor?.get(context: context, isWidth: false),
        child: ChildConditionBuilder(
          ValueKey('${state.node.nid} ${state.loop}'),
          state: state,
          child: child,
        ),
      ),
    );
  }
}
