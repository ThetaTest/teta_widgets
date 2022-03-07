// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Generates the code for Padding widget
String streamBuilderCodeTemplate(
  BuildContext context,
  NodeBody body,
  List<CNode> children,
  int? loop,
) {
  final from =
      (body.attributes[DBKeys.supabaseFrom] as FTextTypeInput).toCode(loop);
  final order =
      (body.attributes[DBKeys.supabaseOrder] as FTextTypeInput).toCode(loop);
  final valueRangeTo =
      (body.attributes[DBKeys.supabaseFromRange] as FTextTypeInput)
          .toCode(loop);
  final rangeTo =
      int.tryParse(valueRangeTo) != null ? int.parse(valueRangeTo) : 15;

  var child = 'const SizedBox();';
  if (children.isNotEmpty) {
    child = CS.child(context, children.first, comma: true).replaceAll(',', '');
  }
  var loader = 'const CircularProgressIndicator();';
  if (children.length >= 2) {
    loader = CS.child(context, children[1], comma: true).replaceAll(',', '');
  }
  return """
    StreamBuilder(
      stream: client
      .from('''$from''')
      .order('''$order''')
      .limit('''$rangeTo''')
      .execute(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return $loader;
        }
        return $child;
      });
    )
  """;
}
