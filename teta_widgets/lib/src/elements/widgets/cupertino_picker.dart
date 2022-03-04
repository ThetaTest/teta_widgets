// Flutter imports:
// ignore_for_file: public_member_api_docs

import 'package:flutter/cupertino.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/index.dart';

class WCupertinoPicker extends StatefulWidget {
  /// Returns a Gesture Detector
  const WCupertinoPicker(
    Key? key, {
    required this.children,
    required this.node,
    required this.height,
    required this.flag,
    required this.forPlay,
    required this.action,
    required this.params,
    required this.states,
    required this.dataset,
    this.loop,
  }) : super(key: key);

  final CNode node;
  final List<CNode> children;
  final bool forPlay;
  final int? loop;
  final FAction action;
  final FSize height;
  final bool flag;
  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

  @override
  State<WCupertinoPicker> createState() => _WCupertinoPickerState();
}

class _WCupertinoPickerState extends State<WCupertinoPicker> {
  bool flag = false;

  @override
  Widget build(BuildContext context) {
    return NodeSelectionBuilder(
      node: widget.node,
      forPlay: widget.forPlay,
      child: CupertinoPicker(
        itemExtent: widget.height.get(context: context, isWidth: false) ?? 44,
        onSelectedItemChanged: (index) {
          GestureBuilder.get(
            context: context,
            node: widget.node,
            action: widget.action,
            actionValue: null,
            gesture: ActionGesture.onChange,
            params: widget.params,
            states: widget.states,
            dataset: widget.dataset,
            forPlay: widget.forPlay,
          );
        },
        looping: flag,
        children: widget.children
            .map(
              (e) => e.toWidget(
                params: widget.params,
                states: widget.states,
                dataset: widget.dataset,
                forPlay: widget.forPlay,
              ),
            )
            .toList(),
      ),
    );
  }
}
