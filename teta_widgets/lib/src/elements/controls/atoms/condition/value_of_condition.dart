// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_front_end/src/design_system/textfield/textfield.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_front_end/teta_front_end.dart';
import 'package:teta_models/teta_models.dart';

class ValueOfConditionControl extends StatefulWidget {
  /// Constructor
  const ValueOfConditionControl({
    required this.title,
    required this.valueOfCond,
    required this.callBack,
    final Key? key,
  }) : super(key: key);
  final String title;
  final FTextTypeInput valueOfCond;
  final Function(FTextTypeInput, FTextTypeInput) callBack;

  @override
  ValueOfConditionControlState createState() => ValueOfConditionControlState();
}

class ValueOfConditionControlState extends State<ValueOfConditionControl> {
  TextEditingController controller = TextEditingController();
  String databaseName = '';
  String databaseAttribute = '';

  @override
  void initState() {
    super.initState();
    controller.text = widget.valueOfCond.value ?? '';
    databaseName = widget.valueOfCond.datasetName!;
    databaseAttribute = widget.valueOfCond.datasetAttr!;
  }

  @override
  Widget build(final BuildContext context) {
    return BlocListener<FocusBloc, List<int>>(
      listener: (final context, final state) {
        controller.text = widget.valueOfCond.value ?? '';
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
              callBack: (final value) {
                final old = widget.valueOfCond;
                widget.valueOfCond.value = value;
                widget.callBack(widget.valueOfCond, old);
              },
            ),
          BlocBuilder<PageCubit, PageState>(
            builder: (final context, final state) {
              if (state is! PageLoaded) return const SizedBox();
              if (widget.valueOfCond.type != FTextTypeEnum.param) {
                return const SizedBox();
              }
              return Container(
                width: double.maxFinite,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButton<String>(
                  value: widget.valueOfCond.paramName,
                  icon: const Icon(Icons.arrow_drop_down),
                  underline: const SizedBox(),
                  onChanged: (final String? newValue) {
                    final old = widget.valueOfCond;
                    widget.valueOfCond.paramName = newValue;
                    widget.callBack(widget.valueOfCond, old);
                  },
                  isDense: true,
                  isExpanded: true,
                  items: state.params
                      .map((final e) => e.name)
                      .map<DropdownMenuItem<String>>((final value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: TParagraph(
                        value,
                      ),
                    );
                  }).toList(),
                ),
              );
            },
          ),
          BlocBuilder<PageCubit, PageState>(
            builder: (final context, final state) {
              if (state is! PageLoaded) return const SizedBox();
              if (widget.valueOfCond.type != FTextTypeEnum.state) {
                return const SizedBox();
              }
              return Container(
                width: double.maxFinite,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButton<String>(
                  value: widget.valueOfCond.stateName,
                  icon: const Icon(Icons.arrow_drop_down),
                  underline: const SizedBox(),
                  onChanged: (final String? newValue) {
                    final old = widget.valueOfCond;
                    widget.valueOfCond.stateName = newValue;
                    widget.callBack(widget.valueOfCond, old);
                  },
                  isDense: true,
                  isExpanded: true,
                  items: state.states
                      .map((final e) => e.name)
                      .map<DropdownMenuItem<String>>((final value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: TParagraph(
                        value,
                      ),
                    );
                  }).toList(),
                ),
              );
            },
          ),
          BlocBuilder<PageCubit, PageState>(
            builder: (final context, final state) {
              if (state is! PageLoaded) return const SizedBox();
              if (widget.valueOfCond.type != FTextTypeEnum.dataset) {
                return const SizedBox();
              }
              return Container(
                width: double.maxFinite,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButton<String>(
                  value: widget.valueOfCond.datasetName,
                  icon: const Icon(Icons.arrow_drop_down),
                  underline: const SizedBox(),
                  onChanged: (final String? newValue) {
                    setState(() {
                      databaseName = newValue!;
                    });
                    final old = widget.valueOfCond;
                    widget.valueOfCond.datasetName = newValue;
                    widget.callBack(widget.valueOfCond, old);
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
              );
            },
          ),
          BlocBuilder<PageCubit, PageState>(
            builder: (final context, final state) {
              if (state is! PageLoaded) return const SizedBox();
              if (widget.valueOfCond.type == FTextTypeEnum.dataset &&
                  widget.valueOfCond.datasetName != null) {
                return Container(
                  margin: const EdgeInsets.only(top: 8),
                  width: double.maxFinite,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DropdownButton<String>(
                    value: widget.valueOfCond.datasetAttr,
                    icon: const Icon(Icons.arrow_drop_down),
                    underline: const SizedBox(),
                    onChanged: (final String? newValue) {
                      setState(() {
                        databaseAttribute = newValue!;
                      });
                      final old = widget.valueOfCond;
                      widget.valueOfCond.datasetAttr = newValue;
                      widget.callBack(widget.valueOfCond, old);
                    },
                    isDense: true,
                    isExpanded: true,
                    items: state.datasets
                        .firstWhere(
                          (final element) =>
                              element.getName == widget.valueOfCond.datasetName,
                        )
                        .getMap
                        .first
                        .keys
                        .map((final key) => key)
                        .toSet()
                        .map<DropdownMenuItem<String>>((final String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: TParagraph(
                          value,
                        ),
                      );
                    }).toList(),
                  ),
                );
              }
              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }
}
