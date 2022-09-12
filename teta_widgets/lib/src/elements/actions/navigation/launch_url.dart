// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';
import 'package:teta_widgets/src/elements/index.dart';
import 'package:teta_widgets/src/elements/packages.dart';
// Package imports:
import 'package:url_launcher/url_launcher_string.dart';

class FActionNavigationLaunchURL {
  //list of packages needed for this action
  static List<PackageModel> packages = [pUrlLauncher];

  static Future action({
    required final BuildContext context,
    required final List<VariableObject> params,
    required final List<VariableObject> states,
    required final List<DatasetObject> datasets,
    required final FTextTypeInput value,
    required final int loop,
  }) async {
    final valueCode = value.get(
      params,
      states,
      datasets,
      true,
      loop,
      context,
    );
    if (await canLaunchUrlString(valueCode)) {
      await launchUrlString(
        valueCode,
        mode: LaunchMode.inAppWebView,
      );
    }
  }

  static String toCode(
    final FTextTypeInput value,
    final int loop,
  ) {
    final code = value.toCode(loop);

    final str = code.contains(r'${')
        ? code
        : code.contains('this.datasets')
            ? '\${$code}'
            : code;
    return '''
    if (await canLaunchUrlString($str)) {
      await launchUrlString(
        $str,
        mode: LaunchMode.inAppWebView,
      );
    }
    ''';
  }

  static void testActionCode() {
    group('LaunchUrl Action ToCode Test', () {
      test(
        'LaunchUrl',
        () {
          expect(
            FormatterTest.format('''
         GestureDetector(
           onTap: () async {
              ${toCode(FTextTypeInput(value: 'ciao'), 0)}
           },
           child: const SizedBox(),
           )
            '''),
            true,
          );
        },
      );
    });
  }
}
