// Flutter imports:
// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
// Package imports:
import 'package:lottie/lottie.dart';
// Project imports:
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/index.dart';

class WLottie extends StatelessWidget {
  const WLottie({
    Key? key,
    required this.image,
    required this.node,
    required this.width,
    required this.height,
    required this.boxFit,
    this.nid,
    required this.forPlay,
    this.index,
    this.component,
    this.loop,
    required this.params,
    required this.states,
    required this.dataset,
  }) : super(key: key);

  final CNode node;
  final String? nid;
  final FSize width;
  final FSize height;
  final FTextTypeInput image;
  final FBoxFit boxFit;
  final bool forPlay;
  final double? index;
  final String? component;
  final int? loop;

  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

  @override
  Widget build(BuildContext context) {
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
