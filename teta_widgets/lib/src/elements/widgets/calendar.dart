// Flutter imports:
// Package imports:
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:paged_vertical_calendar/paged_vertical_calendar.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

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
    required this.node,
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
    required this.forPlay,
    required this.params,
    required this.states,
    required this.dataset,
    required this.children,
    this.loop,
  }) : super(key: key);

  final CNode node;
  final List<CNode> children;
  final FDataset value;
  final FAction action;
  final FTextStyle textStyle;
  final FTextStyle textStyle2;
  final FMargins margins;
  final FMargins padding;
  final FFill fill;
  final FFill fill2;
  final FBorderRadius borderRadius;
  final FShadow shadows;
  final bool forPlay;
  final int? loop;

  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

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
    return PagedVerticalCalendar(
      startDate: DateTime.now(),
      addAutomaticKeepAlives: true,
      dayBuilder: (final context, final date) {
        var eventExists = false;
        final dayFlag = list.firstWhereOrNull(
          (final e) =>
              e.date.year == date.year &&
              e.date.month == date.month &&
              e.date.day == date.day,
        );
        if (dayFlag == null) {
          dataset ??= widget.dataset.firstWhereOrNull(
            (final e) => e.getName == widget.value.datasetName,
          );
          if (dataset != null && widget.value.datasetAttrName != null) {
            final element = dataset!.getMap.firstWhereOrNull((final element) {
              final a = DateTime.tryParse(
                element[widget.value.datasetAttrName] as String? ?? '',
              );
              return a?.year == date.year &&
                  a?.month == date.month &&
                  a?.day == date.day;
            });
            eventExists = element != null;
          }
          if (dataset != null) {
            list.add(DateCalendarObject(date: date, hasEvents: eventExists));
          }
        } else if (dayFlag.hasEvents) {
          eventExists = true;
        }
        return Container(
          margin: widget.margins.get(context),
          padding: widget.padding.get(context),
          decoration: TetaBoxDecoration.get(
            context: context,
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
                params: widget.params,
                states: widget.states,
                dataset: widget.dataset,
                forPlay: widget.forPlay,
                loop: widget.loop,
              ),
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
            params: widget.params,
            states: widget.states,
            dataset: widget.dataset,
            forPlay: widget.forPlay,
            loop: widget.loop,
          ),
        );
      },
      onDayPressed: (final date) => GestureBuilder.get(
        context: context,
        node: widget.node,
        gesture: ActionGesture.onDayPressed,
        action: widget.action,
        actionValue: FTextTypeInput(value: date.toIso8601String()),
        params: widget.params,
        states: widget.states,
        dataset: widget.dataset,
        forPlay: widget.forPlay,
      ),
      onMonthLoaded: (final year, final month) => GestureBuilder.get(
        context: context,
        node: widget.node,
        gesture: ActionGesture.onMonthLoaded,
        action: widget.action,
        actionValue: FTextTypeInput(value: '$month'),
        params: widget.params,
        states: widget.states,
        dataset: widget.dataset,
        forPlay: widget.forPlay,
      ),
    );
  }

  void _setDataset() {
    try {
      final index = widget.dataset.indexWhere(
        (final element) => element.getName == widget.value.datasetName,
      );
      final db = index != -1 ? widget.dataset[index] : DatasetObject.empty();
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
