// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/features/dataset.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';

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
  int? nodeId;
  bool? isUpdated;
  String databaseName = '';
  String? databaseAttribute;

  @override
  void initState() {
    try {
      nodeId = widget.node.nid;
      databaseName = widget.value.datasetName!;
      databaseAttribute = widget.value.datasetAttrName;
    } catch (_) {}
    super.initState();
  }

  @override
  Widget build(final BuildContext context) {
    return BlocListener<FocusBloc, List<CNode>>(
      listener: (final context, final state) {
        if (state.isNotEmpty) {
          if (state.first.nid != nodeId) {
            setState(() {
              isUpdated = true;
            });
            nodeId = state.first.nid;
          }
        }
      },
      child: Column(
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
          CDropdown(
            value: widget.page.datasets
                    .map((final e) => e.getName)
                    .where((final element) => element != 'null')
                    .contains(widget.value.datasetName)
                ? widget.value.datasetName
                : null,
            items: widget.page.datasets
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
          ),
          _buildAttrSelection(context),
        ],
      ),
    );
  }

  Widget _buildAttrSelection(final BuildContext context) {
    var isAttrRequired = widget.isAttrRequired;

    if (databaseName != '') {
      bool hasSubList;
      widget.page.datasets
              .where(
                (final element) => element.getName == databaseName,
              )
              .first
              .getMap
              .isNotEmpty
          ? hasSubList = widget.page.datasets
              .where(
                (final element) => element.getName == databaseName,
              )
              .first
              .hasSubList()
          : hasSubList = false;
      if (hasSubList == true) {
        isAttrRequired = true;
      }
    }

    try {
      if ((isAttrRequired ?? false) && databaseName != '') {
        return CDropdown(
          value: (widget.page.datasets
                          .where(
                            (final element) => element.getName == databaseName,
                          )
                          .first
                          .getMap
                          .isNotEmpty
                      ? widget.page.datasets
                          .where(
                            (final element) => element.getName == databaseName,
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
          items: ((widget.page.datasets
                      .where(
                        (final element) => element.getName == databaseName,
                      )
                      .first
                      .getMap
                      .isNotEmpty)
                  ? widget.page.datasets
                      .where(
                        (final element) => element.getName == databaseName,
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
              databaseAttribute = newValue;
            });
            final old = widget.value;
            widget.value.datasetAttrName = newValue;
            widget.callBack(widget.value, old);
          },
        );
      } else {
        return Container();
      }
    } catch (e, st) {
      print('DatasetAttrSelectError: $e');
      print('DatasetAttrSelectError: $st');
      return Container();
    }
  }
}
