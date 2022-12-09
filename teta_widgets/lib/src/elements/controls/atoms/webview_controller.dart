// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';

class WebViewControllerControl extends StatefulWidget {
  const WebViewControllerControl({
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
  WebViewControllerControlState createState() =>
      WebViewControllerControlState();
}

class WebViewControllerControlState extends State<WebViewControllerControl> {
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
  Widget build(final BuildContext context) {
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
                TParagraph(
                  widget.title,
                ),
                CDropdownForType(
                  value: widget.value.type == FTextTypeEnum.state
                      ? 'state'
                      : 'param',
                  items: const ['param', 'state'],
                  onChange: (final value) {
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
                        .map((final e) => e.name)
                        .contains(widget.value.paramName)
                    ? widget.value.paramName
                    : null,
                items: widget.page.params
                    .where(
                      (final element) =>
                          element.type == VariableType.webViewController,
                    )
                    .map((final e) => e.name)
                    .toList(),
                onChange: (final newValue) {
                  final old = widget.value;
                  widget.value.paramName = newValue;
                  widget.callBack(widget.value, old);
                },
              ),
            if (widget.value.type == FTextTypeEnum.state)
              CDropdown(
                value: widget.page.states
                        .map((final e) => e.name)
                        .contains(widget.value.stateName)
                    ? widget.value.stateName
                    : null,
                items: widget.page.states
                    .where(
                      (final element) =>
                          element.type == VariableType.webViewController,
                    )
                    .map((final e) => e.name)
                    .toList(),
                onChange: (final newValue) {
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
