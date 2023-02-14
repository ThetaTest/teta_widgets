// Flutter imports:
// ignore_for_file: use_raw_strings

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/index.dart';

/// Generates the code for Calendar widget
class CalendarV2CodeTemplate {
  static Future<String> toCode(
    final int pageId,
    final BuildContext context,
    final CNode node,
    final int loop,
  ) async {
    //CalendarView
    final calendarView = node.body.attributes[DBKeys.dropdownItem] as String;
    var _calendarFormat = CalendarFormat.month;
    switch (calendarView) {
      case 'month':
        _calendarFormat = CalendarFormat.month;
        break;
      case 'twoWeeks':
        _calendarFormat = CalendarFormat.twoWeeks;
        break;

      case 'week':
        _calendarFormat = CalendarFormat.week;
        break;

      default:
        break;
    }
    //Icon Size from text attributes
    final textStyleTitle =
        node.body.attributes[DBKeys.textStyle2] as FTextStyle;
    final iconSize = textStyleTitle.fontSize?.get(
          context,
          forPlay: false,
        ) ??
        16;
    //Icon Color
    final fillIconColor = FFill.toCode(
      node.body.attributes[DBKeys.fill2] as FFill,
      context,
      flagConst: false,
    );
    //weekDaysHeight
    final dayHeight = textStyleTitle.fontSize?.get(
          context,
          forPlay: false,
        ) ??
        16;
    var weekDaysHeight = 16.0;
    weekDaysHeight = dayHeight + 5;
    //Datasets
    final dataset = node.body.attributes[DBKeys.datasetInput] as FDataset;
    //Clicked Event List
    final selectedItem =
        node.body.attributes[DBKeys.selectedItemName] as FTextTypeInput;
    final selectedItemNameNew = selectedItem
        .toCode(
          loop,
          resultType: ResultTypeEnum.string,
        )
        .replaceAll("'", '')
        .replaceAll(' ', '');
    //listOfDayEvents
    final _listOfDayEvents = '''
(DateTime dateTime){
  var list = datasets['${dataset.datasetName}']
        .where((element) =>
            element['${dataset.datasetAttrName}'].toString().substring(0, 10) ==
            dateTime.toString().substring(0, 10))
        .toList();
if(list != null){
  return list;
}else {
  return <dynamic>[];
}
}
''';
//    onDaySelected
//     var _onDaySelected = '''
// (DateTime selectedDay, DateTime focusedDay)async{

// if (!isSameDay(_selectedDay, selectedDay)){

//     localSetState(() {
//         _selectedDay = selectedDay;
//         _focusedDay = focusedDay;
//       });

//     var list = datasets['${dataset.datasetName}']
//         .where((element) =>
//             element['${dataset.datasetAttrName}'].toString().substring(0, 10) ==
//             dateTime.toString().substring(0, 10))
//         .toList();

//         if (Hive.isBoxOpen('datasets')) {
//       final box = Hive.box('datasets');
//       await box.put('$selectedItemNameNew', list ?? const <dynamic>[]);
//     }

// }
// }
//''';
//onDaySelected: $_onDaySelected,
    final _onDaySelected = '''
 ${CS.action(
      pageId,
      context,
      node,
      ActionGesture.onDayPressed,
      'onDaySelected: (DateTime selectedDay, DateTime focusedDay) async',
      '\$selectedDay',
      isRequired: false,
      loop: loop,
      additionalCode: '''
  
if (!isSameDay(_selectedDay, selectedDay)){

    localSetState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });

    var list = datasets['${dataset.datasetName}']
        .where((element) =>
            element['${dataset.datasetAttrName}'].toString().substring(0, 10) ==
            selectedDay.toString().substring(0, 10))
        .toList();

