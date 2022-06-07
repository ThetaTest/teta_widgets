// Flutter imports:
// ignore_for_file: use_raw_strings

// Flutter imports:
import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/index.dart';
import 'package:teta_widgets/src/elements/features/dataset.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';

/// Generates the code for Padding widget
String calendarCodeTemplate(
  final int pageId,
  final BuildContext context,
  final CNode node,
  final CNode? child,
  final int loop,
) {
  final dataset = node.body.attributes[DBKeys.datasetInput] as FDataset;
  var firstDecoration = CS
      .boxDecoration(context, node.body, DBKeys.bgFill)
      .replaceFirst('decoration:', '');
  firstDecoration = firstDecoration.substring(0, firstDecoration.length - 6);
  return '''
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
        return Container(
          ${CS.margin(context, node.body, isMargin: true)}
          ${CS.margin(context, node.body, isMargin: false)}
          decoration: element != null ? $firstDecoration : ${CS.boxDecoration(context, node.body, DBKeys.fill).replaceFirst('decoration:', '')}
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '\${date.day}',
                ${CS.textStyle(context, node.body, DBKeys.textStyle2)}
              ),
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
}
