// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';
// Project imports:
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_widgets/src/elements/nodes/dynamic.dart';
import 'package:teta_widgets/src/elements/nodes/enum.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Generates the code for CMS custom query widget
class CmsCustomQueryCodeTemplate {
  static Future<String> toCode(
    final BuildContext context,
    final NDynamic node,
    final List<CNode> children,
    final int? loop,
  ) async {
    final query = (node.body.attributes[DBKeys.value] as FTextTypeInput).toCode(
      loop,
      resultType: ResultTypeEnum.string,
    );

    var child = 'const SizedBox()';
    if (children.isNotEmpty) {
      child = await children.first.toCode(context);
    }
    var loader = 'const Center(child: CircularProgressIndicator(),)';
    if (children.length >= 2) {
      loader = await children[1].toCode(context);
    }
    final func = '''
  final list = (snapshot.data as TetaResponse?)?.data as List<dynamic>? ?? <dynamic>[];
  datasets['${node.name ?? node.intrinsicState.displayName}'] = list ?? const <dynamic>[];
  ''';

    final code = '''
  TetaFutureBuilder(
    future: TetaCMS.instance.client.query(
      $query,
    ),
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

  static void testCode() {
    group('Cms Custom Query toCode test', () {
      test(
        'Cms Custom Query: default',
        () {
          final body = NodeBody.get(NType.cmsCustomQuery);
          final query =
              (body.attributes[DBKeys.value] as FTextTypeInput).toCode(
            0,
            resultType: ResultTypeEnum.string,
          );

          const child = 'const SizedBox()';

          const loader = 'const Center(child: CircularProgressIndicator(),)';

          const func = '''
             final list = (snapshot.data as TetaResponse?)?.data as List<dynamic>? ?? <dynamic>[];
             datasets[''] = list ?? const <dynamic>[];
            ''';

          expect(
            FormatterTest.format('''
            TetaFutureBuilder(
    future: TetaCMS.instance.client.query(
      $query,
    ),
    builder: (context, snapshot) {
      if (!snapshot.hasData) {
        return $loader;
      }
      $func
      return $child;
    }
  )
            '''),
            true,
          );
        },
      );
    });
  }
}