        if (Hive.isBoxOpen('datasets')) {
      final box = Hive.box('datasets');
      await box.put('$selectedItemNameNew', list ?? const <dynamic>[]);
    }

}
      ''',
    )}
''';
    return '''
  Builder(builder: (context) {
    DateTime _focusedDay = DateTime.now();
    DateTime? _selectedDay = DateTime.now();
    return StatefulBuilder(
      builder: (final context, final localSetState) {
  return TableCalendar<dynamic>(
  firstDay: DateTime.utc(2010, 10, 16),
  lastDay: DateTime.utc(2030, 3, 14),
  focusedDay: _focusedDay,
  selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
  calendarFormat: $_calendarFormat,
  eventLoader: $_listOfDayEvents,
  daysOfWeekHeight: $weekDaysHeight,
  $_onDaySelected
  headerStyle: HeaderStyle(
        leftChevronIcon: Icon(
          Icons.arrow_back,
          $fillIconColor
          size:$iconSize,
        ),
        rightChevronIcon: Icon(
          Icons.arrow_forward,
          $fillIconColor
          size:$iconSize,
        ),
        formatButtonVisible: false,
        titleCentered: true,
        titleTextStyle: ${CS.textStyle(context, node.body, DBKeys.textStyle, textStyleOnly: true).replaceFirst('style:', '')}
      ),
  daysOfWeekStyle: DaysOfWeekStyle(
          weekdayStyle:${CS.textStyle(context, node.body, DBKeys.textStyle2, textStyleOnly: true).replaceFirst('style:', '')}
          weekendStyle: ${CS.textStyle(context, node.body, DBKeys.textStyle2, textStyleOnly: true).replaceFirst('style:', '')}
          ),
  calendarStyle: CalendarStyle(
        markerDecoration:${CS.boxDecoration(context, node.body, DBKeys.fill3, borderRadiusTwo: true).replaceFirst('decoration:', '')}
        outsideDaysVisible: false,
        selectedTextStyle: ${CS.textStyle(context, node.body, DBKeys.textStyle2, textStyleOnly: true).replaceFirst('style:', '')}
        defaultTextStyle: ${CS.textStyle(context, node.body, DBKeys.textStyle2, textStyleOnly: true).replaceFirst('style:', '')}
        holidayTextStyle: ${CS.textStyle(context, node.body, DBKeys.textStyle2, textStyleOnly: true).replaceFirst('style:', '')}
        weekendTextStyle: ${CS.textStyle(context, node.body, DBKeys.textStyle2, textStyleOnly: true).replaceFirst('style:', '')}
        disabledTextStyle: ${CS.textStyle(context, node.body, DBKeys.textStyle2, textStyleOnly: true).replaceFirst('style:', '')}
        todayTextStyle: ${CS.textStyle(context, node.body, DBKeys.textStyle2, textStyleOnly: true).replaceFirst('style:', '')}
        rangeEndTextStyle: ${CS.textStyle(context, node.body, DBKeys.textStyle2, textStyleOnly: true).replaceFirst('style:', '')}
        weekNumberTextStyle: ${CS.textStyle(context, node.body, DBKeys.textStyle2, textStyleOnly: true).replaceFirst('style:', '')}
        withinRangeTextStyle: ${CS.textStyle(context, node.body, DBKeys.textStyle2, textStyleOnly: true).replaceFirst('style:', '')}
        outsideTextStyle: ${CS.textStyle(context, node.body, DBKeys.textStyle2, textStyleOnly: true).replaceFirst('style:', '')}
        rangeStartTextStyle: ${CS.textStyle(context, node.body, DBKeys.textStyle2, textStyleOnly: true).replaceFirst('style:', '')}
        isTodayHighlighted: true,
        selectedDecoration:  ${CS.boxDecoration(context, node.body, DBKeys.fill).replaceFirst('decoration:', '')}
        todayDecoration: ${CS.boxDecoration(context, node.body, DBKeys.bgFill).replaceFirst('decoration:', '')}
        defaultDecoration: ${CS.boxDecoration(context, node.body, DBKeys.bgFill).replaceFirst('decoration:', '')}
        weekendDecoration: ${CS.boxDecoration(context, node.body, DBKeys.bgFill).replaceFirst('decoration:', '')}
        disabledDecoration: ${CS.boxDecoration(context, node.body, DBKeys.bgFill).replaceFirst('decoration:', '')}
        holidayDecoration: ${CS.boxDecoration(context, node.body, DBKeys.bgFill).replaceFirst('decoration:', '')}
        outsideDecoration: ${CS.boxDecoration(context, node.body, DBKeys.bgFill).replaceFirst('decoration:', '')}
        withinRangeDecoration: ${CS.boxDecoration(context, node.body, DBKeys.bgFill).replaceFirst('decoration:', '')}
        rangeEndDecoration: ${CS.boxDecoration(context, node.body, DBKeys.bgFill).replaceFirst('decoration:', '')}
        rangeStartDecoration: ${CS.boxDecoration(context, node.body, DBKeys.bgFill).replaceFirst('decoration:', '')}

      ),
);
                    });
                  })
''';
  }

  static void testCode() {}
}
