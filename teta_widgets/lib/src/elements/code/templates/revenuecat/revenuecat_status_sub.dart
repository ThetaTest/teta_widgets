// Flutter imports:
// ignore_for_file: lines_longer_than_80_chars

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/index.dart';
import 'package:teta_widgets/src/elements/nodes/dynamic.dart';
// Project imports:

/// Generates the code for RevenueCat product list widget, unclassified for now
class RevenueCatSubsStatusCodeTemplate {
  static Future<String> toCode(
    final BuildContext context,
    final NDynamic node,
    final CNode? child,
    final int? loop,
  ) async {
    var childString = 'const SizedBox()';
    if (child != null) {
      childString = await child.toCode(context);
    }

    final entitlement =
        (node.body.attributes[DBKeys.value] as FTextTypeInput).toCode(
      loop,
      resultType: ResultTypeEnum.string,
    );

    final code = '''
  TetaFutureBuilder<bool>(
    future: Future<bool>.sync(() async {
      if (UniversalPlatform.isAndroid ||
        UniversalPlatform.isIOS ||
        UniversalPlatform.isMacOS) {
        try {
          final res = await Purchases.getPurchaserInfo();
          return res.entitlements.all[$entitlement]?.isActive ?? false;
        } catch (e) {
          // Error fetching purchaser info
        }
      }
      return false;
    }),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        final flag = snapshot.data as bool? ?? false;
        datasets['${node.name ?? node.intrinsicState.displayName}'] = <String, dynamic>{
          'isActive': flag,
        };
        return $childString;
      } else {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
    }
  )
  ''';
    final res = FormatterTest.format(code);
    if (res) {
      return code;
    } else {
      return 'const SizedBox()';
    }
  }

  static void testCode() {}
}
