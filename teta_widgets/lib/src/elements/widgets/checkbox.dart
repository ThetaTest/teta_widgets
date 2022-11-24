// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

// ignore_for_file: public_member_api_docs

class WCheckBox extends StatefulWidget {
  /// Returns a CheckBox widget in Teta
  const WCheckBox(
    final Key? key, {
    required this.state,
    required this.value,
  }) : super(key: key);

  final TetaWidgetState state;
  final FTextTypeInput value;

  @override
  State<WCheckBox> createState() => _WCheckBoxState();
}

class _WCheckBoxState extends State<WCheckBox> {
  String val = 'false';

  @override
  void initState() {
    super.initState();
    val = widget.value.get(
      widget.state.params,
      widget.state.states,
      widget.state.dataset,
      widget.state.forPlay,
      widget.state.loop,
      context,
    );
  }

  // bool flag = false;
  @override
  Widget build(final BuildContext context) {
    return NodeSelectionBuilder(
      node: widget.state.node,
      forPlay: widget.state.forPlay,
      child: Checkbox(
        onChanged: (final value) {
          if (widget.state.forPlay) {
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
        fillColor: MaterialStateProperty.resolveWith((final states) => Colors.black),
      ),
    );
  }
}
