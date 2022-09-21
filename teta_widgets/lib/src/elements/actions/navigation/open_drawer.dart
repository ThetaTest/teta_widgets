// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';

class FActionNavigationOpenDrawer {
  static Future action(final BuildContext context) async {
    print(Scaffold.of(context).hasDrawer);
    if (!Scaffold.of(context).isDrawerOpen) Scaffold.of(context).openDrawer();
  }

  static String toCode() {
    return '''
    if (_scaffoldKey.currentState != null) {
      _scaffoldKey.currentState!.openDrawer();
    }
    ''';
  }

  static void testActionCode() {
    group('Open Drawer Action ToCode Test', () {
      test(
        'Open Drawer',
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
