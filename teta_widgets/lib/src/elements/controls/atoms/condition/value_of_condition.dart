// Flutter imports:
// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
// Project imports:
import 'package:teta_core/src/blocs/focus/index.dart';
import 'package:teta_core/src/design_system/palette.dart';
import 'package:teta_core/src/design_system/text.dart';
import 'package:teta_core/src/design_system/textfield/textfield.dart';
import 'package:teta_core/src/models/page.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';

class ValueOfConditionControl extends StatefulWidget {
  /// Constructor
  const ValueOfConditionControl({
    required this.node,
    required this.page,
    required this.title,
    required this.valueOfCond,
    required this.callBack,
    Key? key,
  }) : super(key: key);

  final CNode node;
  final PageObject page;
  final String title;
  final FTextTypeInput valueOfCond;
  final Function(FTextTypeInput, FTextTypeInput) callBack;

  @override
  ValueOfConditionControlState createState() => ValueOfConditionControlState();
}

class ValueOfConditionControlState extends State<ValueOfConditionControl> {
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
      nodeId = widget.node.nid;
      text = widget.valueOfCond.value ?? '';
      controller.text = text!;
      typeOfInput = widget.valueOfCond.type!;
      databaseName = widget.valueOfCond.datasetName!;
      databaseAttribute = widget.valueOfCond.datasetAttr!;
    } catch (_) {}
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //controller.text = widget.node.valueOfCond!.value ?? '';
    return BlocListener<FocusBloc, List<CNode>>(
      listener: (context, state) {
        if (state.first.nid != nodeId) {
          setState(() {
            isUpdated = true;
            controller.text = widget.valueOfCond.value ?? '';
          });
          nodeId = state.first.nid;
        }
      },
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
              Theme(
                data: Theme.of(context).copyWith(
                  canvasColor: const Color(0xFF333333),
                ),
                child: DropdownButton<String>(
                  underline: const SizedBox(),
                  value: widget.valueOfCond.type == FTextTypeEnum.dataset
                      ? 'dataset'
                      : widget.valueOfCond.type == FTextTypeEnum.state
                          ? 'state'
                          : widget.valueOfCond.type == FTextTypeEnum.param
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
                    final old = widget.valueOfCond;
                    final newValue = widget.valueOfCond..type = typeOfInput;
                    widget.callBack(newValue, old);
                  },
                ),
              ),
            ],
          ),
          if (widget.valueOfCond.type == FTextTypeEnum.text)
            CTextField(
              //text: text,
              controller: controller,
              callBack: (value) {
                final old = widget.valueOfCond;
                widget.valueOfCond.value = value;
                widget.callBack(widget.valueOfCond, old);
              },
            ),
          if (widget.valueOfCond.type == FTextTypeEnum.param)
            Container(
              width: double.maxFinite,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButton<String>(
                value: widget.valueOfCond.paramName,
                icon: const Icon(Icons.arrow_drop_down),
                underline: const SizedBox(),
                onChanged: (String? newValue) {
                  final old = widget.valueOfCond;
                  widget.valueOfCond.paramName = newValue;
                  widget.callBack(widget.valueOfCond, old);
                },
                isDense: true,
                isExpanded: true,
                items: widget.page.params
                    .map((e) => e.name)
                    .map<DropdownMenuItem<String>>((value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: CText(value, size: 16),
                  );
                }).toList(),
              ),
            ),
          if (widget.valueOfCond.type == FTextTypeEnum.state)
            Container(
              width: double.maxFinite,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButton<String>(
                value: widget.valueOfCond.stateName,
                icon: const Icon(Icons.arrow_drop_down),
                underline: const SizedBox(),
                onChanged: (String? newValue) {
                  final old = widget.valueOfCond;
                  widget.valueOfCond.stateName = newValue;
                  widget.callBack(widget.valueOfCond, old);
                },
                isDense: true,
                isExpanded: true,
                items: widget.page.states
                    .map((e) => e.name)
                    .map<DropdownMenuItem<String>>((value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: CText(value, size: 16),
                  );
                }).toList(),
              ),
            ),
          if (widget.valueOfCond.type == FTextTypeEnum.dataset)
            Container(
              width: double.maxFinite,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButton<String>(
                value: widget.valueOfCond.datasetName,
                icon: const Icon(Icons.arrow_drop_down),
                underline: const SizedBox(),
                onChanged: (String? newValue) {
                  setState(() {
                    databaseName = newValue!;
                  });
                  final old = widget.valueOfCond;
                  widget.valueOfCond.datasetName = newValue;
                  widget.callBack(widget.valueOfCond, old);
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
          if (widget.valueOfCond.type == FTextTypeEnum.dataset &&
              widget.valueOfCond.datasetName != null)
            Container(
              margin: const EdgeInsets.only(top: 8),
              width: double.maxFinite,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButton<String>(
                value: widget.valueOfCond.datasetAttr,
                icon: const Icon(Icons.arrow_drop_down),
                underline: const SizedBox(),
                onChanged: (String? newValue) {
                  setState(() {
                    databaseAttribute = newValue!;
                  });
                  final old = widget.valueOfCond;
                  widget.valueOfCond.datasetAttr = newValue;
                  widget.callBack(widget.valueOfCond, old);
                },
                isDense: true,
                isExpanded: true,
                items: widget.page.datasets
                    .firstWhere(
                      (element) =>
                          element.getName == widget.valueOfCond.datasetName,
                    )
                    .getMap
                    .first
                    .keys
                    .map((key) => key)
                    .toSet()
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: CText(value, size: 16),
                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }
}
