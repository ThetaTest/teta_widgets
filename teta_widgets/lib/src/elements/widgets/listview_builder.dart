// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
import 'package:teta_widgets/src/elements/features/physic.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

class WListViewBuilder extends StatefulWidget {
  /// Returns a ListView.builder in Teta
  const WListViewBuilder(
    final Key? key, {
    required this.state,
    required this.child,
    required this.value,
    required this.startFromIndex,
    required this.limit,
    required this.shrinkWrap,
    required this.isVertical,
    required this.isReverse,
    required this.action,
    required this.physic,
  }) : super(key: key);

  final TetaWidgetState state;
  final CNode? child;
  final FTextTypeInput startFromIndex;
  final FTextTypeInput limit;
  final bool shrinkWrap;
  final bool isVertical;
  final bool isReverse;
  final FAction action;
  final FDataset value;
  final FPhysic physic;

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
        ? widget.state.dataset.indexWhere(
            (final element) => element.getName == widget.value.datasetName,
          )
        : -1;
    final db = index != -1 ? widget.state.dataset[index] : DatasetObject.empty();
    var startFromIndex = int.tryParse(
          widget.startFromIndex.get(
            widget.state.params,
            widget.state.states,
            widget.state.dataset,
            widget.state.forPlay,
            widget.state.loop,
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
            widget.state.params,
            widget.state.states,
            widget.state.dataset,
            widget.state.forPlay,
            widget.state.loop,
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
    return TetaWidget(
      state: widget.state,
      child: NotificationListener<ScrollEndNotification>(
        onNotification: (final scrollEnd) {
          final metrics = scrollEnd.metrics;
          if (metrics.atEdge) {
            final isTop = metrics.pixels == 0;
            if (isTop) {
              Logger.printMessage('At the top');
              GestureBuilder.get(
                context: context,
                node: widget.state.node,
                gesture: ActionGesture.scrollToTop,
                action: widget.action,
                actionValue: null,
                params: widget.state.params,
                states: widget.state.states,
                dataset: widget.state.dataset,
                forPlay: widget.state.forPlay,
              );
            } else {
              Logger.printMessage('At the bottom');
              GestureBuilder.get(
                context: context,
                node: widget.state.node,
                gesture: ActionGesture.scrollToBottom,
                action: widget.action,
                actionValue: null,
                params: widget.state.params,
                states: widget.state.states,
                dataset: widget.state.dataset,
                forPlay: widget.state.forPlay,
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
            scrollDirection: widget.isVertical ? Axis.vertical : Axis.horizontal,
            itemCount: db.getMap.sublist(startFromIndex, limit).length,
            itemBuilder: (final context, final index) {
              return widget.child != null
                  ? widget.child!.toWidget(state: widget.state.copyWith(loop: index))
                  : PlaceholderChildBuilder(
                      name: widget.state.node.intrinsicState.displayName,
                      node: widget.state.node,
                      forPlay: widget.state.forPlay,
                    );
            },
          ),
        ),
      ),
    );
  }

  void _setDataset() {
    try {
      final index = widget.state.dataset.indexWhere(
        (final element) => element.getName == widget.value.datasetName,
      );
      final db = index != -1 ? widget.state.dataset[index] : DatasetObject.empty();
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
