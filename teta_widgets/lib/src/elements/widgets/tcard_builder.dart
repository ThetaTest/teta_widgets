// Flutter imports:
// ignore_for_file: public_member_api_docs, avoid_dynamic_calls

// Dart imports:

// Flutter imports:
import 'dart:async';

import 'package:flutter/material.dart';
// Package imports:
import 'package:tcard/tcard.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

class WTCardBuilder extends StatefulWidget {
  /// Returns a PageViewwidget
  const WTCardBuilder(
    final Key? key, {
    required this.value,
    required this.lockYAxis,
    required this.slideSpeed,
    required this.delaySlideFor,
    required this.node,
    required this.forPlay,
    required this.params,
    required this.states,
    required this.dataset,
    required this.action,
    this.child,
    this.loop,
  }) : super(key: key);

  final CNode node;
  final CNode? child;
  final FDataset value;
  final bool lockYAxis;
  final FTextTypeInput slideSpeed;
  final FTextTypeInput delaySlideFor;
  final bool forPlay;
  final int? loop;
  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;
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
    if (!widget.forPlay) {
      _timer = Timer.periodic(const Duration(seconds: 2), (final timer) {
        _fetch();
        if (!widget.forPlay) {
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
      widget.params,
      widget.states,
      widget.dataset,
      widget.forPlay,
      widget.loop,
      context,
    );
    final slideSpeed = double.tryParse(slideSpeedStr) ?? 20;
    final delayStr = widget.delaySlideFor.get(
      widget.params,
      widget.states,
      widget.dataset,
      widget.forPlay,
      widget.loop,
      context,
    );
    final delay = int.tryParse(delayStr) ?? 500;
    return NodeSelectionBuilder(
      node: widget.node,
      forPlay: widget.forPlay,
      child: IgnorePointer(
        ignoring: !widget.forPlay,
        child: TCard(
          controller: _controller,
          onEnd: () {
            GestureBuilder.get(
              context: context,
              node: widget.node,
              gesture: ActionGesture.onEnd,
              action: widget.action,
              actionValue: null,
              params: widget.params,
              states: widget.states,
              dataset: widget.dataset,
              forPlay: widget.forPlay,
              loop: widget.loop,
            );
          },
          onForward: (final index, final info) {
            if (info.direction == SwipDirection.Right) {
              // swipe right
              GestureBuilder.get(
                context: context,
                node: widget.node,
                gesture: ActionGesture.swipeRight,
                action: widget.action,
                actionValue: null,
                params: widget.params,
                states: widget.states,
                dataset: widget.dataset,
                forPlay: widget.forPlay,
                loop: widget.loop,
              );
            } else {
              // swipe left
              GestureBuilder.get(
                context: context,
                node: widget.node,
                gesture: ActionGesture.swipeLeft,
                action: widget.action,
                actionValue: null,
                params: widget.params,
                states: widget.states,
                dataset: widget.dataset,
                forPlay: widget.forPlay,
                loop: widget.loop,
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
        ? widget.dataset.indexWhere(
            (final element) => element.getName == widget.value.datasetName,
          )
        : -1;
    final db = index != -1 ? widget.dataset[index] : DatasetObject.empty();
    if (mounted) {
      final temp = <Widget>[];
      for (var i = 0; i < db.getMap.length; i++) {
        temp.add(
          widget.child!.toWidget(
            forPlay: widget.forPlay,
            params: [...widget.params, ...widget.params],
            states: widget.states,
            dataset: widget.dataset,
            loop: i,
          ),
        );
      }
      if (mounted) {
        setState(() {
          list = temp;
          isLoaded = widget.forPlay;
        });
      }
    }
  }

  void _setDataset() {
    try {
      final index = widget.dataset.indexWhere(
        (final element) => element.getName == widget.value.datasetName,
      );
      final db = index != -1 ? widget.dataset[index] : DatasetObject.empty();
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
