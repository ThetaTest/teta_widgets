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
import 'package:theta_models/theta_models.dart';

class FirestoreParameterControl extends StatefulWidget {
  const FirestoreParameterControl({
    required this.page,
    required this.title,
    required this.value,
    required this.callBack,
    final Key? key,
  }) : super(key: key);

  final PageObject page;
  final String title;
  final FTextTypeInput value;
  final Function(FTextTypeInput, FTextTypeInput) callBack;

  @override
  ParameterState createState() => ParameterState();
}

class ParameterState extends State<FirestoreParameterControl> {
  TextEditingController controller = TextEditingController();
  String databaseName = '';
  String databaseAttribute = '';

  @override
  void initState() {
    controller.text = widget.value.value ?? '';
    databaseName = widget.value.datasetName!;
    databaseAttribute = widget.value.datasetAttr!;
    super.initState();
  }

  @override
  Widget build(final BuildContext context) {
    //controller.text = widget.value!.value ?? '';
    return BlocListener<FocusBloc, List<int>>(
      listener: (final context, final state) {
        if (state.isNotEmpty) {
          controller.text = widget.value.value ?? '';
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
                TParagraph(
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
                callBack: (final value) {
                  final old = widget.value;
                  widget.value.value = value;
                  widget.callBack(widget.value, old);
                },
              ),
            if (widget.value.type == FTextTypeEnum.param)
              BlocBuilder<PageCubit, PageState>(
                buildWhen: (final previous, final current) {
                  if (previous is! PageLoaded || current is! PageLoaded) {
                    return true;
                  }
                  return previous.params != current.params;
                },
                builder: (final context, final state) {
                  if (state is! PageLoaded) return const SizedBox();
                  return CDropdown(
                    value: state.params
                            .map((final e) => e.name)
                            .contains(widget.value.paramName)
                        ? widget.value.paramName
                        : null,
                    items:
                        state.params.map((final e) => e.get as String).toList(),
                    onChange: (final newValue) {
                      final old = widget.value;
                      widget.value.paramName = newValue;
                      widget.callBack(widget.value, old);
                    },
                  );
                },
              ),
            if (widget.value.type == FTextTypeEnum.state)
              BlocBuilder<PageCubit, PageState>(
                buildWhen: (final previous, final current) {
                  if (previous is! PageLoaded || current is! PageLoaded) {
                    return true;
                  }
                  return previous.states != current.states;
                },
                builder: (final context, final state) {
                  if (state is! PageLoaded) return const SizedBox();
                  return CDropdown(
                    value: state.states
                            .map((final e) => e.name)
                            .contains(widget.value.stateName)
                        ? widget.value.stateName
                        : null,
                    items:
                        state.states.map((final e) => e.get as String).toList(),
                    onChange: (final newValue) {
                      final old = widget.value;
                      widget.value.stateName = newValue;
                      widget.callBack(widget.value, old);
                    },
                  );
                },
              ),
            if (widget.value.type == FTextTypeEnum.dataset)
              BlocBuilder<PageCubit, PageState>(
                buildWhen: (final previous, final current) {
                  if (previous is! PageLoaded || current is! PageLoaded) {
                    return true;
                  }
                  return previous.datasets != current.datasets;
                },
                builder: (final context, final state) {
                  if (state is! PageLoaded) return const SizedBox();
                  return CDropdown(
                    value: state.datasets
                            .map((final e) => e.getName)
                            .where((final element) => element != 'null')
                            .contains(widget.value.datasetName)
                        ? widget.value.datasetName
                        : null,
                    items: state.datasets
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
                  );
                },
              ),
            if (widget.value.type == FTextTypeEnum.dataset &&
                widget.value.datasetName != null)
              Padding(
                padding: EI.smT,
                child: BlocBuilder<PageCubit, PageState>(
                  buildWhen: (final previous, final current) {
                    if (previous is! PageLoaded || current is! PageLoaded) {
                      return true;
                    }
                    return previous.datasets != current.datasets;
                  },
                  builder: (final context, final state) {
                    if (state is! PageLoaded) return const SizedBox();
                    return CDropdown(
                      value: state.datasets
                              .firstWhere(
                                (final element) =>
                                    element.getName == widget.value.datasetName,
                              )
                              .getMap
                              .first
                              .keys
                              .map((final key) => key)
                              .toSet()
                              .contains(widget.value.datasetAttr)
                          ? widget.value.datasetAttr
                          : null,
                      items: state.datasets
                          .firstWhere(
                            (final element) =>
                                element.getName == widget.value.datasetName,
                          )
                          .getMap
                          .first
                          .keys
                          .map((final key) => key)
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
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
