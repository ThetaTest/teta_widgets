// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';
import 'package:teta_widgets/src/elements/index.dart';
import 'package:teta_widgets/src/elements/packages.dart';
// Package imports:
import 'package:url_launcher/url_launcher_string.dart';
import 'package:teta_models/teta_models.dart';

class FActionNavigationLaunchURL {
  //list of packages needed for this action
  static List<PackageModel> packages = [pUrlLauncher];

  static Future action({
    required final BuildContext context,
    required final TetaWidgetState state,
    required final FTextTypeInput value,
  }) async {
    final valueCode = value.get(
      state.params,
      state.states,
      state.dataset,
      true,
      state.loop,
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
    final code = value.toCode(
      loop,
      resultType: ResultTypeEnum.string,
      defaultValue: '',
    );
    print(code);
    return '''
    if (await canLaunchUrlString($code)) {
      await launchUrlString(
        $code,
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
