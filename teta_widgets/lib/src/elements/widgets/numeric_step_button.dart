// Flutter imports:
// ignore_for_file: public_member_api_docs, sort_constructors_first, use_key_in_widget_constructors, lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:teta_core/teta_core.dart';

class WNumericStepButton extends StatefulWidget {
  final CNode node;
  final String? nid;
  final String? parent;
  final bool forPlay;
  final double? index;
  final String? component;
  final int? loop;

  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

  const WNumericStepButton({
    required this.node,
    this.nid,
    this.parent,
    required this.forPlay,
    this.index,
    this.component,
    this.loop,
    required this.params,
    required this.states,
    required this.dataset,
  });

  @override
  _WNumericStepButtonState createState() => _WNumericStepButtonState();
}

class _WNumericStepButtonState extends State<WNumericStepButton> {
  int counter = 0;
  int maxValue = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NodeSelectionBuilder(
      node: widget.node,
      forPlay: widget.forPlay,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: Icon(
              Icons.remove,
              color: Theme.of(context).colorScheme.secondary,
            ),
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 18),
            iconSize: 32,
            color: Theme.of(context).primaryColor,
            onPressed: () {},
          ),
          Text(
            '$counter',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.add,
              color: Theme.of(context).colorScheme.secondary,
            ),
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 18),
            iconSize: 32,
            color: Theme.of(context).primaryColor,
            onPressed: () {
              setState(() {
                if (counter < maxValue) {
                  counter++;
                }
              });
            },
          ),
        ],
      ),
    );
  }
}
