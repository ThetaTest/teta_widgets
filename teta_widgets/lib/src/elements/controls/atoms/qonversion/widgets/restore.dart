import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:teta_front_end/teta_front_end.dart';

import '../../../../actions/qonversion/restore/action.dart';
import '../../../../actions/qonversion/restore/params.dart';

class QonversionRestoreControl extends StatefulWidget {
  const QonversionRestoreControl({
    super.key,
    required this.action,
    required this.onParamsChanged,
  });

  final TAQonversionRestore action;
  final Function(TAQonversionRestoreParams params) onParamsChanged;

  @override
  State<QonversionRestoreControl> createState() =>
      QonversionRestoreControlState();
}

class QonversionRestoreControlState extends State<QonversionRestoreControl> {
  String? stateName;

  void updateParams() {
    setState(() {
      widget.onParamsChanged(
        TAQonversionRestoreParams(
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
