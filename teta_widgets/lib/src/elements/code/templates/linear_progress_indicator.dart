// Flutter imports:
import 'package:flutter/material.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';
// Project imports:
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/features/fill.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// LinearProgressIndicator Template
class LinearProgressIndicatorCodeTemplate {
  static Future<String> toCode(
    final BuildContext context,
    final NodeBody body,
    final int? loop,
  ) async {
    final colorFill = body.attributes[DBKeys.fill] as FFill;
    final hex1 = colorFill.getHexColor(context);
    final colorBgFill = body.attributes[DBKeys.bgFill] as FFill;
    final hex2 = colorBgFill.getHexColor(context);

    final tempOpacity = colorBgFill.levels?.first.opacity ?? 1;
    final colorBGOpacity =
        tempOpacity >= 0 && tempOpacity <= 1 ? tempOpacity : 1.0;

    final tempColorOpacity = colorFill.levels?.first.opacity ?? 1;
    final colorOpacity =
        tempColorOpacity >= 0 && tempColorOpacity <= 1 ? tempColorOpacity : 1.0;

    final code = '''
    LinearProgressIndicator(
      backgroundColor: Color(0xFF$hex2).withOpacity($colorBGOpacity), 
      valueColor: AlwaysStoppedAnimation<Color>(
              Color(0xFF$hex1).withOpacity($colorOpacity)),
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
