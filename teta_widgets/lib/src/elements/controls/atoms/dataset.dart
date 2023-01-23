// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/features/dataset.dart';

class DatasetControl extends StatefulWidget {
  const DatasetControl({
    required this.value,
    required this.title,
    required this.callBack,
    final Key? key,
    this.isAttrRequired,
  }) : super(key: key);

  final FDataset value;
  final String title;
  final bool? isAttrRequired;
  final Function(FDataset, FDataset) callBack;

  @override
  DatasetControlState createState() => DatasetControlState();
}

class DatasetControlState extends State<DatasetControl> {
  String databaseName = '';
  String? databaseAttribute;

  @override
  void initState() {
    try {
      databaseName = widget.value.datasetName!;
      databaseAttribute = widget.value.datasetAttrName;
    } catch (_) {}
    super.initState();
  }

  @override
  Widget build(final BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TParagraph(
              widget.title,
            ),
          ],
        ),
        BlocBuilder<PageCubit, PageState>(
          builder: (final context, final state) {
            if (state is! PageLoaded) return const SizedBox();
            return CDropdown(
              value: state.datasets
                      .map((final e) => e.getName)
                      .where((final element) => element != 'null')
                      .contains(widget.value.datasetName)
                  ? widget.value.datasetName
                  : null,
              items: state.datasets
                  .map((final e) => e.getName)
                  .where((final element) => element != 'null')
                  .toList(),
              onChange: (final newValue) {
                setState(() {
                  databaseName = newValue!;
                });
                final old = widget.value;
                widget.value.datasetName = newValue;
                widget.callBack(widget.value, old);
              },
            );
          },
        ),
        _buildAttrSelection(
          value: widget.value,
          isAttrRequired: widget.isAttrRequired ?? false,
          datasetName: databaseName,
          callBack: widget.callBack,
        ),
      ],
    );
  }
}

class _buildAttrSelection extends StatefulWidget {
  const _buildAttrSelection({
    final Key? key,
    required this.value,
    required this.isAttrRequired,
    required this.datasetName,
    required this.callBack,
  }) : super(key: key);

  final FDataset value;
  final bool isAttrRequired;
  final String datasetName;
  final Function(FDataset, FDataset) callBack;

  @override
  __buildAttrSelectionState createState() => __buildAttrSelectionState();
}

class __buildAttrSelectionState extends State<_buildAttrSelection> {
  bool isAttrRequired = false;
  String databaseAttribute = '';

  @override
  void initState() {
    super.initState();
    isAttrRequired = widget.isAttrRequired;
    if (widget.datasetName != '') {
      bool hasSubList;
      final datasets = (context.read<PageCubit>().state as PageLoaded).datasets;
      datasets
              .where(
                (final element) => element.getName == widget.datasetName,
              )
              .first
              .getMap
              .isNotEmpty
          ? hasSubList = datasets
              .where(
                (final element) => element.getName == widget.datasetName,
              )
              .first
              .hasSubList()
          : hasSubList = false;
      if (hasSubList == true) {
        isAttrRequired = true;
      }
    }
  }

  @override
  Widget build(final BuildContext context) {
    if (isAttrRequired && widget.datasetName != '') {
      return BlocBuilder<PageCubit, PageState>(
        builder: (final context, final state) {
          if (state is! PageLoaded) return const SizedBox();
          return CDropdown(
            value: (state.datasets
                            .where(
                              (final element) =>
                                  element.getName == widget.datasetName,
                            )
                            .first
                            .getMap
                            .isNotEmpty
                        ? state.datasets
                            .where(
                              (final element) =>
                                  element.getName == widget.datasetName,
                            )
                            .first
                            .getMap
                            .first
                        : <String, dynamic>{})
                    .keys
                    .toSet()
                    .contains(widget.value.datasetAttrName)
                ? widget.value.datasetAttrName
                : null,
            items: ((state.datasets
                        .where(
                          (final element) =>
                              element.getName == widget.datasetName,
                        )
                        .first
                        .getMap
                        .isNotEmpty)
                    ? state.datasets
                        .where(
                          (final element) =>
                              element.getName == widget.datasetName,
                        )
                        .first
                        .getMap
                        .first
                    : <String, dynamic>{})
                .keys
                .toSet()
                .toList(),
            onChange: (final newValue) {
              setState(() {
                databaseAttribute = newValue!;
              });
              final old = widget.value;
              widget.value.datasetAttrName = newValue;
              widget.callBack(widget.value, old);
            },
          );
        },
      );
    } else {
      return Container();
    }
  }
}
