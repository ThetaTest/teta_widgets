import 'package:flutter/material.dart';
import 'package:theta_widgets/src/elements/code/formatter_test.dart';
import 'package:theta_widgets/src/elements/controls/key_constants.dart';
import 'package:theta_widgets/src/elements/features/features.dart';
import '../../../../../../../teta_open_classes/lib/src/nodes/node.dart';
import '../../../../../../../teta_open_classes/lib/src/nodes/node_body.dart';

class GapCodeTemplate {
  static Future<String> toCode(
    final BuildContext context,
    final NodeBody body,
    final CNode? child,
  ) async {
    return '';
    final mainAxisExpanded = body.attributes[DBKeys.mainAxisExtend] as FSize;
    final crossAxisExpanded = body.attributes[DBKeys.mainAxisExtend] as FSize;

    late String code;

    if (!(body.attributes[DBKeys.isExpandedGap] as bool)) {
      code = '''
      Gap(
        ${mainAxisExpanded.get(
        context: context,
        isWidth: true,
        forPlay: false,
      )},
        crossAxisExtent: ${crossAxisExpanded.toCode(context: context, isWidth: true)},
      )
    ''';
    } else {
      code = '''
      Gap.expand(
        ${mainAxisExpanded.get(
        context: context,
        isWidth: true,
        forPlay: false,
      )}
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
