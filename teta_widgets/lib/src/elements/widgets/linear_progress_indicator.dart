// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:teta_core/teta_core.dart';

// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

// ignore_for_file: public_member_api_docs

class WLinearProgressIndicator extends StatelessWidget {
  /// Returns a [Center] widget in Teta
  const WLinearProgressIndicator(
    Key? key, {
    required this.node,
    required this.forPlay,
    required this.params,
    required this.states,
    required this.dataset,
    required this.fill,
    required this.background,
    this.loop,
  }) : super(key: key);

  final CNode node;
  final bool forPlay;
  final int? loop;

  final FFill fill;
  final FFill background;

  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

  @override
  Widget build(BuildContext context) {
    return NodeSelectionBuilder(
      node: node,
      forPlay: forPlay,
      child: LinearProgressIndicator(
        backgroundColor: HexColor(background.getHexColor(context)),
        valueColor: AlwaysStoppedAnimation<Color>(
          HexColor(fill.getHexColor(context)),
        ),
      ),
    );
  }
}
