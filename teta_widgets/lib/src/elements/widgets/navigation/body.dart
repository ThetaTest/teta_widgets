/*import 'package:flutter/material.dart';

// Package imports:
import 'package:mobile_editor/src/design_system/palette.dart';
import 'package:mobile_editor/src/design_system/text.dart';
import 'package:mobile_editor/src/elements/builder/node_selection.dart';
import 'package:mobile_editor/src/elements/nodes/node.dart';
import 'package:mobile_editor/src/models/dataset.dart';
import 'package:mobile_editor/src/models/variable.dart';

// ignore_for_file: public_member_api_docs

class WBody extends StatefulWidget {
  final CNode node;
  final List<CNode> children;
  final bool forPlay;
  final int? loop;
  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

  WBody({
    required this.children,
    required this.node,
    required this.forPlay,
    this.loop,
    required this.params,
    required this.states,
    required this.dataset,
  });

  @override
  _WBodyState createState() => _WBodyState();
}

class _WBodyState extends State<WBody> {
  @override
  Widget build(BuildContext context) {
    return NodeSelectionBuilder(
      node: node,
      forPlay: forPlay,
      child: body(context));
  }

  Widget body(BuildContext context) {
    return Column(
      children: widget.children.length > 0
          ? widget.children
              .map(
                (e) => e.toWidget(
                  loop: widget.loop,
                  forPlay: widget.forPlay,
                  params: widget.params,
                  states: widget.states,
                  dataset: widget.dataset,
                ),
              )
              .toList()
          : [
              Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CText(
                      'Column',
                      size: 16,
                      color: Palette.black,
                    ),
                  ],
                ),
              )
            ],
    );
  }
}
*/
