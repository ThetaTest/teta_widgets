import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/controls/atoms/text.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/revenue_cat.dart';
import 'package:teta_widgets/src/elements/index.dart';
import 'package:teta_widgets/src/elements/nodes/dynamic.dart';
import 'package:teta_front_end/teta_front_end.dart';
import 'package:theta_models/theta_models.dart';

class RevenueCatBuyActionWidget extends StatelessWidget {
  const RevenueCatBuyActionWidget({
    required this.element,
    required this.callback,
    final Key? key,
  }) : super(key: key);

  final FActionElement element;
  final Function(FActionElement, FActionElement) callback;

  @override
  Widget build(final BuildContext context) {
    return Column(
      children: [
        BlocBuilder<ConfigCubit, ConfigState>(
          builder: (final context, final state) {
            if (state is! ConfigStateLoaded) return const SizedBox();
            return CDropdown(
              value: FActionElement.convertValueToDropdown(
                element.actionRevenueCat,
              ),
              items:
                  FActionElement.getRevenueCat(state.config).toSet().toList(),
              onChange: (final newValue) {
                if (newValue != null) {
                  final old = element;
                  element.actionRevenueCat =
                      FActionElement.convertDropdownToValue(
                    ActionRevenueCat.values,
                    newValue,
                  ) as ActionRevenueCat?;
                  callback(element, old);
                }
              },
            );
          },
        ),
        const Gap(Grid.medium),
        if (element.actionRevenueCat == ActionRevenueCat.buy)
          SizedBox(
            width: double.maxFinite,
            child: TextControl(
              valueType: VariableType.string,
              value: element.revenueCatProductIdentifier ?? FTextTypeInput(),
              title: 'Prod Identifier',
              callBack: (final value, final old) {
                final old = element;
                element.revenueCatProductIdentifier = value;
                callback(element, old);
              },
            ),
          )
        else
          Column(
            children: [
              const THeadline3(
                'Choose a variable to save the status of the operation',
              ),
              TDetailLabel(
                "The selected variable is set to 'Loading' during the operation, to 'Successful' if the payment is successful and to 'Failed' if it is not successful. The variable must be of String type.",
                color: Palette.txtPrimary.withOpacity(0.6),
              ),
              const Gap(Grid.small),
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
                                .where((final element) => element != 'null')
                                .toList()
                                .indexWhere(
                                  (final e) => e == element.stateName,
                                ) !=
                            -1
                        ? element.stateName
                        : null,
                    items: state.states
                        .map((final e) => e.name)
                        .where((final element) => element != 'null')
                        .toList(),
                    onChange: (final newValue) {
                      if (newValue != null) {
                        try {
                          final old = element;
                          element.stateName = newValue;
                          callback(element, old);
                        } catch (_) {}
                      }
                    },
                  );
                },
              ),
            ],
          ),
      ],
    );
  }
}
