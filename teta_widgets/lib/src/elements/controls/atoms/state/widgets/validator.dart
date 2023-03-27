import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:teta_front_end/teta_front_end.dart';
import 'package:teta_models/teta_models.dart';

import '../../../../actions/state/state_validator_params.dart';

class StateValidatorControl extends StatefulWidget {
  const StateValidatorControl({
    final Key? key,
    required this.params,
    required this.onStateNameChanged,
  }) : super(key: key);

  final StateValidatorParams params;
  final Function(String? stateName, String? stateName2) onStateNameChanged;

  @override
  State<StateValidatorControl> createState() => _StateValidatorControlState();
}

class _StateValidatorControlState extends State<StateValidatorControl> {
  String? stateName;
  String? stateName2;

  void updateParams() {
    widget.onStateNameChanged(stateName, stateName2);
  }

  @override
  Widget build(final BuildContext context) {
    final pageLoaded = context.read<PageCubit>().state as PageLoaded;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TParagraph('Text variable'),
        const Gap(Grid.small),
        TDetailLabel(
          'Variable where is stored the String value to check.',
          color: Palette.txtPrimary.withOpacity(0.6),
        ),
        const Gap(Grid.medium),
        CDropdown(
          value: pageLoaded.states
                      .map((final e) => e.name)
                      .where((final element) => element != 'null')
                      .toList()
                      .indexWhere(
                        (final e) => e == widget.params.stateName,
                      ) !=
                  -1
              ? widget.params.stateName
              : null,
          items: pageLoaded.states
              .where((final element) => element.type == VariableType.string)
              .map((final e) => e.name)
              .where((final element) => element != 'null')
              .toList(),
          onChange: (final newValue) {
            stateName = newValue;
            updateParams();
          },
        ),
        const Gap(Grid.medium),
        const TParagraph('Status variable'),
        const Gap(Grid.small),
        TDetailLabel(
          'This variable will receive the result of this validator.',
          color: Palette.txtPrimary.withOpacity(0.6),
        ),
        const Gap(Grid.medium),
        CDropdown(
          value: pageLoaded.states
                      .where((final e) => e.type == VariableType.string)
                      .map((final e) => e.name)
                      .where((final element) => element != 'null')
                      .toList()
                      .indexWhere((final e) => e == widget.params.stateName2) !=
                  -1
              ? widget.params.stateName2
              : null,
          items: pageLoaded.states
              .map((final e) => e.name)
              .where((final element) => element != 'null')
              .toList(),
          onChange: (final newValue) {
            stateName2 = newValue;
            updateParams();
          },
        ),
      ],
    );
  }
}
