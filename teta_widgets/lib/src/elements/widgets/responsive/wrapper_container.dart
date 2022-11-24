// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
import 'package:teta_widgets/src/elements/builder/gesture_detector_base.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

//ignore: must_be_immutable
class WWrapperContainer extends StatelessWidget {
  const WWrapperContainer({
    required this.state,
    final Key? key,
    this.child,
    this.index,
    this.component,
  }) : super(key: key);

  final TetaWidgetState state;
  final CNode? child;
  final double? index;
  final String? component;

  @override
  Widget build(final BuildContext context) {
    Logger.printWarning('${MediaQuery.of(context).size.width}');
    return NodeSelection(
      node: state.node,
      forPlay: state.forPlay,
      nid: state.node.nid,
      child: GestureBuilderBase.get(
        context: context,
        state: state,
        child: Builder(
          builder: (final context) {
            if (MediaQuery.of(context).size.width > 1200) {
              return Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1200),
                  child: ChildConditionBuilder(
                    ValueKey('${state.node.nid} ${state.loop} desktop'),
                    state: state,
                    child: child,
                  ),
                ),
              );
            }
            if (MediaQuery.of(context).size.width > 600) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100),
                child: ChildConditionBuilder(
                  ValueKey('${state.node.nid} ${state.loop} tablet'),
                  state: state,
                  child: child,
                ),
              );
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ChildConditionBuilder(
                ValueKey('${state.node.nid} ${state.loop} mobile'),
                state: state,
                child: child,
              ),
            );
          },
        ),
      ),
    );
  }
}
