// Flutter imports:
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// Package imports:
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:teta_core/teta_core.dart';

// Project imports:
import 'package:teta_widgets/src/core/teta_widget/index.dart';
import 'package:teta_widgets/src/elements/builder/save_dataset.dart';
import 'package:teta_widgets/src/elements/index.dart';

// ignore_for_file: public_member_api_docs

// class DateCalendarObject {
//   DateCalendarObject({
//     required this.date,
//     required this.hasEvents,
//   });

//   final DateTime date;
//   final bool hasEvents;
// }

class WCalendarV2 extends StatefulWidget {
  const WCalendarV2(
    final Key? key, {
    required this.state,
    required this.calendarEvents,
    required this.action,
    required this.children,
    required this.calendarView,
    required this.textStyle,
    required this.textStyle2,
    required this.selectedFill,
    required this.unselectedFill,
    required this.borderRadius,
    required this.shadows,
    required this.iconFill,
    required this.dotFill,
    required this.selectedItemName,
    required this.dotBorderRadius,
  }) : super(key: key);

  final TetaWidgetState state;
  final List<CNode> children;
  final FDataset calendarEvents;
  final FAction action;
  final String calendarView;
  final FTextStyle textStyle;
  final FTextStyle textStyle2;
  final FFill selectedFill;
  final FFill unselectedFill;
  final FBorderRadius borderRadius;
  final FShadow shadows;
  final FFill iconFill;
  final FFill dotFill;
  final FTextTypeInput selectedItemName;
  final FBorderRadius dotBorderRadius;

  @override
  State<WCalendarV2> createState() => _WCalendarV2State();
}

