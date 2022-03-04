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
import 'package:teta_core/src/models/page.dart';
import 'package:teta_core/src/models/variable.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';

class CameraControllerControl extends StatefulWidget {
  const CameraControllerControl({
    Key? key,
    required this.node,
    required this.value,
    required this.page,
    required this.title,
    required this.callBack,
  }) : super(key: key);

  final CNode node;
  final FTextTypeInput value;
  final PageObject page;
  final String title;
  final Function(FTextTypeInput, FTextTypeInput) callBack;

  @override
  CameraControllerControlState createState() => CameraControllerControlState();
}

class CameraControllerControlState extends State<CameraControllerControl> {
  int? nodeId;
  bool? isUpdated;
  String? text;
  TextEditingController controller = TextEditingController();
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
      databaseName = widget.value.datasetName!;
      databaseAttribute = widget.value.datasetAttr!;
    } catch (_) {}
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FocusBloc, List<CNode>>(
      builder: (context, state) {
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
                CText(
                  widget.title,
                  color: Palette.white,
                  weight: FontWeight.bold,
                ),
                CDropdownForType(
                  value: widget.value.type == FTextTypeEnum.state
                      ? 'state'
                      : 'param',
                  items: const ['param', 'state'],
                  onChange: (value) {
                    var typeOfInput = FTextTypeEnum.text;
                    if (value == 'param') {
                      typeOfInput = FTextTypeEnum.param;
                    }
                    if (value == 'state') {
                      typeOfInput = FTextTypeEnum.state;
                    }
                    final old = widget.value;
                    final newValue = widget.value..type = typeOfInput;
                    widget.callBack(newValue, old);
                  },
                ),
              ],
            ),
            if (widget.value.type == FTextTypeEnum.param)
              CDropdown(
                value: widget.page.params
                        .map((e) => e.name)
                        .contains(widget.value.paramName)
                    ? widget.value.paramName
                    : null,
                items: widget.page.params
                    .where(
                      (element) =>
                          element.type == VariableType.cameraController,
                    )
                    .map((e) => e.name)
                    .toList(),
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
                items: widget.page.states
                    .where(
                      (element) =>
                          element.type == VariableType.cameraController,
                    )
                    .map((e) => e.name)
                    .toList(),
                onChange: (newValue) {
                  final old = widget.value;
                  widget.value.stateName = newValue;
                  widget.callBack(widget.value, old);
                },
              ),
          ],
        );
      },
    );
  }
}
