// Flutter imports:
import 'package:flutter/material.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/index.dart';

// ignore_for_file: public_member_api_docs

class WPlaceholder extends StatelessWidget {
  /// Returns a [Center] widget in Teta
  const WPlaceholder(
    Key? key, {
    required this.node,
    required this.forPlay,
    required this.params,
    required this.states,
    required this.dataset,
    required this.value,
    required this.color,
    required this.width,
    required this.height,
    this.child,
    this.loop,
  }) : super(key: key);

  final CNode node;
  final CNode? child;
  final bool forPlay;
  final int? loop;
  final FTextTypeInput value;
  final FFill color;
  final FSize width;
  final FSize height;
  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

  @override
  Widget build(BuildContext context) {
    final val = value.get(params, states, dataset, forPlay, loop);
    return NodeSelectionBuilder(
      node: node,
      forPlay: forPlay,
      child: SizedBox(
        width: width.get(context: context, isWidth: true) ?? 400,
        height: height.get(context: context, isWidth: false) ?? 400,
        child: Placeholder(
          strokeWidth: double.tryParse(val) != null ? double.parse(val) : 2.0,
          color: HexColor(color.getHexColor(context)),
        ),
      ),
    );
  }
}
