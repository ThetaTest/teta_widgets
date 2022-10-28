// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/builder/gesture_detector_base.dart';
import 'package:teta_widgets/src/elements/features/physic.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

class WListViewBuilder extends StatefulWidget {
  /// Returns a ListView.builder in Teta
  const WListViewBuilder(
    final Key? key, {
    required this.child,
    required this.node,
    required this.forPlay,
    required this.value,
    required this.startFromIndex,
    required this.limit,
    required this.shrinkWrap,
    required this.isVertical,
    required this.isReverse,
    required this.action,
    required this.physic,
    required this.params,
    required this.states,
    required this.dataset,
    this.loop,
  }) : super(key: key);

  final CNode node;
  final CNode? child;
  final bool forPlay;
  final FTextTypeInput startFromIndex;
  final FTextTypeInput limit;
  final bool shrinkWrap;
  final bool isVertical;
  final bool isReverse;
  final FAction action;
  final FDataset value;
  final FPhysic physic;
  final int? loop;

  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

  @override
  WListViewBuilderState createState() => WListViewBuilderState();
}

class WListViewBuilderState extends State<WListViewBuilder> {
  DatasetObject map = DatasetObject.empty();
  bool isLoading = true;

  @override
  Widget build(final BuildContext context) {
    _setDataset();
    final index = widget.value.datasetName != null
        ? widget.dataset.indexWhere(
            (final element) => element.getName == widget.value.datasetName,
          )
        : -1;
    final db = index != -1 ? widget.dataset[index] : DatasetObject.empty();
    var startFromIndex = int.tryParse(
          widget.startFromIndex.get(
            widget.params,
            widget.states,
            widget.dataset,
            widget.forPlay,
            widget.loop,
            context,
          ),
        ) ??
        0;
    if (startFromIndex < 0) {
      startFromIndex = 0;
    }
    if (startFromIndex >= db.getMap.length) {
      startFromIndex = 0;
    }
    var limit = int.tryParse(
          widget.limit.get(
            widget.params,
            widget.states,
            widget.dataset,
            widget.forPlay,
            widget.loop,
            context,
          ),
        ) ??
        db.getMap.length;
    Logger.printWarning('Listview.builder limit: $limit');
    if (limit <= 0) {
      limit = db.getMap.length;
    }
    if (limit > db.getMap.length) {
      limit = db.getMap.length;
    }
    return NodeSelectionBuilder(
      node: widget.node,
      forPlay: widget.forPlay,
      child: GestureBuilderBase.get(
        context: context,
        node: widget.node,
        params: widget.params,
        states: widget.states,
        dataset: widget.dataset,
        forPlay: widget.forPlay,
        loop: widget.loop,
        child: NotificationListener<ScrollEndNotification>(
          onNotification: (final scrollEnd) {
            final metrics = scrollEnd.metrics;
            if (metrics.atEdge) {
              final isTop = metrics.pixels == 0;
              if (isTop) {
                Logger.printMessage('At the top');
                GestureBuilder.get(
                  context: context,
                  node: widget.node,
                  gesture: ActionGesture.scrollToTop,
                  action: widget.action,
                  actionValue: null,
                  params: widget.params,
                  states: widget.states,
                  dataset: widget.dataset,
                  forPlay: widget.forPlay,
                );
              } else {
                Logger.printMessage('At the bottom');
                GestureBuilder.get(
                  context: context,
                  node: widget.node,
                  gesture: ActionGesture.scrollToBottom,
                  action: widget.action,
                  actionValue: null,
                  params: widget.params,
                  states: widget.states,
                  dataset: widget.dataset,
                  forPlay: widget.forPlay,
                );
              }
            }
            return true;
          },
          child: ScrollConfiguration(
            behavior: _MyCustomScrollBehavior(),
            child: ListView.builder(
              reverse: widget.isReverse,
              physics: widget.physic.physics,
              addAutomaticKeepAlives: false,
              addRepaintBoundaries: false,
              shrinkWrap: widget.shrinkWrap,
              scrollDirection:
                  widget.isVertical ? Axis.vertical : Axis.horizontal,
              itemCount: db.getMap.sublist(startFromIndex, limit).length,
              itemBuilder: (final context, final index) {
                return widget.child != null
                    ? widget.child!.toWidget(
                        forPlay: widget.forPlay,
                        params: widget.params,
                        states: widget.states,
                        dataset: widget.dataset,
                        loop: index,
                      )
                    : PlaceholderChildBuilder(
                        name: widget.node.intrinsicState.displayName,
                        node: widget.node,
                        forPlay: widget.forPlay,
                      );
              },
            ),
          ),
        ),
      ),
    );
  }

  void _setDataset() {
    try {
      final index = widget.dataset.indexWhere(
        (final element) => element.getName == widget.value.datasetName,
      );
      final db = index != -1 ? widget.dataset[index] : DatasetObject.empty();
      if (mounted) {
        if (db.getName != '') {
          if (mounted) {
            setState(() {
              map = db;
            });
          }
        }
      }
    } catch (_) {}
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
