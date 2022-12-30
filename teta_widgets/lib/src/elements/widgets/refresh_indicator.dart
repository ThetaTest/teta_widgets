// Flutter imports:
// Package imports:
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

// ignore_for_file: public_member_api_docs

class WRefreshIndicator extends StatelessWidget {
  /// Returns a [Center] widget in Teta
  const WRefreshIndicator(
    final Key? key, {
    required this.state,
    required this.children,
    required this.height,
    required this.duration,
    required this.actionValue,
    this.action,
  }) : super(key: key);

  final TetaWidgetState state;
  final List<CNode> children;

  final FAction? action;
  final FTextTypeInput actionValue;
  final FSize height;
  final FTextTypeInput duration;

  @override
  Widget build(final BuildContext context) {
    final val = height.get(context: context, isWidth: false) ?? 150;
    return NodeSelectionBuilder(
      state: state,
      child: CustomRefreshIndicator(
        offsetToArmed: val,
        child: children.isNotEmpty
            ? children[0].toWidget(state: state)
            : PlaceholderChildBuilder(
                name: state.node.intrinsicState.displayName,
                node: state.node,
                forPlay: state.forPlay,
              ),

        /// Custom indicator builder function
        builder: (
          final BuildContext context,
          final Widget child,
          final IndicatorController controller,
        ) {
          return Stack(
            children: <Widget>[
              AnimatedBuilder(
                animation: controller,
                builder: (final BuildContext context, final _) {
                  /// This part will be rebuild on every controller change
                  return children.length >= 2
                      ? children[1].toWidget(state: state)
                      : const CircularProgressIndicator();
                },
              ),
              AnimatedBuilder(
                builder: (final context, final _) {
                  return Transform.translate(
                    offset: Offset(0, controller.value * val),
                    child: child,
                  );
                },
                animation: controller,
              ),
            ],
          );
        },

        /// A function that's called when the user has dragged the refresh
        /// indicator
        /// far enough to demonstrate that they want the app to refresh.
        /// Should return [Future].
        onRefresh: () async {
          final val = duration.get(
            state.params,
            state.states,
            state.dataset,
            state.forPlay,
            state.loop,
            context,
          );
          await Future<void>.delayed(
            Duration(
              milliseconds: int.tryParse(val) != null ? int.parse(val) : 1000,
            ),
          );
          GestureBuilder.get(
            context: context,
            state: state,
            gesture: ActionGesture.onTap,
            action: action,
            actionValue: actionValue,
          );
          return;
        },
      ),
    );
  }
}
