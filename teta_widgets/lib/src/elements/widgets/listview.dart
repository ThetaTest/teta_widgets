// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/features/physic.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

class WListView extends StatelessWidget {
  /// Returns a ListView in Teta
  const WListView(
    final Key? key, {
    required this.children,
    required this.node,
    required this.forPlay,
    required this.flagValue,
    required this.value,
    required this.physic,
    required this.isVertical,
    required this.isReverse,
    required this.action,
    required this.params,
    required this.states,
    required this.dataset,
    required this.isPrimary,
    required this.shrinkWrap,
    this.loop,
  }) : super(key: key);

  final CNode node;
  final List<CNode> children;
  final bool forPlay;
  final bool isVertical;
  final bool flagValue;
  final FTextTypeInput value;
  final FAction action;
  final FPhysic physic;
  final bool isPrimary;
  final bool isReverse;
  final int? loop;
  final bool shrinkWrap;

  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

  @override
  Widget build(final BuildContext context) {
    return NodeSelectionBuilder(
      node: node,
      forPlay: forPlay,
      child: NotificationListener<ScrollEndNotification>(
        onNotification: (final scrollEnd) {
          final metrics = scrollEnd.metrics;
          if (metrics.atEdge) {
            final isTop = metrics.pixels == 0;
            if (isTop) {
              Logger.printMessage('At the top');
              GestureBuilder.get(
                context: context,
                node: node,
                gesture: ActionGesture.scrollToTop,
                action: action,
                actionValue: null,
                params: params,
                states: states,
                dataset: dataset,
                forPlay: forPlay,
              );
            } else {
              Logger.printMessage('At the bottom');
              GestureBuilder.get(
                context: context,
                node: node,
                gesture: ActionGesture.scrollToBottom,
                action: action,
                actionValue: null,
                params: params,
                states: states,
                dataset: dataset,
                forPlay: forPlay,
              );
            }
          }
          return true;
        },
        child: ListView.builder(
          reverse: isReverse,
          physics: physic.physics,
          addAutomaticKeepAlives: false,
          addRepaintBoundaries: false,
          scrollDirection: isVertical ? Axis.vertical : Axis.horizontal,
          itemCount: children.isEmpty ? 1 : children.length + 1,
          itemBuilder: (final context, final index) {
            return children.isNotEmpty
                ? index == children.length
                    ? PlaceholderChildBuilder(
                        name: node.intrinsicState.displayName,
                        node: node,
                        forPlay: forPlay,
                      )
                    : children[index].toWidget(
                        loop: loop,
                        forPlay: forPlay,
                        params: params,
                        states: states,
                        dataset: dataset,
                      )
                : PlaceholderChildBuilder(
                    name: node.intrinsicState.displayName,
                    node: node,
                    forPlay: forPlay,
                  );
          },
        ),
      ),
    );
  }
}
