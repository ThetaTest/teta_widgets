// Flutter imports:
import 'package:flutter/material.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';
// Project imports:
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Generates the code for Padding widget
class SupabaseFutureBuilderCodeTemplate {
  static Future<String> toCode(
    final BuildContext context,
    final NodeBody body,
    final List<CNode> children,
    final int? loop,
  ) async {
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
        (body.attributes[DBKeys.supabaseToRange] as FTextTypeInput)
            .toCode(loop);
    final rangeTo =
        int.tryParse(valueRangeTo) != null ? int.parse(valueRangeTo) : 15;

    final numberPage =
        (body.attributes[DBKeys.supabaseNumberPage] as FTextTypeInput)
            .toCode(loop);

    var child = 'const SizedBox()';
    if (children.isNotEmpty) {
      child = await children.first.toCode(context);
    }
    var loader = 'const CircularProgressIndicator()';
    if (children.length >= 2) {
      loader = await children[1].toCode(context);
    }
    const func = '''
  final doc = snapshot.data as PostgrestResponse?;
  if (doc == null) return const SizedBox();
  
  final datasets = this.datasets;
  datasets['Supabase future builder'] = doc.data as List<dynamic>? ?? <dynamic>[];
  ''';

    final code = '''
  FutureBuilder(
    future: Supabase.instance.client
    .from($from)
    .select($select)
    .order($order)
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
