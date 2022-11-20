// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_widgets/src/elements/builder/gesture_detector_base.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';
import 'package:teta_widgets/src/core/teta_widget/teta_widget_state.dart';

class WGoogleAdMobBannerAd extends StatelessWidget {
  /// Returns a widget in Teta
  const WGoogleAdMobBannerAd(
    final Key? key, {
    required this.adMobAdIosUnitId,
    required this.adMobAdAndroidUnitId,
    required this.state,
  }) : super(key: key);

  final FTextTypeInput adMobAdIosUnitId;
  final FTextTypeInput adMobAdAndroidUnitId;

  final TetaWidgetState state;

  @override
  Widget build(final BuildContext context) {
    return NodeSelectionBuilder(
      node: state.node,
      forPlay: state.forPlay,
      child: GestureBuilderBase.get(
        context: context,
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
      ),
    );
  }
}
