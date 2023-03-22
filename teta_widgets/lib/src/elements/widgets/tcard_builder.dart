// Flutter imports:
// ignore_for_file: public_member_api_docs, avoid_dynamic_calls

// Dart imports:

// Flutter imports:
import 'dart:async';

import 'package:flutter/material.dart';
// Package imports:
import 'package:tcard/tcard.dart';
import 'package:teta_models/teta_models.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

class WTCardBuilder extends StatefulWidget {
  /// Returns a PageViewwidget
  const WTCardBuilder(
    final Key? key, {
    required this.state,
    required this.value,
    required this.lockYAxis,
    required this.slideSpeed,
    required this.delaySlideFor,
    required this.action,
    this.child,
  }) : super(key: key);

  final TetaWidgetState state;
  final CNode? child;
  final FDataset value;
  final bool lockYAxis;
  final FTextTypeInput slideSpeed;
  final FTextTypeInput delaySlideFor;
  final FAction action;

  @override
  _WTCardState createState() => _WTCardState();
}

class _WTCardState extends State<WTCardBuilder> {
  DatasetObject map = DatasetObject.empty();
  final _controller = TCardController();
  List<Widget> list = <Widget>[
    const Center(child: CircularProgressIndicator())
  ];
  bool isLoaded = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _fetch();
    if (!widget.state.forPlay) {
      _timer = Timer.periodic(const Duration(seconds: 2), (final timer) {
        _fetch();
        if (!widget.state.forPlay) {
          _controller.reset(cards: list);
        }
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    final slideSpeedStr = widget.slideSpeed.get(
      widget.state.params,
      widget.state.states,
      widget.state.dataset,
      widget.state.forPlay,
      widget.state.loop,
      context,
    );
    final slideSpeed = double.tryParse(slideSpeedStr) ?? 20;
    final delayStr = widget.delaySlideFor.get(
      widget.state.params,
      widget.state.states,
      widget.state.dataset,
      widget.state.forPlay,
      widget.state.loop,
      context,
    );
    final delay = int.tryParse(delayStr) ?? 500;
    return NodeSelectionBuilder(
      state: widget.state,
      child: IgnorePointer(
        ignoring: !widget.state.forPlay,
        child: TCard(
          controller: _controller,
          onEnd: () {
            GestureBuilder.get(
              context: context,
              state: widget.state,
              gesture: ActionGesture.onEnd,
              action: widget.action,
              actionValue: null,
            );
          },
          onForward: (final index, final info) {
            if (info.direction == SwipDirection.Right) {
              // swipe right
              GestureBuilder.get(
                context: context,
                state: widget.state,
                gesture: ActionGesture.swipeRight,
                action: widget.action,
                actionValue: null,
              );
            } else {
              // swipe left
              GestureBuilder.get(
                context: context,
                state: widget.state,
                gesture: ActionGesture.swipeLeft,
                action: widget.action,
                actionValue: null,
              );
            }
          },
          cards: list,
          lockYAxis: widget.lockYAxis,
          slideSpeed: slideSpeed,
          delaySlideFor: delay,
        ),
      ),
    );
  }

  void _fetch() {
    _setDataset();
    final index = widget.value.datasetName != null
        ? widget.state.dataset.indexWhere(
            (final element) => element.getName == widget.value.datasetName,
          )
        : -1;
    final db =
        index != -1 ? widget.state.dataset[index] : DatasetObject.empty();
    if (mounted) {
      final temp = <Widget>[];
      for (var i = 0; i < db.getMap.length; i++) {
        temp.add(
          widget.child!.toWidget(
            state: widget.state.copyWith(
              params: [...widget.state.params, ...widget.state.params],
              loop: i,
            ),
          ),
        );
      }
      if (mounted) {
        setState(() {
          list = temp;
          isLoaded = widget.state.forPlay;
        });
      }
    }
  }

  void _setDataset() {
    try {
      final index = widget.state.dataset.indexWhere(
        (final element) => element.getName == widget.value.datasetName,
      );
      final db =
          index != -1 ? widget.state.dataset[index] : DatasetObject.empty();
      if (mounted) {
        if (db.getName != '') {
          setState(() {
            map = db;
          });
        }
      }
    } catch (_) {}
  }
}
