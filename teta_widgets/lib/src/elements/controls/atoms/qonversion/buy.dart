import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/controls/atoms/text.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/qonversion.dart';
import 'package:teta_widgets/src/elements/index.dart';
import 'package:teta_widgets/src/elements/nodes/dynamic.dart';

class QonversionActionWidget extends StatelessWidget {
  const QonversionActionWidget({
    required this.prj,
    required this.page,
    required this.node,
    required this.element,
    required this.callback,
    final Key? key,
  }) : super(key: key);

  final ProjectObject prj;
  final NDynamic node;
  final PageObject page;
  final FActionElement element;
  final Function(FActionElement, FActionElement) callback;

  @override
  Widget build(final BuildContext context) {
    return Column(
      children: [
        CDropdown(
          value: FActionElement.convertValueToDropdown(
            element.actionQonversion,
          ),
          items: FActionElement.getQonversion(prj.config).toSet().toList(),
          onChange: (final newValue) {
            if (newValue != null) {
              final old = element;
              element.actionQonversion = FActionElement.convertDropdownToValue(
                ActionQonversion.values,
                newValue,
              ) as ActionQonversion?;
              callback(element, old);
            }
          },
        ),
        const Gap(Grid.medium),
        if (element.actionQonversion == ActionQonversion.buy)
          SizedBox(
            width: double.maxFinite,
            child: TextControl(
              node: node,
              value: element.qonversionProductIdentifier ?? FTextTypeInput(),
              page: page,
              title: 'Qonversion ID',
              withConvertTo: false,
              callBack: (final value, final old) {
                final old = element;
                element.qonversionProductIdentifier = value;
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
              CDropdown(
                value: page.states
                            .map((final e) => e.name)
                            .where((final element) => element != 'null')
                            .toList()
                            .indexWhere(
                              (final e) => e == element.stateName,
                            ) !=
                        -1
                    ? element.stateName
                    : null,
                items: page.states
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
              ),
            ],
          ),
        /*
        const Gap(Grid.medium),
        const THeadline3(
          'Choose a variable to save the status of the operation',
        ),
        TDetailLabel(
          "The selected variable is set to 'Loading' during the operation, to 'Successful' if the payment is successful and to 'Failed' if it is not successful. The variable must be of String type.",
          color: Palette.txtPrimary.withOpacity(0.6),
        ),
        const Gap(Grid.small),
        CDropdown(
          value: widget.page.states
                      .map((final e) => e.name)
                      .where((final element) => element != 'null')
                      .toList()
                      .indexWhere(
                        (final e) => e == widget.element.stateName,
                      ) !=
                  -1
              ? widget.element.stateName
              : null,
          items: widget.page.states
              .map((final e) => e.name)
              .where((final element) => element != 'null')
              .toList(),
          onChange: (final newValue) {
            if (newValue != null) {
              try {
                final old = widget.element;
                widget.element.stateName = newValue;
                widget.callBack(widget.element, old);
              } catch (e) {}
            }
          },
        ),*/
      ],
    );
  }
}