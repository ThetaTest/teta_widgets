import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/index.dart';

class AValidatorControl extends StatelessWidget {
  const AValidatorControl({
    final Key? key,
    required this.page,
    required this.action,
    required this.callback,
  }) : super(key: key);

  final PageObject page;
  final FActionElement action;
  final Function(FActionElement, FActionElement) callback;

  @override
  Widget build(final BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const THeadline3('Text variable'),
        const Gap(Grid.small),
        TDetailLabel(
          'Variable where is stored the String value to check.',
          color: Palette.txtPrimary.withOpacity(0.6),
        ),
        const Gap(Grid.medium),
        CDropdown(
          value: page.states
                      .map((final e) => e.name)
                      .where((final element) => element != 'null')
                      .toList()
                      .indexWhere(
                        (final e) => e == action.stateName,
                      ) !=
                  -1
              ? action.stateName
              : null,
          items: page.states
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
        ),
        const Gap(Grid.medium),
        const THeadline3('Status variable'),
        const Gap(Grid.small),
        TDetailLabel(
          'This variable will receive the result of this validator.',
          color: Palette.txtPrimary.withOpacity(0.6),
        ),
        const Gap(Grid.medium),
        CDropdown(
          value: page.states
                      .where(
                        (final element) => element.type == VariableType.string,
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
          items: page.states
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
        ),
      ],
    );
  }
}
