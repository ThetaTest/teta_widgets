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
    final Key? key, {
    required this.node,
    required this.forPlay,
    required this.value,
    required this.params,
    required this.states,
    required this.dataset,
    this.loop,
  }) : super(key: key);

  final CNode node;
  final bool forPlay;
  final int? loop;
  final FTextTypeInput value;

  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

  @override
  State<WCheckBox> createState() => _WCheckBoxState();
}

class _WCheckBoxState extends State<WCheckBox> {
  String val = 'false';

  @override
  void initState() {
    super.initState();
    val = widget.value.get(
      widget.params,
      widget.states,
      widget.dataset,
      widget.forPlay,
      widget.loop,
      context,
    );
  }

  // bool flag = false;
  @override
  Widget build(final BuildContext context) {
    return NodeSelectionBuilder(
      node: widget.node,
      forPlay: widget.forPlay,
      child: Checkbox(
        onChanged: (final value) {
          if (widget.forPlay) {
            setState(() {
              if (val == 'true') {
                val = 'false';
              } else {
                val = 'true';
              }
            });
          }
        },
        value: val == 'true',
        mouseCursor: const FCursor().get(),
        fillColor:
            MaterialStateProperty.resolveWith((final states) => Colors.black),
      ),
    );
  }
}
