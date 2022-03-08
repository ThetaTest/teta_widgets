// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

class WText extends StatelessWidget {
  /// Returns a Text widget in Teta
  const WText(
    final Key? key, {
    required this.value,
    required this.node,
    required this.textStyle,
    required this.forPlay,
    required this.isFullWidth,
    required this.params,
    required this.states,
    required this.dataset,
    required this.maxLines,
    this.loop,
  }) : super(key: key);

  final CNode node;
  final FTextTypeInput value;
  final FTextStyle textStyle;
  final bool forPlay;
  final int? loop;
  final bool isFullWidth;
  final FTextTypeInput maxLines;

  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

  @override
  Widget build(final BuildContext context) {
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
