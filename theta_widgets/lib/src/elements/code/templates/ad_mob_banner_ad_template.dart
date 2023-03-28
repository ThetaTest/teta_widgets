// Flutter imports:

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:teta_core/teta_core.dart';
import 'package:theta_widgets/src/elements/code/formatter_test.dart';
// Project imports:
import 'package:theta_widgets/src/elements/controls/key_constants.dart';
import 'package:theta_widgets/src/elements/index.dart';
import 'package:theta_widgets/src/elements/nodes/node_body.dart';
import 'package:universal_platform/universal_platform.dart';

/// Code Template of Text Node

class AdMobBannerAdTemplate {
  static Future<String> toCode(
    final BuildContext context,
    final NodeBody body,
    final int? loop,
  ) async {
    final androidKey =
        (body.attributes[DBKeys.adMobAdAndroidUnitId] as FTextTypeInput).toCode(
      loop,
      resultType: ResultTypeEnum.string,
    );

    final iosKey =
        (body.attributes[DBKeys.adMobAdIosUnitId] as FTextTypeInput).toCode(
      loop,
      resultType: ResultTypeEnum.string,
    );

    final code = '''
      FutureBuilder<BannerAd>(
        future: Future.delayed(Duration(milliseconds: 0), () async {
          final ad = BannerAd(
            request: const AdRequest(),
            adUnitId: UniversalPlatform.isIOS
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
      final code = await toCode(
        context,
        NodeBody.get(NType.adMobBanner),
        0,
      );
      final res = FormatterTest.format(code);
      if (res) {
        return code;
      } else {
        return 'const SizedBox()';
      }
    }
  }

  static Future<bool> runtimeTestDefaultCode(
    final BuildContext context,
  ) async {
    const name = 'AdMobBanner';
    final nodeBody = NodeBody.get(NType.adMobBanner);
    final codeToRun = await toCode(
      context,
      nodeBody,
      null,
    );
    final returnValue = FormatterTest.format(
      codeToRun,
    );
    if (!returnValue) {
      Logger.printError(
        'Runtime ToCode Default Error:\n$name\nThis was the code:\n',
      );
      Logger.printWarning(codeToRun);
      Logger.printMessage('\n-----------END-----------');
    } else {
      Logger.printSuccess('$name: Passed!');
    }
    return returnValue;
  }

  static void testCode() {
    group('AdMob toCode test', () {
      test(
        'Text Value',
        () {
          final androidKey = FTextTypeInput(value: 'xxx').toCode(
            0,
            resultType: ResultTypeEnum.string,
          );
          final iosKey = FTextTypeInput(value: 'xxx').toCode(
            0,
            resultType: ResultTypeEnum.string,
          );
          expect(
            FormatterTest.format(
              '''
      FutureBuilder<BannerAd>(
        future: Future.delayed(Duration(milliseconds: 0), () async {
          final ad = BannerAd(
            request: const AdRequest(),
            adUnitId: UniversalPlatform.isIOS
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
                  .toCode(
            0,
            resultType: ResultTypeEnum.string,
          );
          final iosKey =
              FTextTypeInput(stateName: 'state', type: FTextTypeEnum.state)
                  .toCode(
            0,
            resultType: ResultTypeEnum.string,
          );
          expect(
            FormatterTest.format(
              '''
FutureBuilder<BannerAd>(
        future: Future.delayed(Duration(milliseconds: 0), () async {
          final ad = BannerAd(
            request: const AdRequest(),
            adUnitId: UniversalPlatform.isIOS
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
                  .toCode(
            0,
            resultType: ResultTypeEnum.string,
          );
          final iosKey =
              FTextTypeInput(paramName: 'param', type: FTextTypeEnum.param)
                  .toCode(
            0,
            resultType: ResultTypeEnum.string,
          );
          expect(
            FormatterTest.format(
              '''
FutureBuilder<BannerAd>(
        future: Future.delayed(Duration(milliseconds: 0), () async {
          final ad = BannerAd(
            request: const AdRequest(),
            adUnitId: UniversalPlatform.isIOS
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
          ).toCode(
            0,
            resultType: ResultTypeEnum.string,
          );
          final iosKey = FTextTypeInput(
            datasetName: 'xxx',
            datasetAttr: 'yyy',
            type: FTextTypeEnum.dataset,
          ).toCode(
            0,
            resultType: ResultTypeEnum.string,
          );
          expect(
            FormatterTest.format(
              '''
FutureBuilder<BannerAd>(
        future: Future.delayed(Duration(milliseconds: 0), () async {
          final ad = BannerAd(
            request: const AdRequest(),
            adUnitId: UniversalPlatform.isIOS
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

  Widget example() {
    final datasets = <String, dynamic>{};
    const index = 0;
    return Text(
      UniversalPlatform.isIOS
          ? (datasets['xxx']?[index]?['yyy']?.toString() ?? '')
          : (datasets['xxx']?[index]?['yyy']?.toString() ?? ''),
    );
  }
}
