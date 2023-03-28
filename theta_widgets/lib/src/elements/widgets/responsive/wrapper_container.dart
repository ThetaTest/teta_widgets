// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_widgets/src/core/teta_widget/index.dart';
import 'package:teta_widgets/src/elements/builder/gesture_detector_base.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

//ignore: must_be_immutable
class WWrapperContainer extends StatelessWidget {
  const WWrapperContainer({
    required this.state,
    required this.isBoxed,
    final Key? key,
    this.child,
    this.index,
    this.component,
  }) : super(key: key);

  final TetaWidgetState state;
  final bool isBoxed;
  final CNode? child;
  final double? index;
  final String? component;

  @override
  Widget build(final BuildContext context) {
    return NodeSelection(
      state: state,
      child: GestureBuilderBase.get(
        context: context,
        state: state,
        child: isBoxed
            ? Builder(
                builder: (final context) {
                  if (MediaQuery.of(context).size.width > 1200) {
                    return Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 1200),
                        child: ChildConditionBuilder(
                          ValueKey('${state.toKey} desktop'),
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
                        ValueKey('${state.toKey} tablet'),
                        state: state,
                        child: child,
                      ),
                    );
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ChildConditionBuilder(
                      ValueKey('${state.toKey} mobile'),
                      state: state,
                      child: child,
                    ),
                  );
                },
              )
            : ChildConditionBuilder(
                ValueKey('${state.toKey} mobile'),
                state: state,
                child: child,
              ),
      ),
    );
  }
}
