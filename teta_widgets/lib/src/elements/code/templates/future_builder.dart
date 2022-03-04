// Flutter imports:
import 'package:flutter/material.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Generates the code for Padding widget
String supabaseFutureBuilderCodeTemplate(
  BuildContext context,
  NodeBody body,
  List<CNode> children,
  int? loop,
) {
  final from =
      (body.attributes[DBKeys.supabaseFrom] as FTextTypeInput).toCode(loop);
  final select =
      (body.attributes[DBKeys.supabaseSelect] as FTextTypeInput).toCode(loop);
  final order =
      (body.attributes[DBKeys.supabaseOrder] as FTextTypeInput).toCode(loop);

  final valueRangeFrom =
      (body.attributes[DBKeys.supabaseFromRange] as FTextTypeInput)
          .toCode(loop);
  final rangeFrom =
      int.tryParse(valueRangeFrom) != null ? int.parse(valueRangeFrom) : 1;

  final valueRangeTo =
      (body.attributes[DBKeys.supabaseToRange] as FTextTypeInput).toCode(loop);
  final rangeTo =
      int.tryParse(valueRangeTo) != null ? int.parse(valueRangeTo) : 15;

  final numberPage =
      (body.attributes[DBKeys.supabaseNumberPage] as FTextTypeInput)
          .toCode(loop);

  var child = 'const SizedBox()';
  if (children.isNotEmpty) {
    child = children.first.toCode(context);
  }
  var loader = 'const CircularProgressIndicator()';
  if (children.length >= 2) {
    loader = children[1].toCode(context);
  }
  const func = '''
  final doc = snapshot.data as PostgrestResponse?;
  if (doc == null) return const SizedBox();
  
  final datasets = this.datasets;
  datasets['Supabase Query'] = doc.data as List<dynamic>? ?? <dynamic>[];
  const index = 0;
  ''';

  return """
  FutureBuilder(
    future: Supabase.instance.client
    .from('''$from''')
    .select('''$select''')
    .order('''$order''')
    .range(($numberPage * $rangeFrom) - 1, $numberPage * $rangeTo)
    .execute(),
    builder: (context, snapshot) {
      if (!snapshot.hasData) {
        return $loader;
      }
      $func
      return $child;
    }
  )
  """;
}
