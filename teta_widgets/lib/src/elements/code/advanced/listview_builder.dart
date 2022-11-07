// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';
import 'package:teta_widgets/src/elements/code/snippets.dart';
// Project imports:
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/index.dart';
import 'package:teta_widgets/src/elements/nodes/dynamic.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Generates the code for ListView.builder widget
class ListViewBuilderCodeTemplate {
  static Future<String> toCode(
    final BuildContext context,
    final NDynamic node,
    final int pageId,
    final CNode? child,
    final int? loop,
  ) async {
    final dataset =
        (node.body.attributes[DBKeys.datasetInput] as FDataset).datasetName;
    final _scrollDirection =
        !(node.body.attributes[DBKeys.isVertical] as bool? ?? false)
            ? 'scrollDirection: Axis.horizontal,'
            : '';
    final shrinkWrap = node.body.attributes[DBKeys.flag] as bool? ?? false;
    final reverse = node.body.attributes[DBKeys.isFullWidth] as bool;
    var startFromIndex =
        (node.body.attributes[DBKeys.value] as FTextTypeInput).toCode(
      loop,
      resultType: ResultTypeEnum.int,
      defaultValue: '0',
    );
    if ((int.tryParse(startFromIndex) ?? 0) <= 0) {
      startFromIndex = '0';
    }
    final limit =
        (node.body.attributes[DBKeys.valueOfCondition] as FTextTypeInput)
            .toCode(
      loop,
      resultType: ResultTypeEnum.int,
      defaultValue: "this.datasets['$dataset'].length",
    );
    final childString =
        child != null ? await child.toCode(context) : 'const SizedBox()';
    final code = '''
    NotificationListener<ScrollEndNotification>(
          onNotification: (final scrollEnd) {
          final metrics = scrollEnd.metrics;
          if (metrics.atEdge) { 
            final isTop = metrics.pixels == 0;
            if ${CS.action(
      pageId,
      context,
      node,
      ActionGesture.scrollToTop,
      '(isTop)',
      null,
      loop: loop,
      isRequired: true,
      endsWithComma: false,
    )}
            ${CS.action(
      pageId,
      context,
      node,
      ActionGesture.scrollToBottom,
      'else',
      null,
      loop: loop,
      isRequired: true,
      endsWithComma: false,
    )}
          }
          return true;
        },
          child: ListView.builder(
            $_scrollDirection
            reverse: $reverse,
            physics: ${CS.physic(context, node.body)},
            shrinkWrap: $shrinkWrap,
            itemCount: this.datasets['$dataset']?.length ?? 0 > 0 ? this.datasets['$dataset'].sublist($startFromIndex, $limit).length : 0,
            itemBuilder: (context, index) {
              return $childString;
            },
          ),
        )
  ''';
    final res = FormatterTest.format(code);
    if (res) {
      return code;
    } else {
      final code = await toCode(
        context,
        node,
        pageId,
        null,
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
    group('ListViewBuilder toCode test', () {
      test(
        'ListViewBuilder: default',
        () {
          final body = NodeBody.get(NType.listViewBuilder);
          final _scrollDirection =
              !(body.attributes[DBKeys.isVertical] as bool? ?? false)
                  ? 'scrollDirection: Axis.horizontal,'
                  : '';
          final shrinkWrap = body.attributes[DBKeys.flag] as bool? ?? false;
          final reverse = body.attributes[DBKeys.isFullWidth] as bool;
          const childString = 'const SizedBox()';
          final dataset =
              (body.attributes[DBKeys.datasetInput] as FDataset).datasetName;
          expect(
            FormatterTest.format('''
            ListView.builder(
            $_scrollDirection
            reverse: $reverse,
            shrinkWrap: $shrinkWrap,
            itemCount: this.datasets['$dataset']?.length ?? 0 > 0 ? this.datasets['$dataset'].length : 0,
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
