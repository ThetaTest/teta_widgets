// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
import 'package:teta_widgets/src/elements/builder/reorder_children.dart';
import 'package:teta_widgets/src/elements/features/physic.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

class WListView extends StatefulWidget {
  /// Returns a ListView in Teta
  const WListView(
    final Key? key, {
    required this.state,
    required this.children,
    required this.flagValue,
    required this.value,
    required this.physic,
    required this.isVertical,
    required this.isReverse,
    required this.action,
    required this.isPrimary,
    required this.shrinkWrap,
  }) : super(key: key);

  final TetaWidgetState state;
  final List<CNode> children;
  final bool isVertical;
  final bool flagValue;
  final FTextTypeInput value;
  final FAction action;
  final FPhysic physic;
  final bool isPrimary;
  final bool isReverse;
  final bool shrinkWrap;

  @override
  State<WListView> createState() => _WListViewState();
}

class _WListViewState extends State<WListView> {
  List<CNode> children = [];

  @override
  void initState() {
    children = widget.children;
    super.initState();
  }

  @override
  Widget build(final BuildContext context) {
    return TetaWidget(
      state: widget.state,
      child: NotificationListener<ScrollEndNotification>(
        onNotification: (final scrollEnd) {
          final metrics = scrollEnd.metrics;
          if (metrics.atEdge) {
            final isTop = metrics.pixels == 0;
            if (isTop) {
              GestureBuilder.get(
                context: context,
                state: widget.state,
                gesture: ActionGesture.scrollToTop,
                action: widget.action,
                actionValue: null,
              );
            } else {
              GestureBuilder.get(
                context: context,
                state: widget.state,
                gesture: ActionGesture.scrollToBottom,
                action: widget.action,
                actionValue: null,
              );
            }
          }
          return true;
        },
        child: ScrollConfiguration(
          behavior: _MyCustomScrollBehavior(),
          child: BlocBuilder<FocusBloc, List<CNode>>(
            builder: (final context, final nodes) {
              if (nodes.length == 1) {
                final index = widget.children.indexWhere(
                  (final element) => element.nid == nodes.first.nid,
                );
                if (index != -1) {
                  return ReorderableListView.builder(
                    onReorder: (final oldIndex, final newIndex) {
                      ReorderChildren.reorder(
                        widget.state.node,
                        children,
                        oldIndex,
                        newIndex,
                      );
                      setState(() {});
                    },
                    reverse: widget.isReverse,
                    physics: widget.physic.physics,
                    scrollDirection:
                        widget.isVertical ? Axis.vertical : Axis.horizontal,
                    itemCount: children.isEmpty ? 1 : children.length,
                    itemBuilder: (final context, final index) {
                      return children.isNotEmpty
                          ? children[index].toWidget(
                              state: widget.state,
                              isVertical: widget.isVertical,
                            )
                          : PlaceholderChildBuilder(
                              name:
                                  widget.state.node.intrinsicState.displayName,
                              node: widget.state.node,
                              forPlay: widget.state.forPlay,
                            );
                    },
                  );
                }
              }
              return ListView.builder(
                reverse: widget.isReverse,
                physics: widget.physic.physics,
                addAutomaticKeepAlives: false,
                addRepaintBoundaries: false,
                scrollDirection:
                    widget.isVertical ? Axis.vertical : Axis.horizontal,
                itemCount: children.isEmpty ? 1 : children.length,
                itemBuilder: (final context, final index) {
                  return children.isNotEmpty
                      ? children[index].toWidget(
                          state: widget.state,
                          isVertical: widget.isVertical,
                        )
                      : PlaceholderChildBuilder(
                          name: widget.state.node.intrinsicState.displayName,
                          node: widget.state.node,
                          forPlay: widget.state.forPlay,
                        );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class _MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        // etc.
      };
}
