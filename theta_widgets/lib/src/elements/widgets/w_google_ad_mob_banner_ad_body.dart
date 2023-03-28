// ignore_for_file: public_member_api_docs
// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
// Project imports:
import 'package:theta_widgets/src/core/teta_widget/index.dart';
import 'package:theta_widgets/src/elements/index.dart';

class WGoogleAdMobBannerAd extends StatelessWidget {
  /// Returns a widget in Teta
  const WGoogleAdMobBannerAd(
    final Key? key, {
    required this.adMobAdIosUnitId,
    required this.adMobAdAndroidUnitId,
    required this.state,
  }) : super(key: key);

  final TetaWidgetState state;
  final FTextTypeInput adMobAdIosUnitId;
  final FTextTypeInput adMobAdAndroidUnitId;

  @override
  Widget build(final BuildContext context) {
    return TetaWidget(
      state: state,
      child: const SizedBox(
        width: double.maxFinite,
        child: Center(
          child: Text(
            'Here will be you ad.',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
