// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';
// Project imports:
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/index.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Generates the code for GridView.builder widget
class GridViewBuilderCodeTemplate {
  static Future<String> toCode(
    final BuildContext context,
    final NodeBody body,
    final CNode? child,
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
      resultType: ResultTypeEnum.int,
    );
    final mainAxisSpacing = double.tryParse(valueMainAxisSpacing) != null &&
            (double.tryParse(valueMainAxisSpacing) ?? 0) > 0.1
        ? double.parse(valueMainAxisSpacing)
        : 2;

    final valueCrossAxisCount =
        (body.attributes[DBKeys.crossAxisCount] as FTextTypeInput).toCode(loop);
    final crossAxisCount = int.tryParse(valueCrossAxisCount) != null &&
            (int.tryParse(valueCrossAxisCount) ?? 0) > 0.1
        ? int.parse(valueCrossAxisCount)
        : 2;

    final valueCrossAxisSpacing =
        (body.attributes[DBKeys.crossAxisSpacing] as FTextTypeInput)
            .toCode(loop);
    final crossAxisSpacing = double.tryParse(valueCrossAxisSpacing) != null &&
            (double.tryParse(valueCrossAxisSpacing) ?? 0) > 0.1
        ? double.parse(valueCrossAxisSpacing)
        : 2;

    final valueChildAspectRatio =
        (body.attributes[DBKeys.childAspectRatio] as FTextTypeInput)
            .toCode(loop);
    final childAspectRatio = double.tryParse(valueChildAspectRatio) != null &&
            (double.tryParse(valueChildAspectRatio) ?? 0) > 0.1
        ? double.parse(valueChildAspectRatio)
        : 1;

    final childString =
        child != null ? await child.toCode(context) : 'const SizedBox()';
    final dataset =
        (body.attributes[DBKeys.datasetInput] as FDataset).datasetName;

    final code = '''
    GridView.builder(
      shrinkWrap: $shrinkWrap,
      primary: $primary,
      $_scrollDirection
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: $mainAxisSpacing,
        crossAxisCount: $crossAxisCount,
        crossAxisSpacing: $crossAxisSpacing,
        childAspectRatio: $childAspectRatio,
      ),
      itemCount: ${dataset != null ? '''
          datasets.keys.contains('$dataset') ? (datasets['$dataset'] as List<dynamic>).length : 0
          ''' : '0'},
      itemBuilder: (context, index) {
            return $childString;
          },
    )
  ''';
    final res = FormatterTest.format(code);
    if (res) {
      return code;
    } else {
      final code = await toCode(
        context,
        NodeBody.get(NType.gridViewBuilder),
        child,
        loop,
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
    group('GridViewBuilder toCode test', () {
      test(
        'GridViewBuilder: default',
        () {
          final body = NodeBody.get(NType.gridViewBuilder);
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
          final mainAxisSpacing =
              double.tryParse(valueMainAxisSpacing) != null &&
                      (double.tryParse(valueMainAxisSpacing) ?? 0) > 0.1
                  ? double.parse(valueMainAxisSpacing)
                  : 2;

          final valueCrossAxisCount =
              (body.attributes[DBKeys.crossAxisCount] as FTextTypeInput)
                  .toCode(0);
          final crossAxisCount = int.tryParse(valueCrossAxisCount) != null &&
                  (int.tryParse(valueCrossAxisCount) ?? 0) > 0.1
              ? int.parse(valueCrossAxisCount)
              : 2;

          final valueCrossAxisSpacing =
              (body.attributes[DBKeys.crossAxisSpacing] as FTextTypeInput)
                  .toCode(0);
          final crossAxisSpacing =
              double.tryParse(valueCrossAxisSpacing) != null &&
                      (double.tryParse(valueCrossAxisSpacing) ?? 0) > 0.1
                  ? double.parse(valueCrossAxisSpacing)
                  : 2;

          final valueChildAspectRatio =
              (body.attributes[DBKeys.childAspectRatio] as FTextTypeInput)
                  .toCode(0);
          final childAspectRatio =
              double.tryParse(valueChildAspectRatio) != null &&
                      (double.tryParse(valueChildAspectRatio) ?? 0) > 0.1
                  ? double.parse(valueChildAspectRatio)
                  : 1;

          const childString = 'const SizedBox()';
          final dataset =
              (body.attributes[DBKeys.datasetInput] as FDataset).datasetName;
          expect(
            FormatterTest.format('''
            GridView.builder(
      shrinkWrap: $shrinkWrap,
      primary: $primary,
      $_scrollDirection
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: $mainAxisSpacing,
        crossAxisCount: $crossAxisCount,
        crossAxisSpacing: $crossAxisSpacing,
        childAspectRatio: $childAspectRatio,
      ),
      itemCount: ${dataset != null ? '''
          datasets.keys.contains('$dataset') ? (datasets['$dataset'] as List<dynamic>).length : 0
          ''' : '0'},
      itemBuilder: (context, index) {
            return $childString;
          },
    )'''),
            true,
          );
        },
      );
    });
  }
}
