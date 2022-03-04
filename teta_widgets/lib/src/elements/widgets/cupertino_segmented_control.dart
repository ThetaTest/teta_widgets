//CupertinoSegmentedControl

// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/index.dart';

class WCupertinoSegmentedControl extends StatefulWidget {
  /// Returns a Gesture Detector
  const WCupertinoSegmentedControl({
    Key? key,
    required this.children,
    required this.node,
    required this.forPlay,
    required this.pressedColor,
    required this.selectedColor,
    required this.unselectedColor,
    required this.borderColor,
    this.loop,
    required this.action,
    required this.params,
    required this.states,
    required this.dataset,
  }) : super(key: key);

  final CNode node;
  final List<CNode> children;
  final bool forPlay;
  final int? loop;
  final FAction action;
  final FFill pressedColor;
  final FFill selectedColor;
  final FFill unselectedColor;
  final FFill borderColor;
  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

  @override
  State<WCupertinoSegmentedControl> createState() =>
      _WCupertinoSegmentedControlState();
}

class _WCupertinoSegmentedControlState
    extends State<WCupertinoSegmentedControl> {
  int value = 0;
  @override
  Widget build(BuildContext context) {
    final map = <int, Widget>{};
    for (var i = 0; i < widget.children.length; i++) {
      map[i] = widget.children[i].toWidget(
        params: widget.params,
        states: widget.states,
        dataset: widget.dataset,
        forPlay: widget.forPlay,
      );
    }
    if (map.keys.isEmpty) {
      map[0] = Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: const Center(
          child: CText('Option 1'),
        ),
      );
      map[1] = Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: const Center(
          child: CText('Option 2'),
        ),
      );
    }
    return NodeSelectionBuilder(
      node: widget.node,
      forPlay: widget.forPlay,
      child: IgnorePointer(
        ignoring: !widget.forPlay,
        child: CupertinoSegmentedControl<int>(
          children: map,
          groupValue: value,
          pressedColor: HexColor(widget.pressedColor.getHexColor(context)),
          selectedColor: HexColor(widget.selectedColor.getHexColor(context)),
          unselectedColor:
              HexColor(widget.unselectedColor.getHexColor(context)),
          borderColor: HexColor(widget.borderColor.getHexColor(context)),
          onValueChanged: (v) {
            GestureBuilder.get(
              context: context,
              node: widget.node,
              action: widget.action,
              actionValue: FTextTypeInput(value: '$v'),
              gesture: ActionGesture.onTap,
              params: widget.params,
              states: widget.states,
              dataset: widget.dataset,
              forPlay: widget.forPlay,
            );
            setState(() {
              value = v;
            });
          },
        ),
      ),
    );
  }
}
