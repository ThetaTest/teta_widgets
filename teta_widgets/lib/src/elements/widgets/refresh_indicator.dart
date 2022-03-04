// Flutter imports:
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/index.dart';

// ignore_for_file: public_member_api_docs

class WRefreshIndicator extends StatelessWidget {
  /// Returns a [Center] widget in Teta
  const WRefreshIndicator({
    Key? key,
    required this.node,
    required this.forPlay,
    required this.params,
    required this.states,
    required this.dataset,
    required this.children,
    required this.height,
    required this.duration,
    this.action,
    required this.actionValue,
    this.loop,
  }) : super(key: key);

  final CNode node;
  final List<CNode> children;
  final bool forPlay;
  final int? loop;

  final FAction? action;
  final FTextTypeInput actionValue;
  final FSize height;
  final FTextTypeInput duration;

  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

  @override
  Widget build(BuildContext context) {
    final val = height.get(context: context, isWidth: false) ?? 150;
    return NodeSelectionBuilder(
      node: node,
      forPlay: forPlay,
      child: CustomRefreshIndicator(
        offsetToArmed: val,
        child: children.isNotEmpty
            ? children[0].toWidget(
                params: params,
                states: states,
                dataset: dataset,
                forPlay: forPlay,
              )
            : PlaceholderChildBuilder(name: node.intrinsicState.displayName),

        /// Custom indicator builder function
        builder: (
          BuildContext context,
          Widget child,
          IndicatorController controller,
        ) {
          return Stack(
            children: <Widget>[
              AnimatedBuilder(
                animation: controller,
                builder: (BuildContext context, _) {
                  /// This part will be rebuild on every controller change
                  return children.length >= 2
                      ? children[1].toWidget(
                          params: params,
                          states: states,
                          dataset: dataset,
                          forPlay: forPlay,
                        )
                      : const CircularProgressIndicator();
                },
              ),
              AnimatedBuilder(
                builder: (context, _) {
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
          final val = duration.get(params, states, dataset, forPlay, loop);
          await Future<void>.delayed(
            Duration(
              milliseconds: int.tryParse(val) != null ? int.parse(val) : 1000,
            ),
          );
          GestureBuilder.get(
            context: context,
            node: node,
            gesture: ActionGesture.onTap,
            action: action,
            actionValue: actionValue,
            params: params,
            states: states,
            dataset: dataset,
            forPlay: forPlay,
          );
          return;
        },
      ),
    );
  }
}
