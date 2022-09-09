// Flutter imports:
import 'package:flutter/material.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';
// Project imports:
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_widgets/src/elements/nodes/dynamic.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';

/// Generates the code for CMS Stream widget
class CmsStreamCodeTemplate {
  static Future<String> toCode(
    final BuildContext context,
    final NDynamic node,
    final List<CNode> children,
    final int? loop,
  ) async {
    var collectionId =
        (node.body.attributes[DBKeys.cmsCollection] as FTextTypeInput)
            .toCode(loop);
    if (!collectionId.contains("'")) {
      collectionId = "'$collectionId'";
    }
    final limit = (node.body.attributes[DBKeys.cmsLimit] as FTextTypeInput)
        .toCode(loop)
        .replaceAll("'''", '');
    final page = (node.body.attributes[DBKeys.cmsPage] as FTextTypeInput)
        .toCode(loop)
        .replaceAll("'''", '');
    var keyName = (node.body.attributes[DBKeys.cmsLikeKey] as FTextTypeInput)
        .toCode(loop);
    if (!keyName.contains("'") && keyName.isNotEmpty) {
      keyName = "'$keyName'";
    }
    var keyValue = (node.body.attributes[DBKeys.cmsLikeValue] as FTextTypeInput)
        .toCode(loop);
    if (!keyValue.contains("'") && keyValue.isNotEmpty) {
      keyValue = "'$keyValue'";
    }
    final filter = keyName.isNotEmpty && keyValue.isNotEmpty
        ? 'Filter($keyName, $keyValue)'
        : '';

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
  TetaStreamBuilder(
    stream: TetaCMS.instance.realtime.streamCollection(
      $collectionId,
      filters: [
        $filter
      ], 
      ${limit.isNotEmpty ? 'limit: $limit,' : ''}
      ${page.isNotEmpty ? 'page: $page,' : ''}
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

  static void testCode() {}
}
