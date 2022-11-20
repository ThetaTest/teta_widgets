// Flutter imports:
import 'package:flutter/material.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

// ignore_for_file: public_member_api_docs

class WTransform extends StatelessWidget {
  /// Returns a tooltip widget in Teta
  const WTransform(
    final Key? key, {
    required this.state,
    required this.valueX,
    required this.valueY,
    required this.valueZ,
    this.child,
  }) : super(key: key);

  final TetaWidgetState state;
  final CNode? child;
  final FTextTypeInput valueX;
  final FTextTypeInput valueY;
  final FTextTypeInput valueZ;

  @override
  Widget build(final BuildContext context) {
    return TetaWidget(
      state: state,
      child: Transform(
        transform: Matrix4.identity()
          ..setEntry(1, 1, 1)
          ..rotateX(
            double.tryParse(
                  valueX.get(
                    state.params,
                    state.states,
                    state.dataset,
                    state.forPlay,
                    state.loop,
                    context,
                  ),
                ) ??
                0,
          )
          ..rotateY(
            double.tryParse(
                  valueY.get(
                    state.params,
                    state.states,
                    state.dataset,
                    state.forPlay,
                    state.loop,
                    context,
                  ),
                ) ??
                0,
          )
          ..rotateZ(
            double.tryParse(
                  valueZ.get(
                    state.params,
                    state.states,
                    state.dataset,
                    state.forPlay,
                    state.loop,
                    context,
                  ),
                ) ??
                0,
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
