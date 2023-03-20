// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_front_end/teta_front_end.dart';

class CurrentSongControl extends StatefulWidget {
  const CurrentSongControl({
    required this.value,
    required this.title,
    required this.callBack,
    final Key? key,
  }) : super(key: key);

  final FTextTypeInput value;
  final String title;
  final Function(FTextTypeInput, FTextTypeInput) callBack;

  @override
  CurrentSongControlState createState() => CurrentSongControlState();
}

class CurrentSongControlState extends State<CurrentSongControl> {
  TextEditingController controller = TextEditingController();
  String databaseName = '';
  String databaseAttribute = '';
  FTextTypeEnum typeOfInput = FTextTypeEnum.text;

  @override
  void initState() {
    try {
      controller.text = widget.value.value ?? '';
      typeOfInput = widget.value.type!;
      databaseName = widget.value.datasetName!;
      databaseAttribute = widget.value.datasetAttr!;
    } catch (_) {}
    super.initState();
  }

  @override
  Widget build(final BuildContext context) {
    return BlocBuilder<FocusBloc, List<int>>(
      buildWhen: (final previous, final current) => current != previous,
      builder: (final context, final state) {
        if (state.isNotEmpty) {
          controller.text = controller.text = widget.value.value ?? '';
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
              BlocBuilder<PageCubit, PageState>(
                builder: (final context, final state) {
                  if (state is! PageLoaded) return const SizedBox();
                  return CDropdown(
                    value: state.page.defaultParams
                            .map((final e) => e.name)
                            .contains(widget.value.paramName)
                        ? widget.value.paramName
                        : null,
                    items: state.page.defaultParams
                        .where(
                          (final element) =>
                              element.type == VariableType.currentSongData,
                        )
                        .map((final e) => e.name)
                        .toList(),
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
                builder: (final context, final state) {
                  if (state is! PageLoaded) return const SizedBox();
                  return CDropdown(
                    value: state.page.defaultStates
                            .map((final e) => e.name)
                            .contains(widget.value.stateName)
                        ? widget.value.stateName
                        : null,
                    items: state.page.defaultStates
                        .where(
                          (final element) =>
                              element.type == VariableType.currentSongData,
                        )
                        .map((final e) => e.name)
                        .toList(),
                    onChange: (final newValue) {
                      final old = widget.value;
                      widget.value.stateName = newValue;
                      widget.callBack(widget.value, old);
                    },
                  );
                },
              ),
          ],
        );
      },
    );
  }
}
