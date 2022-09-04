// Flutter imports:

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';
// Project imports:
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/index.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Code Template of Text Node

class AdMobBannerAdTemplate {
  static Future<String> toCode(
    final BuildContext context,
    final NodeBody body,
    final int? loop,
  ) async {
    final androidKey =
        (body.attributes[DBKeys.adMobAdAndroidUnitId] as FTextTypeInput)
            .toCode(loop);

    final iosKey = (body.attributes[DBKeys.adMobAdIosUnitId] as FTextTypeInput)
        .toCode(loop);

    final code = '''
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
    final result = FormatterTest.format(code);
    if (result) {
      return code;
    } else {
      return toCode(context, NodeBody.get(NType.adMobBanner), loop);
    }
  }

  static void testCode() {
    group('AdMob toCode test', () {
      test(
        'Text Value',
        () {
          final androidKey = FTextTypeInput(value: 'xxx').toCode(0);
          final iosKey = FTextTypeInput(value: 'xxx').toCode(0);
          expect(
            FormatterTest.format(
              '''
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
  ''',
            ),
            true,
          );
        },
      );
      test(
        'State Value',
        () {
          final androidKey =
              FTextTypeInput(stateName: 'state', type: FTextTypeEnum.state)
                  .toCode(0);
          final iosKey =
              FTextTypeInput(stateName: 'state', type: FTextTypeEnum.state)
                  .toCode(0);
          expect(
            FormatterTest.format(
              '''
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
  ''',
            ),
            true,
          );
        },
      );
      test(
        'Param Value',
        () {
          final androidKey =
              FTextTypeInput(paramName: 'param', type: FTextTypeEnum.param)
                  .toCode(0);
          final iosKey =
              FTextTypeInput(paramName: 'param', type: FTextTypeEnum.param)
                  .toCode(0);
          expect(
            FormatterTest.format(
              '''
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
  ''',
            ),
            true,
          );
        },
      );
      test(
        'Dataset Value',
        () {
          final androidKey = FTextTypeInput(
            datasetName: 'xxx',
            datasetAttr: 'yyy',
            type: FTextTypeEnum.dataset,
          ).toCode(0);
          final iosKey = FTextTypeInput(
            datasetName: 'xxx',
            datasetAttr: 'yyy',
            type: FTextTypeEnum.dataset,
          ).toCode(0);
          expect(
            FormatterTest.format(
              '''
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
  ''',
            ),
            true,
          );
        },
      );
    });
  }
}
