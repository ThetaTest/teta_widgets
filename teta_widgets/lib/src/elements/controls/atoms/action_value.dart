// Flutter imports:
// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_core/src/design_system/palette.dart';
import 'package:teta_core/src/design_system/text.dart';
import 'package:teta_core/src/design_system/textfield/textfield.dart';
import 'package:teta_core/src/models/page.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';

class ActionvalueControl extends StatefulWidget {
  const ActionvalueControl({
    required this.node,
    required this.page,
    required this.title,
    required this.actionValue,
    required this.callBack,
    Key? key,
  }) : super(key: key);

  final CNode node;
  final PageObject page;
  final String title;
  final FTextTypeInput actionValue;
  final Function(FTextTypeInput, FTextTypeInput) callBack;

  @override
  PaddingsState createState() => PaddingsState();
}

class PaddingsState extends State<ActionvalueControl> {
  String? text;
  TextEditingController controller = TextEditingController();
  String databaseName = '';
  String databaseAttribute = '';
  FTextTypeEnum typeOfInput = FTextTypeEnum.text;

  @override
  void initState() {
    text = widget.actionValue.value ?? '';
    controller.text = text!;
    typeOfInput = widget.actionValue.type ?? FTextTypeEnum.text;
    if (widget.actionValue.datasetName != null) {
      databaseName = widget.actionValue.datasetName!;
    }
    if (widget.actionValue.datasetAttr != null) {
      databaseAttribute = widget.actionValue.datasetAttr!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CText(
              widget.title,
              color: Palette.white,
            ),
            Theme(
              data: Theme.of(context).copyWith(
                canvasColor: const Color(0xFF333333),
              ),
              child: DropdownButton<String>(
                underline: const SizedBox(),
                value: widget.actionValue.type == FTextTypeEnum.dataset
                    ? 'dataset'
                    : widget.actionValue.type == FTextTypeEnum.state
                        ? 'state'
                        : widget.actionValue.type == FTextTypeEnum.param
                            ? 'param'
                            : 'text',
                items:
                    ['text', 'param', 'state', 'dataset'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: CText(
                      value,
                      color: Palette.white,
                    ),
                  );
                }).toList(),
                onChanged: (value) {
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
                  final old = widget.actionValue;
                  final newValue = widget.actionValue..type = typeOfInput;
                  widget.callBack(newValue, old);
                },
              ),
            ),
          ],
        ),
        if (widget.actionValue.type == FTextTypeEnum.text)
          CTextField(
            text: text,
            controller: controller,
            callBack: (value) {
              final old = widget.actionValue;
              widget.actionValue.value = value;
              widget.callBack(widget.actionValue, old);
            },
          ),
        if (widget.actionValue.type == FTextTypeEnum.param)
          Container(
            width: double.maxFinite,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButton<String>(
              value: widget.page.states
                      .map((e) => e.name)
                      .contains(widget.actionValue.paramName)
                  ? widget.actionValue.stateName
                  : null,
              icon: const Icon(Icons.arrow_drop_down),
              underline: const SizedBox(),
              onChanged: (String? newValue) {},
              isDense: true,
              isExpanded: true,
              items: widget.page.params
                  .map((e) => e.name)
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: CText(value, size: 16),
                );
              }).toList(),
            ),
          ),
        if (widget.actionValue.type == FTextTypeEnum.state)
          Container(
            width: double.maxFinite,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButton<String>(
              value: widget.page.states
                      .map((e) => e.name)
                      .contains(widget.actionValue.stateName)
                  ? widget.actionValue.stateName
                  : null,
              icon: const Icon(Icons.arrow_drop_down),
              underline: const SizedBox(),
              onChanged: (String? newValue) {},
              isDense: true,
              isExpanded: true,
              items: widget.page.states
                  .map((e) => e.name)
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: CText(value, size: 16),
                );
              }).toList(),
            ),
          ),
        if (widget.actionValue.type == FTextTypeEnum.dataset)
          Container(
            width: double.maxFinite,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButton<String>(
              value: widget.page.datasets
                      .map((e) => e.getName)
                      .where((element) => element != 'null')
                      .contains(widget.actionValue.datasetName)
                  ? widget.actionValue.datasetName
                  : null,
              icon: const Icon(Icons.arrow_drop_down),
              underline: const SizedBox(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    databaseName = newValue;
                  });
                  final old = widget.actionValue;
                  widget.actionValue.datasetName = newValue;
                  widget.callBack(widget.actionValue, old);
                }
              },
              isDense: true,
              isExpanded: true,
              items: widget.page.datasets
                  .map((e) => e.getName)
                  .where((element) => element != 'null')
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: CText(value, size: 16),
                );
              }).toList(),
            ),
          ),
        if (widget.actionValue.type == FTextTypeEnum.dataset &&
            widget.actionValue.datasetName != null)
          Container(
            margin: const EdgeInsets.only(top: 8),
            width: double.maxFinite,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButton<String>(
              value: widget.page.datasets
                      .firstWhere(
                        (element) =>
                            element.getName == widget.actionValue.datasetName,
                      )
                      .getMap
                      .first
                      .keys
                      .contains(widget.actionValue.datasetAttr)
                  ? widget.actionValue.datasetAttr
                  : null,
              icon: const Icon(Icons.arrow_drop_down),
              underline: const SizedBox(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    databaseAttribute = newValue;
                  });
                  final old = widget.actionValue;
                  widget.actionValue.datasetAttr = newValue;
                  widget.callBack(widget.actionValue, old);
                }
              },
              isDense: true,
              isExpanded: true,
              items: widget.page.datasets
                  .firstWhere(
                    (element) =>
                        element.getName == widget.actionValue.datasetName,
                  )
                  .getMap
                  .first
                  .keys
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: CText(value, size: 16),
                );
              }).toList(),
            ),
          ),
      ],
    );
  }
}
