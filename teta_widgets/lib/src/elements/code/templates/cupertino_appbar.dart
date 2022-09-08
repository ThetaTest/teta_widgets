// Flutter imports:
import 'package:flutter/material.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';
// Project imports:
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/features/fill.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Cupertino AppBar Template. unclassified for now
class CupertinoAppBarCodeTemplate {
  static Future<String> toCode(
    final BuildContext context,
    final NodeBody body,
  ) async {
    final fill = (body.attributes[DBKeys.fill] as FFill).getHexColor(context);

    final code = '''
    CupertinoAppBar(
      backgroundColor: HexColor(
              Color(0xFF$fill),
              ),
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
