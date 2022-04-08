// Flutter imports:
// ignore_for_file: public_member_api_docs

// Package imports:
import 'package:collection/collection.dart';
// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_core/src/design_system/textfield/minitextfield.dart';
import 'package:teta_core/src/design_system/textfield/textfield.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';

class TextControl extends StatefulWidget {
  const TextControl({
    required this.node,
    required this.value,
    required this.page,
    required this.title,
    required this.callBack,
    final Key? key,
  }) : super(key: key);

  final CNode node;
  final FTextTypeInput value;
  final PageObject page;
  final String title;
  final Function(FTextTypeInput, FTextTypeInput) callBack;

  @override
  PaddingsState createState() => PaddingsState();
}

class PaddingsState extends State<TextControl> {
  int? nodeId;
  bool? isUpdated;
  String? text;
  TextEditingController controller = TextEditingController();
  TextEditingController keyController = TextEditingController();
  String databaseName = '';
  String databaseAttribute = '';
  FTextTypeEnum typeOfInput = FTextTypeEnum.text;

  @override
  void initState() {
    nodeId = widget.node.nid;
    try {
      text = widget.value.value ?? '';
      controller.text = text!;
      typeOfInput = widget.value.type!;
      if (widget.value.datasetName != null) {
        databaseName = widget.value.datasetName!;
      }
      databaseAttribute = widget.value.datasetAttr!;
    } catch (_) {}
    keyController.text = widget.value.mapKey ?? '';
    super.initState();
  }

  @override
  Widget build(final BuildContext context) {
    final index = widget.page.datasets.indexWhere(
        (final element) => element.getName == widget.value.datasetName);
    final dataset =
        index != -1 ? widget.page.datasets[index] : DatasetObject.empty();
    return BlocBuilder<FocusBloc, List<CNode>>(
      builder: (final context, final state) {
        if (state.isNotEmpty) {
          if (state.first.nid != nodeId) {
            if (mounted) {
              nodeId = state.first.nid;
              controller.text = controller.text = widget.value.value ?? '';
            }
          }
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                THeadline3(
                  widget.title,
                ),
                CDropdownForType(
                  value: widget.value.type == FTextTypeEnum.dataset
                      ? 'dataset'
                      : widget.value.type == FTextTypeEnum.state
                          ? 'state'
                          : widget.value.type == FTextTypeEnum.param
                              ? 'param'
                              : 'text',
                  items: const ['text', 'param', 'state', 'dataset'],
                  onChange: (final value) {
                    var typeOfInput = FTextTypeEnum.text;
                    if (value == 'text') {
                      typeOfInput = FTextTypeEnum.text;
                    }
                    if (value == 'param') {
                      typeOfInput = FTextTypeEnum.param;
                    }
                    if (value == 'state') {
                      typeOfInput = FTextTypeEnum.state;
                    }
                    if (value == 'dataset') {
                      typeOfInput = FTextTypeEnum.dataset;
                    }
                    final old = widget.value;
                    final newValue = widget.value..type = typeOfInput;
                    widget.callBack(newValue, old);
                  },
                ),
              ],
            ),
            if (widget.value.type == FTextTypeEnum.text)
              CTextField(
                //text: text,
                controller: controller,
                bgColor: Palette.bgGrey,
                callBack: (final value) {
                  value.replaceAll(r'\', r'\\');
                  final old = widget.value;
                  widget.value.value = value;
                  widget.callBack(widget.value, old);
                },
                onSubmitted: (final value) {
                  value.replaceAll(r'\', r'\\');
                  final old = widget.value;
                  widget.value.value = value;
                  widget.callBack(widget.value, old);
                },
              ),
            if (widget.value.type == FTextTypeEnum.param)
              Column(
                children: [
                  CDropdown(
                    value: widget.page.params
                            .map((final e) => e.name)
                            .contains(widget.value.paramName)
                        ? widget.value.paramName
                        : null,
                    items: widget.page.params.map((final e) => e.name).toList(),
                    onChange: (final newValue) {
                      final old = widget.value;
                      widget.value.paramName = newValue;
                      widget.callBack(widget.value, old);
                    },
                  ),
                  if ((widget.page.params
                              .firstWhereOrNull(
                                (final element) =>
                                    element.name == widget.value.paramName,
                              )
                              ?.type ??
                          VariableType.int) ==
                      VariableType.json)
                    CTextField(
                      controller: keyController,
                      title: 'Map Key',
                      callBack: (final key) {
                        final old = widget.value;
                        widget.value.mapKey = key;
                        widget.callBack(widget.value, old);
                      },
                    ),
                ],
              ),
            if (widget.value.type == FTextTypeEnum.state)
              Column(
                children: [
                  CDropdown(
                    value: widget.page.states
                            .map((final e) => e.name)
                            .contains(widget.value.stateName)
                        ? widget.value.stateName
                        : null,
                    items: widget.page.states.map((final e) => e.name).toList(),
                    onChange: (final newValue) {
                      final old = widget.value;
                      widget.value.stateName = newValue;
                      widget.callBack(widget.value, old);
                    },
                  ),
                  if (widget.page.states
                          .firstWhereOrNull(
                            (final element) =>
                                element.name == widget.value.stateName,
                          )
                          ?.type ==
                      VariableType.json)
                    CMiniTextField(
                      text: widget.value.mapKey,
                      title: 'Map Key',
                      callBack: (final key) {
                        final old = widget.value;
                        widget.value.mapKey = key;
                        widget.callBack(widget.value, old);
                      },
                    ),
                ],
              ),
            if (widget.value.type == FTextTypeEnum.dataset &&
                widget.page.datasets.isNotEmpty)
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
            if (widget.value.type == FTextTypeEnum.dataset &&
                widget.value.datasetName != null)
              CDropdown(
                value: (dataset.getMap.isNotEmpty
                            ? dataset.getMap.first
                            : <String, dynamic>{})
                        .keys
                        .toSet()
                        .contains(widget.value.datasetAttr)
                    ? widget.value.datasetAttr
                    : null,
                items: (dataset.getMap.isNotEmpty
                        ? dataset.getMap.first
                        : <String, dynamic>{})
                    .keys
                    .toSet()
                    .toList(),
                onChange: (final newValue) {
                  setState(() {
                    databaseAttribute = newValue!;
                  });
                  final old = widget.value;
                  widget.value.datasetAttr = newValue;
                  widget.callBack(widget.value, old);
                },
              ),
          ],
        );
      },
    );
  }
}
