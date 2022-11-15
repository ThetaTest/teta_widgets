import 'package:flutter/material.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/features/features.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

class GapCodeTemplate {
  static Future<String> toCode(
    final BuildContext context,
    final NodeBody body,
    final CNode? child,
  ) async {
    final mainAxisExpanded = body.attributes[DBKeys.mainAxisExtend] as FSize;
    final crossAxisExpanded = body.attributes[DBKeys.mainAxisExtend] as FSize;

    late String code;

    if (!(body.attributes[DBKeys.isExpandedGap] as bool)) {
      code = '''
      Gap(
        ${mainAxisExpanded.get(context: context, isWidth: true)}
        crossAxisExtent: ${crossAxisExpanded.toCode(context: context, isWidth: true)},
      )
    ''';
    } else {
      code = '''
      Gap.expand(
        ${mainAxisExpanded.get(context: context, isWidth: true)}
      )
    ''';
    }

    final res = FormatterTest.format(code);
    if (res) {
      return code;
    }

    return 'const SizedBox()';
  }
}
