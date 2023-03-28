// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:theta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:theta_widgets/src/elements/index.dart';

class OText extends StatelessWidget {
  /// Returns a Text widget in Teta
  const OText(
    final Key? key, {
    required this.state,
    required this.value,
    required this.textStyle,
    required this.isFullWidth,
    required this.maxLines,
    this.nid,
    this.component,
    this.index,
  }) : super(key: key);

  final TetaWidgetState state;
  final String? nid;
  final FTextTypeInput value;
  final FTextStyle textStyle;
  final bool isFullWidth;
  final double? index;
  final String? component;
  final FTextTypeInput maxLines;

  @override
  Widget build(final BuildContext context) {
    return isFullWidth
        ? SizedBox(
            width: double.maxFinite,
            child: TextBuilder(
              textStyle: textStyle,
              value: value,
              maxLines: maxLines,
              params: state.params,
              states: state.states,
              dataset: state.dataset,
              forPlay: state.forPlay,
              loop: state.loop,
            ),
          )
        : TextBuilder(
            textStyle: textStyle,
            value: value,
            maxLines: maxLines,
            params: state.params,
            states: state.states,
            dataset: state.dataset,
            forPlay: state.forPlay,
            loop: state.loop,
          );
  }
}
