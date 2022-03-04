// Flutter imports:
// ignore_for_file: public_member_api_docs, avoid_dynamic_calls

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tcard/tcard.dart';
import 'package:teta_core/teta_core.dart';

class WTCardBuilder extends StatefulWidget {
  /// Returns a PageViewwidget
  const WTCardBuilder({
    Key? key,
    this.child,
    required this.value,
    required this.lockYAxis,
    required this.slideSpeed,
    required this.delaySlideFor,
    required this.node,
    this.loop,
    required this.forPlay,
    required this.params,
    required this.states,
    required this.dataset,
    required this.action,
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
  DatasetObject map = DatasetObject.empty;
  final _controller = TCardController();
  List<Widget> list = <Widget>[
    const Center(child: CircularProgressIndicator())
  ];
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    _fetch();
    Timer.periodic(const Duration(seconds: 1), (timer) {
      _fetch();
      if (!isLoaded) {
        _controller.reset(cards: list);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final slideSpeedStr = widget.slideSpeed.get(
      widget.params,
      widget.states,
      widget.dataset,
      widget.forPlay,
      widget.loop,
    );
    final slideSpeed = double.tryParse(slideSpeedStr) ?? 20;
    final delayStr = widget.delaySlideFor.get(
      widget.params,
      widget.states,
      widget.dataset,
      widget.forPlay,
      widget.loop,
    );
    final delay = int.tryParse(delayStr) ?? 500;
    return NodeSelectionBuilder(
      node: widget.node,
      forPlay: widget.forPlay,
      child: IgnorePointer(
        ignoring: !widget.forPlay,
        child: TCard(
          controller: _controller,
          onForward: (index, info) {
            if (info.direction == SwipDirection.Right) {
              // like
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
              // dislike
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
            (element) => element.getName == widget.value.datasetName,
          )
        : -1;
    final db = index != -1 ? widget.dataset[index] : DatasetObject.empty;
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
      setState(() {
        list = temp;
        isLoaded = widget.forPlay;
      });
    }
  }

  void _setDataset() {
    try {
      final index = widget.dataset
          .indexWhere((element) => element.getName == widget.value.datasetName);
      final db = index != -1 ? widget.dataset[index] : DatasetObject.empty;
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
