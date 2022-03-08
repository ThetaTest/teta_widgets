// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/src/design_system/dropdowns/dropdown.dart';
import 'package:teta_core/src/design_system/dropdowns/dropdown_for_type.dart';
import 'package:teta_core/src/design_system/textfield/textfield.dart';
import 'package:teta_core/src/models/page.dart';
// Project imports:
import 'package:teta_widgets/src/elements/features/text_type_input.dart';

class AddDataElement extends StatefulWidget {
  const AddDataElement({
    required this.name,
    required this.value,
    required this.page,
    required this.callback,
    final Key? key,
  }) : super(key: key);

  final String name;
  final Map<String, dynamic> value;
  final PageObject page;
  final Function(Map<String, dynamic>, Map<String, dynamic>) callback;

  @override
  AddDataElementState createState() => AddDataElementState();
}

class AddDataElementState extends State<AddDataElement> {
  TextEditingController nameController = TextEditingController();
  TextEditingController valueController = TextEditingController();
  FTextTypeInput value = FTextTypeInput();
  String databaseName = '';
  String databaseAttribute = '';

  @override
  void initState() {
    value = FTextTypeInput.fromJson(widget.value);
    nameController.text = widget.name;
    valueController.text = value.value ?? '';
    super.initState();
  }

  @override
  Widget build(final BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CTextField(
            hpadding: 0,
            controller: nameController,
            callBack: (final v) {
              final old = widget.value;
              value.value = v;
              widget.callback(widget.value, old);
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CDropdownForType(
                value: value.type == FTextTypeEnum.dataset
                    ? 'dataset'
                    : value.type == FTextTypeEnum.state
                        ? 'state'
                        : value.type == FTextTypeEnum.param
                            ? 'param'
                            : 'text',
                items: const ['text', 'param', 'state', 'dataset'],
                onChange: (final v) {
                  var typeOfInput = FTextTypeEnum.text;
                  if (v == 'text') {
                    typeOfInput = FTextTypeEnum.text;
                  }
                  if (v == 'param') {
                    typeOfInput = FTextTypeEnum.param;
                  }
                  if (v == 'state') {
                    typeOfInput = FTextTypeEnum.state;
                  }
                  if (v == 'dataset') {
                    typeOfInput = FTextTypeEnum.dataset;
                  }
                  final old = value;
                  final newValue = value..type = typeOfInput;
                  widget.callback(newValue.toJson(), old.toJson());
                },
              ),
            ],
          ),
          if (value.type == FTextTypeEnum.text)
            CTextField(
              hpadding: 0,
              //text: text,
              controller: valueController,
              callBack: (final v) {
                final old = value;
                value.value = v;
                widget.callback(value.toJson(), old.toJson());
              },
            ),
          if (value.type == FTextTypeEnum.param)
            CDropdown(
              value: widget.page.params
                      .map((final e) => e.name)
                      .contains(value.paramName)
                  ? value.paramName
                  : null,
              items:
                  widget.page.params.map((final e) => e.get as String).toList(),
              onChange: (final newValue) {
                final old = value;
                value.paramName = newValue;
                widget.callback(value.toJson(), old.toJson());
              },
            ),
          if (value.type == FTextTypeEnum.state)
            CDropdown(
              value: widget.page.states
                      .map((final e) => e.name)
                      .contains(value.stateName)
                  ? value.stateName
                  : null,
              items: widget.page.states.map((final e) => e.name).toList(),
              onChange: (final newValue) {
                final old = value;
                value.stateName = newValue;
                widget.callback(value.toJson(), old.toJson());
              },
            ),
          if (value.type == FTextTypeEnum.dataset)
            CDropdown(
              value: widget.page.datasets
                      .map((final e) => e.getName)
                      .where((final element) => element != 'null')
                      .contains(value.datasetName)
                  ? value.datasetName
                  : null,
              items: widget.page.datasets
                  .map((final e) => e.getName)
                  .where((final element) => element != 'null')
                  .toList(),
              onChange: (final newValue) {
                setState(() {
                  databaseName = newValue!;
                });
                final old = value;
                value.datasetName = newValue;
                widget.callback(value.toJson(), old.toJson());
              },
            ),
          if (value.type == FTextTypeEnum.dataset && value.datasetName != null)
            CDropdown(
              value: widget.page.datasets
                      .firstWhere(
                        (final element) => element.getName == value.datasetName,
                      )
                      .getMap
                      .first
                      .keys
                      .toSet()
                      .contains(value.datasetAttr)
                  ? value.datasetAttr
                  : null,
              items: widget.page.datasets
                  .firstWhere(
                    (final element) => element.getName == value.datasetName,
                  )
                  .getMap
                  .first
                  .keys
                  .toSet()
                  .toList(),
              onChange: (final newValue) {
                setState(() {
                  databaseAttribute = newValue!;
                });
                final old = value;
                value.datasetAttr = newValue;
                widget.callback(value.toJson(), old.toJson());
              },
            ),
        ],
      ),
    );
  }
}
