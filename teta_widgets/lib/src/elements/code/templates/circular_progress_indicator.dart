// Flutter imports:
import 'package:flutter/material.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';
// Project imports:
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/features/fill.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// CircularProgressIndicator Template
Future<String> circularProgressIndicatorCodeTemplate(
  final BuildContext context,
  final NodeBody body,
  final int? loop,
) async {
  final fill = FFill.toCode(
    body.attributes[DBKeys.fill] as FFill,
    context,
    flagConst: false,
  );
  final code = '''
    CircularProgressIndicator(
      ${fill!.replaceAll('color:', 'valueColor: AlwaysStoppedAnimation<Color>(')}),
    )
  ''';
  final res = FormatterTest.format(code);
  if (res) {
    return code;
  } else {
    return 'const SizedBox()';
  }
}
