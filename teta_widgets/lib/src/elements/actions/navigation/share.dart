// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';
import 'package:teta_widgets/src/elements/index.dart';
import 'package:teta_widgets/src/elements/packages.dart';
import 'package:teta_front_end/teta_front_end.dart';

class FActionNavigationShare {
  //list of packages needed for this action
  static List<PackageModel> packages = [pUrlLauncher];

  static Future action({
    required final BuildContext context,
  }) async {
    await showDialog<void>(
      context: context,
      builder: (final context) {
        return AlertDialog(
          title: const TAlertTitle('Share'),
          backgroundColor: Palette.bgDialog,
          content: const TParagraph(
            'Share panel will be activated in your released app.',
          ),
        );
      },
    );
  }

  static String toCode(
    final FTextTypeInput value,
    final int loop,
  ) {
    final code = value.toCode(
      loop,
      resultType: ResultTypeEnum.string,
    );
    return '''
    await Share.share($code);
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
