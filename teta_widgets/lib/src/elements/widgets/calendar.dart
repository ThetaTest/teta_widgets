// Flutter imports:
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
// Package imports:
import 'package:intl/intl.dart';
import 'package:paged_vertical_calendar/paged_vertical_calendar.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/core/teta_widget/index.dart';
import 'package:teta_widgets/src/elements/builder/save_dataset.dart';
import 'package:teta_widgets/src/elements/index.dart';
import 'package:teta_models/teta_models.dart';

// ignore_for_file: public_member_api_docs

class DateCalendarObject {
  DateCalendarObject({
    required this.date,
    required this.hasEvents,
  });

  final DateTime date;
  final bool hasEvents;
}

class WCalendar extends StatefulWidget {
  /// Returns a [Align] widget in Teta
  const WCalendar(
    final Key? key, {
    required this.state,
    required this.value,
    required this.action,
    required this.textStyle,
    required this.textStyle2,
    required this.margins,
    required this.padding,
    required this.fill,
    required this.fill2,
    required this.borderRadius,
    required this.shadows,
    required this.children,
    required this.selectedItemName,
    required this.fillEventCount,
    required this.borderRaiudEventCount,
    required this.widthEventCount,
    required this.heightEventCount,
  }) : super(key: key);

  final TetaWidgetState state;
  final List<CNode> children;
  final FDataset value;
  final FAction action;
  final FTextStyle textStyle;
  final FTextStyle textStyle2;
  final FMargins margins;
  final FMargins padding;
  final FFill fill;
  final FFill fill2;
  final FFill fillEventCount;
  final FBorderRadius borderRadius;
  final FShadow shadows;
  final FTextTypeInput selectedItemName;
  final FBorderRadius borderRaiudEventCount;
  final FSize widthEventCount;
  final FSize heightEventCount;
  @override
  State<WCalendar> createState() => _WCalendarState();
}

class _WCalendarState extends State<WCalendar> {
  DatasetObject map = DatasetObject.empty();
  DatasetObject? dataset;
  bool isLoading = true;
  List<DateCalendarObject> list = <DateCalendarObject>[];

  @override
  void initState() {
    dataset = null;
    _setDataset();

    super.initState();
  }

