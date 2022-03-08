// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:lottie/lottie.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

class WLottie extends StatelessWidget {
  const WLottie(
    final Key? key, {
    required this.image,
    required this.node,
    required this.width,
    required this.height,
    required this.boxFit,
    required this.forPlay,
    required this.params,
    required this.states,
    required this.dataset,
    this.loop,
  }) : super(key: key);

  final CNode node;
  final FSize width;
  final FSize height;
  final FTextTypeInput image;
  final FBoxFit boxFit;
  final bool forPlay;
  final int? loop;

  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

  @override
  Widget build(final BuildContext context) {
    return NodeSelectionBuilder(
      node: node,
      forPlay: forPlay,
      child: Lottie.network(
        image.value != null
            ? image.value!
            : 'https://assets10.lottiefiles.com/packages/lf20_ptplezpy.json',
        width: width.get(context: context, isWidth: true),
        height: height.get(context: context, isWidth: false),
        fit: BoxFit.contain,
      ),
    );
  }
}