class _WCalendarV2State extends State<WCalendarV2> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DatasetObject? dataset;
  List<DateCalendarObject> list = <DateCalendarObject>[];
  Map<String, List> mySelectedEvents = {};
  TextStyleModel? model;
  PaletteModel? modelPalette;

  @override
  void initState() {
    dataset = null;
    super.initState();
    _selectedDay = _focusedDay;
  }

  @override
  Widget build(final BuildContext context) {
    final isLight = BlocProvider.of<PaletteDarkLightCubit>(context).state;
    PaletteModel? model2;
    BlocProvider.of<ColorStylesCubit>(context).state.forEach((final element) {
      if (element.id == widget.iconFill.paletteStyle) model2 = element;
      if (element.name == widget.iconFill.paletteStyle) model2 = element;
    });
    Color _getIconColor(final PaletteModel? model2, final bool isLight) {
      final tempOpacity = widget.iconFill.levels?.first.opacity ?? 1;
      if (model2 != null) {
        return isLight
            ? HexColor(model2.light!.levels!.first.color)
            : HexColor(model2.fill!.levels!.first.color);
      } else {
        return HexColor(widget.iconFill.levels!.first.color)
            .withOpacity(tempOpacity);
      }
    }

    switch (widget.calendarView) {
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
    var dayHeight = widget.textStyle2.fontSize?.get(context);
    var dayHeight2 = 16.0;
    if (dayHeight != null) {
      dayHeight2 = dayHeight + 5;
    }
    return TableCalendar<Map<String, dynamic>>(
      firstDay: DateTime.utc(2010, 10, 16),
      lastDay: DateTime.utc(2030, 3, 14),
      focusedDay: _focusedDay,
      selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
      calendarFormat: _calendarFormat,
      onDaySelected: _onDaySelected,
      eventLoader: _listOfDayEvents,
      onPageChanged: (focusedDay) {
        _focusedDay = focusedDay;
      },
      daysOfWeekHeight: dayHeight2,
      daysOfWeekStyle: DaysOfWeekStyle(
          weekdayStyle: widget.textStyle2.get(context, model),
          weekendStyle: widget.textStyle2.get(context, model)),
      headerStyle: HeaderStyle(
        leftChevronIcon: Icon(
          Icons.arrow_back,
          color: _getIconColor(model2, isLight),
          size: widget.textStyle2.fontSize?.get(context) ?? 16,
        ),
        rightChevronIcon: Icon(
          Icons.arrow_forward,
          color: _getIconColor(model2, isLight),
          size: widget.textStyle2.fontSize?.get(context) ?? 16,
        ),
        formatButtonVisible: false,
        titleCentered: true,
        titleTextStyle: widget.textStyle.get(context, model),
      ),
      calendarStyle: CalendarStyle(
        markerDecoration: TetaBoxDecoration.get(
          context: context,
          fill: widget.dotFill.get(context),
          borderRadius: widget.dotBorderRadius,
          shadow: widget.shadows,
        ),
        outsideDaysVisible: false,
        selectedTextStyle: widget.textStyle2.get(context, model),
        defaultTextStyle: widget.textStyle2.get(context, model),
        holidayTextStyle: widget.textStyle2.get(context, model),
        weekendTextStyle: widget.textStyle2.get(context, model),
        disabledTextStyle: widget.textStyle2.get(context, model),
        todayTextStyle: widget.textStyle2.get(context, model),
        rangeEndTextStyle: widget.textStyle2.get(context, model),
        weekNumberTextStyle: widget.textStyle2.get(context, model),
        withinRangeTextStyle: widget.textStyle2.get(context, model),
        outsideTextStyle: widget.textStyle2.get(context, model),
        rangeStartTextStyle: widget.textStyle2.get(context, model),
        isTodayHighlighted: true,
        selectedDecoration: TetaBoxDecoration.get(
          context: context,
          fill: widget.selectedFill.get(context),
          borderRadius: widget.borderRadius,
          shadow: widget.shadows,
        ),
        todayDecoration: TetaBoxDecoration.get(
          context: context,
          fill: widget.unselectedFill.get(context),
          borderRadius: widget.borderRadius,
          shadow: widget.shadows,
        ),
        defaultDecoration: TetaBoxDecoration.get(
          context: context,
          fill: widget.unselectedFill.get(context),
          borderRadius: widget.borderRadius,
          shadow: widget.shadows,
        ),
        weekendDecoration: TetaBoxDecoration.get(
          context: context,
          fill: widget.unselectedFill.get(context),
          borderRadius: widget.borderRadius,
          shadow: widget.shadows,
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _listOfDayEvents(DateTime dateTime) {
    dataset ??= widget.state.dataset.firstWhereOrNull(
      (final e) => e.getName == widget.calendarEvents.datasetName,
    );
    if (dataset != null && widget.calendarEvents.datasetAttrName != null) {
      var selectedItemList = dataset!.getMap
          .where(
            (final element) =>
                element[widget.calendarEvents.datasetAttrName]
                    .toString()
                    .substring(0, 10) ==
                dateTime.toString().substring(0, 10),
          )
          .toList();
      if (selectedItemList.isNotEmpty) {
        return selectedItemList;
      }
    }

    return <Map<String, dynamic>>[];
  }

  Future<void> _onDaySelected(DateTime selectedDay, DateTime focusedDay) async {
    List<Map<String, dynamic>> selectedItemList;
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });
      //getEventsForDay
      dataset ??= widget.state.dataset.firstWhereOrNull(
        (final e) => e.getName == widget.calendarEvents.datasetName,
      );
      if (dataset != null && widget.calendarEvents.datasetAttrName != null) {
        selectedItemList = dataset!.getMap
            .where(
              (final element) =>
                  element[widget.calendarEvents.datasetAttrName]
                      .toString()
                      .substring(0, 10) ==
                  selectedDay.toString().substring(0, 10),
            )
            .toList();
        final selectedItemNameNew = widget.selectedItemName.get(
          widget.state.params,
          widget.state.states,
          widget.state.dataset,
          widget.state.forPlay,
          widget.state.loop,
          context,
        );
        await saveSelectedItemDatasets(
          selectedItemNameNew,
          context,
          selectedItemList,
          widget.state.dataset,
        );
        if (selectedItemList.isNotEmpty) {
          final loop = dataset!.getMap.indexOf(
            dataset!.getMap.firstWhere(
              (final element) =>
                  element[widget.calendarEvents.datasetAttrName]
                      .toString()
                      .substring(0, 10) ==
                  selectedDay.toString().substring(0, 10),
            ),
          );
          GestureBuilder.get(
            context: context,
            state: widget.state.copyWith(
              loop: loop,
            ),
            gesture: ActionGesture.onDayPressed,
            action: widget.action,
            actionValue: FTextTypeInput(value: selectedDay.toIso8601String()),
          );
        }
      }
    } else {
      if (dataset != null && widget.calendarEvents.datasetAttrName != null) {
        selectedItemList = dataset!.getMap
            .where(
              (final element) =>
                  element[widget.calendarEvents.datasetAttrName]
                      .toString()
                      .substring(0, 10) ==
                  selectedDay.toString().substring(0, 10),
            )
            .toList();
        final selectedItemNameNew = widget.selectedItemName.get(
          widget.state.params,
          widget.state.states,
          widget.state.dataset,
          widget.state.forPlay,
          widget.state.loop,
          context,
        );
        await saveSelectedItemDatasets(
          selectedItemNameNew,
          context,
          selectedItemList,
          widget.state.dataset,
        );
        if (selectedItemList.isNotEmpty) {
          final loop = dataset!.getMap.indexOf(
            dataset!.getMap.firstWhere(
              (final element) =>
                  element[widget.calendarEvents.datasetAttrName]
                      .toString()
                      .substring(0, 10) ==
                  selectedDay.toString().substring(0, 10),
            ),
          );
          GestureBuilder.get(
            context: context,
            state: widget.state.copyWith(
              loop: loop,
            ),
            gesture: ActionGesture.onDayPressed,
            action: widget.action,
            actionValue: FTextTypeInput(value: selectedDay.toIso8601String()),
          );
        }
      }
    }
  }

  ///when you click day, save event as dataset.
  Future<void> saveSelectedItemDatasets(
      String selectedItemNameNew,
      BuildContext context,
      List<Map<String, dynamic>> selectedItemList,
      List<DatasetObject> dataset) async {
    DatasetObject _newMap = DatasetObject(
      name: 'Selected Items Name',
      map: [<String, dynamic>{}],
    );
    if (selectedItemNameNew.isNotEmpty) {
      _newMap = _newMap.copyWith(
        name: selectedItemNameNew,
        map: selectedItemList,
      );
      await saveDatasets(context, dataset, _newMap);
    } else {
      _newMap = _newMap.copyWith(
        map: selectedItemList,
      );
      await saveDatasets(context, dataset, _newMap);
    }
  }
}
