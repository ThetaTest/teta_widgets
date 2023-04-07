import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:teta_front_end/teta_front_end.dart';
import 'package:teta_models/teta_models.dart';

import '../../../../actions/revenue_cat/buy/action.dart';
import '../../../../actions/revenue_cat/buy/params.dart';
import '../../../../features/text_type_input.dart';
import '../../../atoms/text.dart';

class RevenueCatBuyControl extends StatefulWidget {
  const RevenueCatBuyControl({
    super.key,
    required this.action,
    required this.onParamsChanged,
  });

  final TARevenueCatBuy action;
  final Function(TARevenueCatBuyParams params) onParamsChanged;

  @override
  State<RevenueCatBuyControl> createState() => RevenueCatBuyControlState();
}

class RevenueCatBuyControlState extends State<RevenueCatBuyControl> {
  String? stateName;
  FTextTypeInput? productIdentifier;

  void updateParams() {
    setState(() {
      widget.onParamsChanged(
        TARevenueCatBuyParams(
          productIdentifier: productIdentifier,
          stateName: stateName,
        ),
      );
    });
  }

  @override
  Widget build(final BuildContext context) {
    final pageLoaded = context.read<PageCubit>().state as PageLoaded;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: double.maxFinite,
          child: TextControl(
            valueType: VariableType.string,
            value: widget.action.params.productIdentifier ?? FTextTypeInput(),
            title: 'Product Identifier',
            callBack: (final value, final old) {
              productIdentifier = value;
              updateParams();
            },
          ),
        ),
        const THeadline3(
          'Choose a variable to save the status of the operation',
        ),
        TDetailLabel(
          "The selected variable is set to 'Loading' during the operation, to "
          "'Successful' if the payment is successful and to 'Failed' if it is "
          'not successful. The variable must be of String type.',
          color: Palette.txtPrimary.withOpacity(0.6),
        ),
        const Gap(Grid.small),
        CDropdown(
          value: pageLoaded.states
                      .map((final e) => e.name)
                      .where((final element) => element != 'null')
                      .toList()
                      .indexWhere(
                        (final e) => e == widget.action.params.stateName,
                      ) !=
                  -1
              ? widget.action.params.stateName
              : null,
          items: pageLoaded.states
              .map((final e) => e.name)
              .where((final element) => element != 'null')
              .toList(),
          onChange: (final newValue) {
            stateName = newValue;
            updateParams();
          },
        ),
      ],
    );
  }
}
