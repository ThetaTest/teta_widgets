// Flutter imports:
import 'package:flutter/material.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/index.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// PageView Template
Future<String> pageViewCodeTemplate(
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
  final childrenString = await CS.children(context, children);
  final code = '''
    PageView(
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
      $childrenString
    )
  ''';
  final res = FormatterTest.format(code);
  if (res) {
    return code;
  } else {
    return 'const SizedBox()';
  }
}
