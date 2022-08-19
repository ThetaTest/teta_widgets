// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

// ignore_for_file: public_member_api_docs

class WRadio extends StatefulWidget {
  /// Returns a Radio widget in Teta
  const WRadio(
    final Key? key, {
    required this.node,
    required this.forPlay,
    required this.action,
    required this.value,
    required this.groupValue,
    required this.params,
    required this.states,
    required this.dataset,
    this.loop,
  }) : super(key: key);

  final CNode node;
  final bool forPlay;
  final int? loop;
  final FAction action;
  final FTextTypeInput value;
  final FTextTypeInput groupValue;

  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

  @override
  _WRadioState createState() => _WRadioState();
}

class _WRadioState extends State<WRadio> {
  bool val = false;
  @override
  Widget build(final BuildContext context) {
    return NodeSelectionBuilder(
      node: widget.node,
      forPlay: widget.forPlay,
      child: Radio<String>(
        groupValue: widget.groupValue.get(
          widget.params,
          widget.states,
          widget.dataset,
          widget.forPlay,
          widget.loop,
          context,
        ),
        value: widget.value.get(
          widget.params,
          widget.states,
          widget.dataset,
          widget.forPlay,
          widget.loop,
          context,
        ),
        onChanged: (final value) {
          GestureBuilder.get(
            context: context,
            node: widget.node,
            gesture: ActionGesture.onTap,
            action: widget.action,
            actionValue: null,
            params: widget.params,
            states: widget.states,
            dataset: widget.dataset,
            forPlay: widget.forPlay,
          );
          if (widget.forPlay) {
            setState(() {
              val = !val;
            });
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
