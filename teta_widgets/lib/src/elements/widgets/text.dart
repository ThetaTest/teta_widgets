// Flutter imports:
// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:teta_core/teta_core.dart';

class WText extends StatelessWidget {
  /// Returns a Text widget in Teta
  const WText({
    Key? key,
    required this.value,
    required this.node,
    required this.textStyle,
    this.nid,
    required this.forPlay,
    required this.isFullWidth,
    this.component,
    this.loop,
    this.index,
    required this.params,
    required this.states,
    required this.dataset,
    required this.maxLines,
  }) : super(key: key);

  final CNode node;
  final String? nid;
  final FTextTypeInput value;
  final FTextStyle textStyle;
  final bool forPlay;
  final int? loop;
  final bool isFullWidth;
  final double? index;
  final String? component;
  final FTextTypeInput maxLines;

  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

  @override
  Widget build(BuildContext context) {
    return NodeSelectionBuilder(
      node: node,
      forPlay: forPlay,
      child: isFullWidth
          ? SizedBox(
              width: double.maxFinite,
              child: TextBuilder(
                textStyle: textStyle,
                value: value,
                maxLines: maxLines,
                params: params,
                states: states,
                dataset: dataset,
                forPlay: forPlay,
                loop: loop,
              ),
            )
          : TextBuilder(
              textStyle: textStyle,
              value: value,
              maxLines: maxLines,
              params: params,
              states: states,
              dataset: dataset,
              forPlay: forPlay,
              loop: loop,
            ),
    );
  }
}
