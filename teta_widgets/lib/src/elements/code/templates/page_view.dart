// Flutter imports:
import 'package:flutter/material.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/index.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Generates the code for PageView widget
class PageViewCodeTemplate {
  static Future<String> toCode(
    final BuildContext context,
    final int pageId,
    final NodeBody body,
    final CNode node,
    final List<CNode> children,
    final int? loop,
  ) async {
    final _scrollDirection =
        !(body.attributes[DBKeys.isVertical] as bool? ?? false)
            ? 'scrollDirection: Axis.horizontal,'
            : 'scrollDirection: Axis.vertical,';
    final childrenString = await CS.children(
      context,
      children,
      withComma: false,
    );
    final code = '''
    PageView.builder(
      $_scrollDirection   
      ${CS.action(
      pageId,
      context,
      node,
      ActionGesture.onChange,
      'onPageChanged: (index) async',
      null,
      isRequired: false,
      loop: loop,
    )}  
    itemCount: ${children.length},
      ${childrenString.replaceFirst('children:', 'itemBuilder: (final context, final index) =>')}[index]
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
