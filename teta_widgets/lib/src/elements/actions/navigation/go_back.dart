// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';
import 'package:universal_platform/universal_platform.dart';

class FActionNavigationGoBack {
  static Future action(final BuildContext context) async {
    if (UniversalPlatform.isWeb) {
      final uri = Uri.base;
      if (uri.toString().contains('/editor/')) {
        return;
      }
    }
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  static String toCode() {
    return '''Navigator.of(context, rootNavigator: true).pop(null);''';
  }

  static void testActionCode() {
    group('GoBack Action ToCode Test', () {
      test(
        'GoBack',
        () {
          expect(
            FormatterTest.format('''
         GestureDetector(
           onTap: () async {
              ${toCode()}
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
