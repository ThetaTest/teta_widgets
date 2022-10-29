// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
// Project imports:
import 'package:teta_widgets/src/elements/nodes/dynamic.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';

/// Generates the code for Custom Http Request widget
class CustomHttpRequestCodeTemplate {
  static Future<String> toCode(
    final BuildContext context,
    final NDynamic node,
    final List<CNode> children,
    final int? loop,
  ) async {
    final url =
        (node.body.attributes[DBKeys.customHttpRequestURL] as FTextTypeInput)
            .toCode(
              loop,
              resultType: ResultTypeEnum.string,
            )
            .replaceAll("'", '');
    var child = 'const SizedBox()';
    if (children.isNotEmpty) {
      child = await children.first.toCode(context);
    }
    var loader = 'const Center(child: CircularProgressIndicator(),)';
    if (children.length >= 2) {
      loader = await children[1].toCode(context);
    }
    final func = '''
    final list = snapshot.data as List<dynamic>?;
    datasets['${node.name ?? node.intrinsicState.displayName}'] = list ?? const <dynamic>[];
    ''';
    final code = '''
    TetaFutureBuilderHttp(
    url: "$url",
    builder: (context, snapshot) {
      if (!snapshot.hasData) {
        return $loader;
      }
      $func
      return $child;
    }
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
