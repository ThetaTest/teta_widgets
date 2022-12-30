// ignore_for_file: public_member_api_docs, avoid_dynamic_calls

// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:tcard/tcard.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

class WTCard extends StatefulWidget {
  /// Returns a PageViewwidget
  const WTCard(
    final Key? key, {
    required this.state,
    required this.children,
    required this.lockYAxis,
    required this.slideSpeed,
    required this.delaySlideFor,
    required this.action,
  }) : super(key: key);

  final TetaWidgetState state;
  final List<CNode> children;
  final bool lockYAxis;
  final FTextTypeInput slideSpeed;
  final FTextTypeInput delaySlideFor;
  final FAction action;

  @override
  _WTCardState createState() => _WTCardState();
}

class _WTCardState extends State<WTCard> {
  final _controller = TCardController();
  List<Widget> list = <Widget>[];
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    list = widget.children
        .map(
          (final e) => e.toWidget(
            state: widget.state.copyWith(
              loop: widget.children.indexOf(e),
            ),
          ),
        )
        .toList();
    if (!widget.state.forPlay) {
      _timer = Timer.periodic(const Duration(seconds: 2), (final timer) {
        list = widget.children
            .map(
              (final e) => e.toWidget(
                state: widget.state.copyWith(
                  loop: widget.children.indexOf(e),
                ),
              ),
            )
            .toList();
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
}
