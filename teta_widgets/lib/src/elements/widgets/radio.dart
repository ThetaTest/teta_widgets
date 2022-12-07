// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

// ignore_for_file: public_member_api_docs

class WRadio extends StatefulWidget {
  /// Returns a Radio widget in Teta
  const WRadio(
    final Key? key, {
    required this.state,
    required this.action,
    required this.value,
    required this.groupValue,
  }) : super(key: key);

  final TetaWidgetState state;
  final FAction action;
  final FTextTypeInput value;
  final FTextTypeInput groupValue;

  @override
  _WRadioState createState() => _WRadioState();
}

class _WRadioState extends State<WRadio> {
  bool val = false;
  @override
  Widget build(final BuildContext context) {
    return NodeSelectionBuilder(
      node: widget.state.node,
      forPlay: widget.state.forPlay,
      child: Radio<String>(
        groupValue: widget.groupValue.get(
          widget.state.params,
          widget.state.states,
          widget.state.dataset,
          widget.state.forPlay,
          widget.state.loop,
          context,
        ),
        value: widget.value.get(
          widget.state.params,
          widget.state.states,
          widget.state.dataset,
          widget.state.forPlay,
          widget.state.loop,
          context,
        ),
        onChanged: (final value) {
          GestureBuilder.get(
            context: context,
            state: widget.state,
            gesture: ActionGesture.onTap,
            action: widget.action,
            actionValue: null,
          );
          if (widget.state.forPlay) {
            if (mounted) {
              setState(() {
                val = !val;
              });
            }
          }
        },

        mouseCursor: const FCursor().get(),
        //activeColor: FFill(),
        //checkColor: FFill(),
        //focusColor: FFill(),
        //hoverColor: FFill(),

        //shape:
      ),
    );
  }
}
