// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_front_end/src/design_system/textfield/textfield.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_front_end/teta_front_end.dart';

class ActionvalueControl extends StatefulWidget {
  const ActionvalueControl({
    required this.title,
    required this.actionValue,
    required this.callBack,
    final Key? key,
  }) : super(key: key);

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
                items: ['text', 'param', 'state', 'dataset']
                    .map((final String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: TParagraph(
                      value,
                    ),
                  );
                }).toList(),
                onChanged: (final value) {
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
            callBack: (final value) {
              final old = widget.actionValue;
              widget.actionValue.value = value;
              widget.callBack(widget.actionValue, old);
            },
          ),
        BlocBuilder<PageCubit, PageState>(
          builder: (final context, final state) {
            if (state is! PageLoaded) return const SizedBox();
            return Column(
              children: [
                if (widget.actionValue.type == FTextTypeEnum.param)
                  Container(
                    width: double.maxFinite,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButton<String>(
                      value: state.page.defaultParams
                              .map((final e) => e.name)
                              .contains(widget.actionValue.paramName)
                          ? widget.actionValue.stateName
                          : null,
                      icon: const Icon(Icons.arrow_drop_down),
                      underline: const SizedBox(),
                      onChanged: (final String? newValue) {},
                      isDense: true,
                      isExpanded: true,
                      items: state.page.defaultParams
                          .map((final e) => e.name)
                          .map<DropdownMenuItem<String>>((final String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: TParagraph(
                            value,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                if (widget.actionValue.type == FTextTypeEnum.state)
                  Container(
                    width: double.maxFinite,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButton<String>(
                      value: state.page.defaultStates
                              .map((final e) => e.name)
                              .contains(widget.actionValue.stateName)
                          ? widget.actionValue.stateName
                          : null,
                      icon: const Icon(Icons.arrow_drop_down),
                      underline: const SizedBox(),
                      onChanged: (final String? newValue) {},
                      isDense: true,
                      isExpanded: true,
                      items: state.page.defaultStates
                          .map((final e) => e.name)
                          .map<DropdownMenuItem<String>>((final String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: TParagraph(
                            value,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                //todo: questo è il codice che mi serve nel button
                if (widget.actionValue.type == FTextTypeEnum.dataset)
                  Container(
                    width: double.maxFinite,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButton<String>(
                      value: state.datasets
                              .map((final e) => e.getName)
                              .where((final element) => element != 'null')
                              .contains(widget.actionValue.datasetName)
                          ? widget.actionValue.datasetName
                          : null,
                      icon: const Icon(Icons.arrow_drop_down),
                      underline: const SizedBox(),
                      onChanged: (final String? newValue) {
                        if (newValue != null) {
                          if (mounted) {
                            setState(() {
                              databaseName = newValue;
                            });
                          }
                          final old = widget.actionValue;
                          widget.actionValue.datasetName = newValue;
                          widget.callBack(widget.actionValue, old);
                        }
                      },
                      isDense: true,
                      isExpanded: true,
                      items: state.datasets
                          .map((final e) => e.getName)
                          .where((final element) => element != 'null')
                          .map<DropdownMenuItem<String>>((final String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: TParagraph(
                            value,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                if (widget.actionValue.type == FTextTypeEnum.dataset &&
                    widget.actionValue.datasetName != null)
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    width: double.maxFinite,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButton<String>(
                      value: state.datasets
                              .firstWhere(
                                (final element) =>
                                    element.getName ==
                                    widget.actionValue.datasetName,
                              )
                              .getMap
                              .first
                              .keys
                              .contains(widget.actionValue.datasetAttr)
                          ? widget.actionValue.datasetAttr
                          : null,
                      icon: const Icon(Icons.arrow_drop_down),
                      underline: const SizedBox(),
                      onChanged: (final String? newValue) {
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
                      items: state.datasets
                          .firstWhere(
                            (final element) =>
                                element.getName ==
                                widget.actionValue.datasetName,
                          )
                          .getMap
                          .first
                          .keys
                          .map<DropdownMenuItem<String>>((final String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: TParagraph(
                            value,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}
