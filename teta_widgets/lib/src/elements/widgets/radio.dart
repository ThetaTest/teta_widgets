// Flutter imports:
import 'package:flutter/material.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/index.dart';

// ignore_for_file: public_member_api_docs

class WRadio extends StatefulWidget {
  /// Returns a Radio widget in Teta
  const WRadio({
    Key? key,
    required this.node,
    this.nid,
    this.parent,
    required this.forPlay,
    this.index,
    required this.action,
    required this.value,
    required this.groupValue,
    this.component,
    this.loop,
    required this.params,
    required this.states,
    required this.dataset,
  }) : super(key: key);

  final CNode node;
  final String? nid;
  final String? parent;
  final bool forPlay;
  final double? index;
  final String? component;
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
  Widget build(BuildContext context) {
    return NodeSelectionBuilder(
      node: widget.node,
      forPlay: widget.forPlay,
      child: Radio<String>(
        value: widget.groupValue.get(
          widget.params,
          widget.states,
          widget.dataset,
          widget.forPlay,
          widget.loop,
        ),
        groupValue: widget.value.get(
          widget.params,
          widget.states,
          widget.dataset,
          widget.forPlay,
          widget.loop,
        ),
        onChanged: (value) {
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
