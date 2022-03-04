// Flutter imports:
// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
// Project imports:
import 'package:teta_core/src/blocs/focus/index.dart';
import 'package:teta_core/src/design_system/dropdowns/dropdown.dart';
import 'package:teta_core/src/design_system/dropdowns/dropdown_for_type.dart';
import 'package:teta_core/src/design_system/palette.dart';
import 'package:teta_core/src/design_system/text.dart';
import 'package:teta_core/src/design_system/textfield/textfield.dart';
import 'package:teta_core/src/models/page.dart';
import 'package:teta_elements/src/elements/features/text_type_input.dart';
import 'package:teta_elements/src/elements/nodes/node.dart';

class FirestoreParameterControl extends StatefulWidget {
  const FirestoreParameterControl({
    Key? key,
    this.node,
    required this.page,
    required this.title,
    required this.value,
    required this.callBack,
  }) : super(key: key);

  final CNode? node;
  final PageObject page;
  final String title;
  final FTextTypeInput value;
  final Function(FTextTypeInput, FTextTypeInput) callBack;

  @override
  ParameterState createState() => ParameterState();
}

class ParameterState extends State<FirestoreParameterControl> {
  int? nodeId;
  bool? isUpdated;
  String? text;
  TextEditingController controller = TextEditingController();
  String databaseName = '';
  String databaseAttribute = '';
  FTextTypeEnum typeOfInput = FTextTypeEnum.text;

  @override
  void initState() {
    try {
      nodeId = widget.node?.nid;
      text = widget.value.value ?? '';
      controller.text = text!;
      typeOfInput = widget.value.type!;
      databaseName = widget.value.datasetName!;
      databaseAttribute = widget.value.datasetAttr!;
    } catch (_) {}
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //controller.text = widget.value!.value ?? '';
    return BlocListener<FocusBloc, List<CNode>>(
      listener: (context, state) {
        if (state.isNotEmpty) {
          if (state.first.nid != nodeId) {
            setState(() {
              isUpdated = true;
              controller.text = widget.value.value ?? '';
            });
            nodeId = state.first.nid;
          }
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white12,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.only(top: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CText(
                  widget.title,
                  color: Palette.white,
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
                  onChange: (value) {
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
                hpadding: 0,
                //text: text,
                controller: controller,
                callBack: (value) {
                  final old = widget.value;
                  widget.value.value = value;
                  widget.callBack(widget.value, old);
                },
              ),
            if (widget.value.type == FTextTypeEnum.param)
              CDropdown(
                value: widget.page.params
                        .map((e) => e.name)
                        .contains(widget.value.paramName)
                    ? widget.value.paramName
                    : null,
                items: widget.page.params.map((e) => e.get as String).toList(),
                onChange: (newValue) {
                  final old = widget.value;
                  widget.value.paramName = newValue;
                  widget.callBack(widget.value, old);
                },
              ),
            if (widget.value.type == FTextTypeEnum.state)
              CDropdown(
                value: widget.page.states
                        .map((e) => e.name)
                        .contains(widget.value.stateName)
                    ? widget.value.stateName
                    : null,
                items: widget.page.states.map((e) => e.get as String).toList(),
                onChange: (newValue) {
                  final old = widget.value;
                  widget.value.stateName = newValue;
                  widget.callBack(widget.value, old);
                },
              ),
            if (widget.value.type == FTextTypeEnum.dataset)
              CDropdown(
                value: widget.page.datasets
                        .map((e) => e.getName)
                        .where((element) => element != 'null')
                        .contains(widget.value.datasetName)
                    ? widget.value.datasetName
                    : null,
                items: widget.page.datasets
                    .map((e) => e.getName)
                    .where((element) => element != 'null')
                    .toList(),
                onChange: (newValue) {
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
                value: widget.page.datasets
                        .firstWhere(
                          (element) =>
                              element.getName == widget.value.datasetName,
                        )
                        .getMap
                        .first
                        .keys
                        .map((key) => key)
                        .toSet()
                        .contains(widget.value.datasetAttr)
                    ? widget.value.datasetAttr
                    : null,
                items: widget.page.datasets
                    .firstWhere(
                      (element) => element.getName == widget.value.datasetName,
                    )
                    .getMap
                    .first
                    .keys
                    .map((key) => key)
                    .toSet()
                    .toList(),
                onChange: (newValue) {
                  setState(() {
                    databaseAttribute = newValue!;
                  });
                  final old = widget.value;
                  widget.value.datasetAttr = newValue;
                  widget.callBack(widget.value, old);
                },
              ),
          ],
        ),
      ),
    );
  }
}
