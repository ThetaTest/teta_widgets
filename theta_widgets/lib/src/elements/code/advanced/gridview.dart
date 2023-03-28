// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/index.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Generates the code for GridView widget
class GridViewCodeTemplate {
  static Future<String> toCode(
    final BuildContext context,
    final NodeBody body,
    final List<CNode> children,
    final int? loop,
  ) async {
    final primary = body.attributes[DBKeys.isPrimary] as bool;
    final _scrollDirection =
        !(body.attributes[DBKeys.isVertical] as bool? ?? false)
            ? 'scrollDirection: Axis.horizontal,'
            : '';

    final shrinkWrap = body.attributes[DBKeys.flag] as bool? ?? false;
    final valueMainAxisSpacing =
        (body.attributes[DBKeys.mainAxisSpacing] as FTextTypeInput).toCode(
      loop,
      resultType: ResultTypeEnum.double,
      defaultValue: '1',
    );
    //! Remove this
    //final mainAxisSpacing = int.tryParse(valueMainAxisSpacing) ?? 2;

    final valueCrossAxisCount =
        (body.attributes[DBKeys.crossAxisCount] as FTextTypeInput).toCode(
      loop,
      resultType: ResultTypeEnum.int,
      defaultValue: '1',
    );
    //! Remove this
    //final crossAxisCount = int.tryParse(valueCrossAxisCount) ?? 2;

    final valueCrossAxisSpacing =
        (body.attributes[DBKeys.crossAxisSpacing] as FTextTypeInput).toCode(
      loop,
      resultType: ResultTypeEnum.double,
      defaultValue: '1',
    );
    //final crossAxisSpacing = double.tryParse(valueCrossAxisSpacing) ?? 2;

    final valueChildAspectRatio =
        (body.attributes[DBKeys.childAspectRatio] as FTextTypeInput).toCode(
      loop,
      resultType: ResultTypeEnum.double,
      defaultValue: '1',
    );
    //final childAspectRatio = double.tryParse(valueChildAspectRatio) ?? 1;

    final childrenString = await CS.children(context, children);
    final code = '''
    GridView(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: $valueMainAxisSpacing,
        crossAxisCount: $valueCrossAxisCount,
        crossAxisSpacing: $valueCrossAxisSpacing,
        childAspectRatio: $valueChildAspectRatio, 
      ),
      shrinkWrap: $shrinkWrap,
      primary: $primary,
      $_scrollDirection
      $childrenString
    )
  ''';
    final res = FormatterTest.format(code);
    if (res) {
      return code;
    } else {
      final code = await toCode(
        context,
        NodeBody.get(NType.gridView),
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

  static void testCode() {
    group('GridView toCode test', () {
      test(
        'GridView: default',
        () {
          final body = NodeBody.get(NType.gridView);
          final primary = body.attributes[DBKeys.isPrimary] as bool;
          final _scrollDirection =
              !(body.attributes[DBKeys.isVertical] as bool? ?? false)
                  ? 'scrollDirection: Axis.horizontal,'
                  : '';
          final shrinkWrap = body.attributes[DBKeys.flag] as bool? ?? false;
          final valueMainAxisSpacing =
              (body.attributes[DBKeys.mainAxisSpacing] as FTextTypeInput)
                  .toCode(
            0,
            resultType: ResultTypeEnum.int,
          );
          //! Remove this
          //!final mainAxisSpacing = double.tryParse(valueMainAxisSpacing) ?? 2;

          final valueCrossAxisCount =
              (body.attributes[DBKeys.crossAxisCount] as FTextTypeInput).toCode(
            0,
            resultType: ResultTypeEnum.int,
          );
          //!final crossAxisCount = int.tryParse(valueCrossAxisCount) ?? 2;

          final valueCrossAxisSpacing =
              (body.attributes[DBKeys.crossAxisSpacing] as FTextTypeInput)
                  .toCode(
            0,
            resultType: ResultTypeEnum.int,
          );
          //!final crossAxisSpacing = double.tryParse(valueCrossAxisSpacing) ?? 2;

          final valueChildAspectRatio =
              (body.attributes[DBKeys.childAspectRatio] as FTextTypeInput)
                  .toCode(
            0,
            resultType: ResultTypeEnum.int,
          );
          //!final childAspectRatio = double.tryParse(valueChildAspectRatio) ?? 1;

          expect(
            FormatterTest.format('''
            GridView(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: $valueMainAxisSpacing,
        crossAxisCount: $valueCrossAxisCount,
        crossAxisSpacing: $valueCrossAxisSpacing,
        childAspectRatio: $valueChildAspectRatio, 
      ),
      shrinkWrap: $shrinkWrap,
      primary: $primary,
      $_scrollDirection
      childrens: const []
    )'''),
            true,
          );
        },
      );
    });
  }
}
