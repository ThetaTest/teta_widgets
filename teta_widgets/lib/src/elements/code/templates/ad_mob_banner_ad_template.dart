// Flutter imports:

import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Code Template of Text Node

class AdMobBannerAdTemplate {
  static String textCodeTemplate(
    final BuildContext context,
    final NodeBody body,
    final int? loop,
  ) {
    final androidKey =
        (body.attributes[DBKeys.adMobAdAndroidUnitId] as FTextTypeInput)
            .toCode(loop);

    final iosKey = (body.attributes[DBKeys.adMobAdIosUnitId] as FTextTypeInput)
        .toCode(loop);

    return '''
      FutureBuilder<BannerAd>(
        future: Future.delayed(Duration(milliseconds: 0), () async {
          final ad = BannerAd(
            request: const AdRequest(),
            adUnitId: Platform.isIOS
                ? $iosKey
                : $androidKey,
            listener: const BannerAdListener(),
            size: AdSize.fluid,
          );
          await ad.load();
          return ad;
        }),
        builder: (context, ad) {
          if (ad.data == null) {
            return Container();
          }
          return AdWidget(
            ad: ad.data!,
          );
        },
      )
  ''';
  }
}