  @override
  Widget build(final BuildContext context) {
    final selectedItemNameNew = widget.selectedItemName.get(
      widget.state.params,
      widget.state.states,
      widget.state.dataset,
      widget.state.forPlay,
      widget.state.loop,
      context,
    );
    return PagedVerticalCalendar(
      minDate: DateTime.now(),
      addAutomaticKeepAlives: true,
      dayBuilder: (final context, final date) {
        var eventExists = false;
        var eventCounter = 0;
        final dayFlag = list.firstWhereOrNull(
          (final e) =>
              e.date.year == date.year &&
              e.date.month == date.month &&
              e.date.day == date.day,
        );
        if (dayFlag == null) {
          dataset ??= widget.state.dataset.firstWhereOrNull(
            (final e) => e.getName == widget.value.datasetName,
          );
          if (dataset != null && widget.value.datasetAttrName != null) {
            final element = dataset!.getMap.where((final element) {
              final a = DateTime.tryParse(
                element[widget.value.datasetAttrName] as String? ?? '',
              );
              return a?.year == date.year &&
                  a?.month == date.month &&
                  a?.day == date.day;
            }).toList();
            eventExists = element.isNotEmpty;
            eventCounter = element.length;
          }
          if (dataset != null) {
            list.add(DateCalendarObject(date: date, hasEvents: eventExists));
          }
        } else if (dayFlag.hasEvents) {
          eventExists = true;
          if (dataset != null) {
            final element = dataset!.getMap.where((final element) {
              final a = DateTime.tryParse(
                element[widget.value.datasetAttrName] as String? ?? '',
              );
              return a?.year == date.year &&
                  a?.month == date.month &&
                  a?.day == date.day;
            }).toList();
            eventCounter = element.length;
          }
        }
        return Container(
          margin: widget.margins.get(
            context,
            forPlay: widget.state.forPlay,
          ),
          padding: widget.padding.get(
            context,
            forPlay: widget.state.forPlay,
          ),
          decoration: TetaBoxDecoration.get(
            context: context,
            forPlay: widget.state.forPlay,
            fill: eventExists
                ? widget.fill2.get(context)
                : widget.fill.get(context),
            borderRadius: widget.borderRadius,
            shadow: widget.shadows,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextBuilder(
                textStyle: widget.textStyle,
                value: FTextTypeInput(value: '${date.day}'),
                maxLines: FTextTypeInput(value: '1'),
                params: widget.state.params,
                states: widget.state.states,
                dataset: widget.state.dataset,
                forPlay: widget.state.forPlay,
                loop: widget.state.loop,
              ),
              if (eventExists)
                Wrap(
                  children: List.generate(1, (final index) {
                    return Padding(
                      padding: const EdgeInsets.all(1),
                      child: Container(
                        width: widget.widthEventCount.get(
                          context: context,
                          isWidth: true,
                          forPlay: widget.state.forPlay,
                        ),
                        height: widget.heightEventCount.get(
                          context: context,
                          isWidth: false,
                          forPlay: widget.state.forPlay,
                        ),
                        decoration: TetaBoxDecoration.get(
                          context: context,
                          forPlay: widget.state.forPlay,
                          fill: widget.fillEventCount.get(context),
                          borderRadius: widget.borderRaiudEventCount,
                          shadow: widget.shadows,
                        ),
                      ),
                    );
                  }).toList(),
                )
            ],
          ),
        );
      },
      monthBuilder: (final context, final month, final year) {
        final monthValue = DateFormat('MMMM').format(DateTime(0, month));
        return SizedBox(
          width: double.maxFinite,
          child: TextBuilder(
            textStyle: widget.textStyle2,
            value: FTextTypeInput(value: monthValue),
            maxLines: FTextTypeInput(value: '1'),
            params: widget.state.params,
            states: widget.state.states,
            dataset: widget.state.dataset,
            forPlay: widget.state.forPlay,
            loop: widget.state.loop,
          ),
        );
      },
      onDayPressed: (final date) async {
        final data = widget.state.dataset.firstWhere(
          (final element) => element.getName == widget.value.datasetName,
        );
        final selectedItemList = data.getMap
            .where(
              (final element) =>
                  element[widget.value.datasetAttrName]
                      .toString()
                      .substring(0, 10) ==
                  date.toString().substring(0, 10),
            )
            .toList();
        await saveSelectedItemDatasets(
          selectedItemNameNew,
          context,
          selectedItemList,
          widget.state.dataset,
        );
        final loop = data.getMap.indexOf(
          data.getMap.firstWhere(
            (final element) =>
                element[widget.value.datasetAttrName]
                    .toString()
                    .substring(0, 10) ==
                date.toString().substring(0, 10),
          ),
        );
        GestureBuilder.get(
          context: context,
          state: widget.state.copyWith(
            loop: loop,
          ),
          gesture: ActionGesture.onDayPressed,
          action: widget.action,
          actionValue: FTextTypeInput(value: date.toIso8601String()),
        );
      },
      onMonthLoaded: (final year, final month) => GestureBuilder.get(
        context: context,
        state: widget.state,
        gesture: ActionGesture.onMonthLoaded,
        action: widget.action,
        actionValue: FTextTypeInput(value: '$month'),
      ),
    );
  }

  void _setDataset() {
    try {
      final index = widget.state.dataset.indexWhere(
        (final element) => element.getName == widget.value.datasetName,
      );
      final db =
          index != -1 ? widget.state.dataset[index] : DatasetObject.empty();
      if (mounted) {
        if (db.getName != '') {
          setState(() {
            map = db;
          });
        }
      }
    } catch (_) {}
  }
}

///when you click day, save event as dataset.
Future<void> saveSelectedItemDatasets(
  final String selectedItemNameNew,
  final BuildContext context,
  final List<Map<String, dynamic>> selectedItemList,
  final List<DatasetObject> dataset,
) async {
  var _newMap = const DatasetObject(
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
