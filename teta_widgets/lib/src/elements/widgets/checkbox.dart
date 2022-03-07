// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:teta_core/teta_core.dart';

// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

// ignore_for_file: public_member_api_docs

class WCheckBox extends StatefulWidget {
  /// Returns a CheckBox widget in Teta
  const WCheckBox(
    Key? key, {
    required this.node,
    required this.forPlay,
    required this.action,
    required this.params,
    required this.states,
    required this.dataset,
    this.loop,
  }) : super(key: key);

  final CNode node;
  final bool forPlay;
  final int? loop;
  final FAction action;

  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

  @override
  State<WCheckBox> createState() => _WCheckBoxState();
}

class _WCheckBoxState extends State<WCheckBox> {
  bool flag = false;
  @override
  Widget build(BuildContext context) {
    return NodeSelectionBuilder(
      node: widget.node,
      forPlay: widget.forPlay,
      child: IgnorePointer(
        ignoring: !widget.forPlay,
        child: Checkbox(
          onChanged: (value) {
            if (widget.forPlay) {
              setState(() {
                flag = value ?? false;
              });
            }
            GestureBuilder.get(
              context: context,
              node: widget.node,
              action: widget.action,
              actionValue: FTextTypeInput(value: '$flag'),
              gesture: ActionGesture.onChange,
              params: widget.params,
              states: widget.states,
              dataset: widget.dataset,
              forPlay: widget.forPlay,
            );
          },

          value: flag,
          mouseCursor: const FCursor().get(),
          fillColor:
              MaterialStateProperty.resolveWith((states) => Colors.black),
          //shape:
        ),
      ),
    );
  }
}
