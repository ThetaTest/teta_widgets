// Flutter imports:
import 'package:flutter/material.dart';
import 'package:theta_widgets/src/elements/code/formatter_test.dart';
// Project imports:
import 'package:theta_widgets/src/elements/code/snippets.dart';
import 'package:theta_widgets/src/elements/controls/key_constants.dart';
import 'package:theta_widgets/src/elements/features/text_type_input.dart';
import '../../../../../../../teta_open_classes/lib/src/nodes/node.dart';
import '../../../../../../../teta_open_classes/lib/src/nodes/node_body.dart';

/// Generates the code for Marker widget
class MarkerCodeTemplate {
  static Future<String> toCode(
    final BuildContext context,
    final NodeBody body,
    final CNode node,
    final CNode? child,
    final int? loop,
  ) async {
    final lat = (body.attributes[DBKeys.latitude] as FTextTypeInput)
        .toCode(loop, resultType: ResultTypeEnum.double, defaultValue: '41.90');

    final lng = (body.attributes[DBKeys.longitude] as FTextTypeInput)
        .toCode(loop, resultType: ResultTypeEnum.double, defaultValue: '12.49');

    final childString = await CS.child(context, child, comma: true);
    final code = '''
  Positioned(
      left: $lat,
      top: $lng,
      child: GestureDetector(
        $childString
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
