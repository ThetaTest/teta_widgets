// Flutter imports:
import 'package:flutter/material.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/features/fill.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Generates the code for FontAwesomeIcon widget
Future<String> iconFontAwesomeCodeTemplate(
  final BuildContext context,
  final NodeBody body,
  final CNode node,
  final CNode? child,
  final int? loop,
) async {
  final icon = node.body.attributes[DBKeys.faIcon] as String;
  final fill = FFill.toCode(
    node.body.attributes[DBKeys.fill] as FFill,
    context,
    flagConst: false,
  );
  final code = '''
    Icon (
      faIconNameMapping['$icon'],
      ${CS.size(context, body, isWidth: true).replaceAll('width', 'size')}
      $fill
    )
  ''';
  final res = FormatterTest.format(code);
  if (res) {
    return code;
  } else {
    return 'const SizedBox()';
  }
}
