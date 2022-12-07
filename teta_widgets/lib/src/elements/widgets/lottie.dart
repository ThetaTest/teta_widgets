// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:lottie/lottie.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

class WLottie extends StatelessWidget {
  const WLottie(
    final Key? key, {
    required this.state,
    required this.image,
    required this.width,
    required this.height,
    required this.boxFit,
  }) : super(key: key);

  final TetaWidgetState state;
  final FSize width;
  final FSize height;
  final FTextTypeInput image;
  final FBoxFit boxFit;
  @override
  Widget build(final BuildContext context) {
    return TetaWidget(
      state: state,
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
