import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/index.dart';
import 'package:teta_front_end/teta_front_end.dart';
import 'package:theta_models/theta_models.dart';

class AValidatorControl extends StatelessWidget {
  const AValidatorControl({
    required this.action,
    required this.callback,
    final Key? key,
  }) : super(key: key);

  final FActionElement action;
  final Function(FActionElement, FActionElement) callback;

  @override
  Widget build(final BuildContext context) {
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
        BlocBuilder<PageCubit, PageState>(
          builder: (final context, final state) {
            if (state is! PageLoaded) return const SizedBox();
            return CDropdown(
              value: state.states
                          .map((final e) => e.name)
                          .where((final element) => element != 'null')
                          .toList()
                          .indexWhere(
                            (final e) => e == action.stateName,
                          ) !=
                      -1
                  ? action.stateName
                  : null,
              items: state.states
                  .where((final element) => element.type == VariableType.string)
                  .map((final e) => e.name)
                  .where((final element) => element != 'null')
                  .toList(),
              onChange: (final newValue) {
                if (newValue != null) {
                  final old = action;
                  action.stateName = newValue;
                  callback(action, old);
                }
              },
            );
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
        BlocBuilder<PageCubit, PageState>(
          builder: (final context, final state) {
            if (state is! PageLoaded) return const SizedBox();
            return CDropdown(
              value: state.states
                          .where(
                            (final element) =>
                                element.type == VariableType.string,
                          )
                          .map((final e) => e.name)
                          .where((final element) => element != 'null')
                          .toList()
                          .indexWhere(
                            (final e) => e == action.stateName2,
                          ) !=
                      -1
                  ? action.stateName2
                  : null,
              items: state.states
                  .map((final e) => e.name)
                  .where((final element) => element != 'null')
                  .toList(),
              onChange: (final newValue) {
                if (newValue != null) {
                  final old = action;
                  action.stateName2 = newValue;
                  callback(action, old);
                }
              },
            );
          },
        ),
      ],
    );
  }
}
