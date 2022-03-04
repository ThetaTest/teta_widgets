// Flutter imports:
import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/index.dart';
// ignore_for_file: public_member_api_docs

class WCheckBox extends StatefulWidget {
  /// Returns a CheckBox widget in Teta
  const WCheckBox({
    Key? key,
    required this.node,
    this.nid,
    this.parent,
    required this.forPlay,
    this.index,
    required this.action,
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
