// Flutter imports:
// ignore_for_file: use_raw_strings

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:theta_widgets/src/elements/code/formatter_test.dart';
// Project imports:
import 'package:theta_widgets/src/elements/code/snippets.dart';
import 'package:theta_widgets/src/elements/controls/key_constants.dart';
import 'package:theta_widgets/src/elements/index.dart';

/// Generates the code for Calendar widget
class CalendarCodeTemplate {
  static Future<String> toCode(
    final int pageId,
    final BuildContext context,
    final CNode node,
    final int loop,
  ) async {
    final dataset = node.body.attributes[DBKeys.datasetInput] as FDataset;
    final selectedItem =
        node.body.attributes[DBKeys.selectedItemName] as FTextTypeInput;
    final selectedItemNameNew = selectedItem
        .toCode(
          loop,
          resultType: ResultTypeEnum.string,
        )
        .replaceAll("'", '')
        .replaceAll(' ', '');
    var firstDecoration = CS
        .boxDecoration(context, node.body, DBKeys.bgFill)
        .replaceFirst('decoration:', '');
    firstDecoration = firstDecoration.substring(0, firstDecoration.length - 6);
    final code = '''
  Builder(builder: (context) {
    return PagedVerticalCalendar(
      addAutomaticKeepAlives: true,
      ${CS.action(
      pageId,
      context,
      node,
      ActionGesture.onDayPressed,
      'onDayPressed: (date) async',
      '\$date',
      isRequired: false,
      loop: loop,
      additionalCode: '''
   var list = datasets['${dataset.datasetName}']
        .where((element) =>
            element['${dataset.datasetAttrName}'].toString().substring(0, 10) ==
            date.toString().substring(0, 10))
        .toList();
    if (Hive.isBoxOpen('datasets')) {
      final box = Hive.box('datasets');
      await box.put('$selectedItemNameNew', list ?? const <dynamic>[]);
    }
      index = (datasets['${dataset.datasetName}'] as List<dynamic>).indexOf(datasets['${dataset.datasetName}'].firstWhere(
        (element) =>
          element['${dataset.datasetAttrName}'].toString().substring(0, 10) ==
          date.toString().substring(0, 10)
        )
      );
      ''',
    )}
      ${CS.action(
      pageId,
      context,
      node,
      ActionGesture.onMonthLoaded,
      'onMonthLoaded: (year, month) async',
      '\$month',
      isRequired: false,
      loop: loop,
    )}
      dayBuilder: (context, date) {
        final dataset = datasets['${dataset.datasetName}'];
        final element =
                            (dataset as List<dynamic>).firstWhereOrNull(
                          (e) {
                            final d = DateTime.tryParse(e['${dataset.datasetAttrName}']);
                            return d?.year == date.year &&
                                d?.month == date.month &&
                                d?.day == date.day;
                          },
                        );
      final eventCount =
                            (dataset as List<dynamic>).where(
                          (e) {
                            final d = DateTime.tryParse(e['${dataset.datasetAttrName}']);
                            return d?.year == date.year &&
                                d?.month == date.month &&
                                d?.day == date.day;
                          },
                        ).length;
        return Container(
          ${CS.margin(context, node.body, isMargin: true)}
          ${CS.margin(context, node.body, isMargin: false)}
          decoration: element != null ? $firstDecoration : ${CS.boxDecoration(context, node.body, DBKeys.fill).replaceFirst('decoration:', '')}
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '\${date.day}',
                ${CS.textStyle(context, node.body, DBKeys.textStyle2)}
              ),
              if (element != null)
                Wrap(
                  children: List.generate(1, (index) {
                    return Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Container(
                        ${CS.size(context, node.body, isWidth: true)}
                        ${CS.size(context, node.body, isWidth: false)}
                        ${CS.boxDecoration(context, node.body, DBKeys.bgTwoFill)}
                      ),
                    );
                  }).toList(),
                )
            ],
          ),
        );
      },
      monthBuilder: (context, month, year) {
        final monthValue = DateFormat.MMMM().format(DateTime(0, month));
        return SizedBox(
          width: double.maxFinite,
          child: Text(
            '\$monthValue',
            ${CS.textStyle(context, node.body, DBKeys.textStyle2)}
          ),
        );
      },
    );
    },
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
