// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';
// Project imports:
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_widgets/src/elements/nodes/enum.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Generates the code for SupabaseFutureBuilder widget
class SupabaseFutureBuilderCodeTemplate {
  static Future<String> toCode(
    final BuildContext context,
    final NodeBody body,
    final List<CNode> children,
    final int? loop,
  ) async {
     final containsName =
        (body.attributes[DBKeys.supabaseContainsName] as FTextTypeInput).toCode(
      loop,
      resultType: ResultTypeEnum.string,
    );
     final containsValue =
        (body.attributes[DBKeys.supabaseContainsValue] as FTextTypeInput).toCode(
      loop,
      resultType: ResultTypeEnum.string,
    );
      final gtName =
        (body.attributes[DBKeys.supabaseGreaterThanName] as FTextTypeInput).toCode(
      loop,
      resultType: ResultTypeEnum.string,
    );
     final gtValue =
        (body.attributes[DBKeys.supabaseGreaterThanValue] as FTextTypeInput).toCode(
      loop,
      resultType: ResultTypeEnum.string,
    );
       final gtEName =
        (body.attributes[DBKeys.supabaseGreaterOrEqualName] as FTextTypeInput).toCode(
      loop,
      resultType: ResultTypeEnum.string,
    );
     final gtEValue =
        (body.attributes[DBKeys.supabaseGreaterOrEqualValue] as FTextTypeInput).toCode(
      loop,
      resultType: ResultTypeEnum.string,
    );
      final ltName =
        (body.attributes[DBKeys.supabaseLessThanName] as FTextTypeInput).toCode(
      loop,
      resultType: ResultTypeEnum.string,
    );
     final ltValue =
        (body.attributes[DBKeys.supabaseLessThanValue] as FTextTypeInput).toCode(
      loop,
      resultType: ResultTypeEnum.string,
    );
       final ltEName =
        (body.attributes[DBKeys.supabaseLessThanOrEqualName] as FTextTypeInput).toCode(
      loop,
      resultType: ResultTypeEnum.string,
    );
     final ltEValue =
        (body.attributes[DBKeys.supabaseLessThanOrEqualValue] as FTextTypeInput).toCode(
      loop,
      resultType: ResultTypeEnum.string,
    );
    final filterName =
        (body.attributes[DBKeys.supabaseFilterName] as FTextTypeInput).toCode(
      loop,
      resultType: ResultTypeEnum.string,
    );
     final filterValue =
        (body.attributes[DBKeys.supabaseFilterValue] as FTextTypeInput).toCode(
      loop,
      resultType: ResultTypeEnum.string,
    );
    final from =
        (body.attributes[DBKeys.supabaseFrom] as FTextTypeInput).toCode(
      loop,
      resultType: ResultTypeEnum.string,
    );
    final select =
        (body.attributes[DBKeys.supabaseSelect] as FTextTypeInput).toCode(
      loop,
      resultType: ResultTypeEnum.string,
    );
    final order =
        (body.attributes[DBKeys.supabaseOrder] as FTextTypeInput).toCode(
      loop,
      resultType: ResultTypeEnum.string,
    );

    final rangeFrom =
        (body.attributes[DBKeys.supabaseFromRange] as FTextTypeInput).toCode(
      loop,
      resultType: ResultTypeEnum.int,
      defaultValue: '1',
    );

    final rangeTo =
        (body.attributes[DBKeys.supabaseToRange] as FTextTypeInput).toCode(
      loop,
      resultType: ResultTypeEnum.int,
      defaultValue: '15',
    );
    final numberPage =
        (body.attributes[DBKeys.supabaseNumberPage] as FTextTypeInput).toCode(
      loop,
      resultType: ResultTypeEnum.int,
      defaultValue: '1',
    );

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
    .ltE($ltEName,$ltEValue)
    .lt($ltName,$ltValue)
    .gte($gtEName,$gtEValue)
    .gt($gtName,$gtValue)
    .filter($filterName, $filterValue)
    .contains($containsName, $containsValue)
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
      final code = await toCode(
        context,
        NodeBody.get(NType.supabaseFutureBuilder),
        [],
        0,
      );
      final res = FormatterTest.format(code);
      if (res) {
        return code;
      } else {
        return 'const SizedBox()';
      }
    }
  }

  static Future<bool> runtimeTestDefaultCode(
    final BuildContext context,
  ) async {
    const name = 'SupabaseFutureBuilder';
    final nodeBody = NodeBody.get(NType.supabaseFutureBuilder);
    final codeToRun = await toCode(
      context,
      nodeBody,
      [],
      0,
    );
    final returnValue = FormatterTest.format(
      codeToRun,
    );
    if (!returnValue) {
      Logger.printError(
        'Runtime ToCode Default Error:\n$name\nThis was the code:\n',
      );
      Logger.printWarning(codeToRun);
      Logger.printMessage('\n-----------END-----------');
    } else {
      Logger.printSuccess('$name: Passed!');
    }
    return returnValue;
  }

  static void testCode() {
    group('SupabaseFutureBuilder toCode test', () {
      test(
        'SupabaseFutureBuilder: default',
        () {
          final body = NodeBody.get(NType.supabaseFutureBuilder);
          final from =
              (body.attributes[DBKeys.supabaseFrom] as FTextTypeInput).toCode(
            0,
            resultType: ResultTypeEnum.string,
          );
           final gtEName =
              (body.attributes[DBKeys.supabaseGreaterOrEqualName] as FTextTypeInput).toCode(
            0,
            resultType: ResultTypeEnum.string,
          );
           final gtEValue =
              (body.attributes[DBKeys.supabaseGreaterOrEqualValue] as FTextTypeInput).toCode(
            0,
            resultType: ResultTypeEnum.string,
          );
          final gtName =
              (body.attributes[DBKeys.supabaseGreaterThanName] as FTextTypeInput).toCode(
            0,
            resultType: ResultTypeEnum.string,
          );
           
          final gtValue =
              (body.attributes[DBKeys.supabaseGreaterThanValue] as FTextTypeInput).toCode(
            0,
            resultType: ResultTypeEnum.string,
          );
          final ltName =
              (body.attributes[DBKeys.supabaseLessThanName] as FTextTypeInput).toCode(
            0,
            resultType: ResultTypeEnum.string,
          );
           
          final ltValue =
              (body.attributes[DBKeys.supabaseLessThanValue] as FTextTypeInput).toCode(
            0,
            resultType: ResultTypeEnum.string,
          );
            final filterName =
              (body.attributes[DBKeys.supabaseFilterName] as FTextTypeInput).toCode(
            0,
            resultType: ResultTypeEnum.string,
          );
           
          final filterValue =
              (body.attributes[DBKeys.supabaseFilterValue] as FTextTypeInput).toCode(
            0,
            resultType: ResultTypeEnum.string,
          );
                  final ltEName =
              (body.attributes[DBKeys.supabaseLessThanOrEqualName] as FTextTypeInput).toCode(
            0,
            resultType: ResultTypeEnum.string,
          );
           
          final ltEValue =
              (body.attributes[DBKeys.supabaseLessThanOrEqualValue] as FTextTypeInput).toCode(
            0,
            resultType: ResultTypeEnum.string,
          );
          final containsName =
              (body.attributes[DBKeys.supabaseContainsName] as FTextTypeInput).toCode(
            0,
            resultType: ResultTypeEnum.string,
          );
           final containsValue =
              (body.attributes[DBKeys.supabaseContainsValue] as FTextTypeInput).toCode(
            0,
            resultType: ResultTypeEnum.string,
          );

          final select =
              (body.attributes[DBKeys.supabaseSelect] as FTextTypeInput).toCode(
            0,
            resultType: ResultTypeEnum.string,
          );
          final order =
              (body.attributes[DBKeys.supabaseOrder] as FTextTypeInput).toCode(
            0,
            resultType: ResultTypeEnum.string,
          );
          final rangeFrom =
              (body.attributes[DBKeys.supabaseFromRange] as FTextTypeInput)
                  .toCode(
            0,
            resultType: ResultTypeEnum.int,
            defaultValue: '1',
          );
          final rangeTo =
              (body.attributes[DBKeys.supabaseToRange] as FTextTypeInput)
                  .toCode(
            0,
            resultType: ResultTypeEnum.int,
            defaultValue: '15',
          );
          final numberPage =
              (body.attributes[DBKeys.supabaseNumberPage] as FTextTypeInput)
                  .toCode(
            0,
            resultType: ResultTypeEnum.int,
          );
          const loader = 'const CircularProgressIndicator()';
          const func = '''
            final doc = snapshot.data as PostgrestResponse?;
            if (doc == null) return const SizedBox();
            final datasets = this.datasets;
            datasets['Supabase future builder'] = doc.data as List<dynamic>? ?? <dynamic>[];''';
          const child = 'const SizedBox()';
          expect(
            FormatterTest.format('''
            FutureBuilder(
              future: Supabase.instance.client
              .from($from)
              .select($select)
              .gt($gtName,$gtValue)
              .gte($gtEName,$gtEValue)
              .filter($filterName,$filterValue)
              .lte($ltEName, $ltEValue)
              .lt($ltName,$ltValue)
              .contains($containsName, $containsValue)
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
             '''),
            true,
          );
        },
      );
    });
  }
}
