// Flutter imports:
import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

class WebViewXTemplate {
  static String toCode({required final String initialUrl}) {
    return '''
LayoutBuilder(builder: (context, constraints) {
      return WebViewX(
        initialContent: '$initialUrl',
        initialSourceType: SourceType.url,
        width: constraints.maxWidth,
        height: constraints.maxHeight,
      );
    })
  ''';
  }
}