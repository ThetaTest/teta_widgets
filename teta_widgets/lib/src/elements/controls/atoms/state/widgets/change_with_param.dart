import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_front_end/teta_front_end.dart';

import '../../../../../../teta_widgets.dart';
import '../../../../actions/state/change_with_param/action.dart';
import '../../../../actions/state/change_with_param/params.dart';

class StateChangeWithParamControl extends StatefulWidget {
  const StateChangeWithParamControl({
    super.key,
    required this.action,
    required this.onParamsChanged,
  });

  final TAStateChangeWithParam action;
  final Function(TAStateChangeWithParamParams params) onParamsChanged;

  @override
  State<StateChangeWithParamControl> createState() =>
      StateChangeWithParamControlState();
}

class StateChangeWithParamControlState
    extends State<StateChangeWithParamControl> {
  String? stateName;
  String? paramName;
  FTextTypeInput? valueToChangeWith;

  @override
  void initState() {
    super.initState();
    stateName = widget.action.params.stateName;
    paramName = widget.action.params.paramName;
  }

  void updateParams() {
    widget.onParamsChanged(
      TAStateChangeWithParamParams(
        stateName: stateName,
        paramName: paramName,
      ),
    );
  }

  @override
  Widget build(final BuildContext context) {
    final pageLoaded = context.read<PageCubit>().state as PageLoaded;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 2, bottom: 8),
          child: TParagraph('Parameter'),
        ),
        CDropdown(
          value: pageLoaded.page.defaultParams
                      .map((final e) => e.name)
                      .where((final element) => element != 'null')
                      .toList()
                      .indexWhere(
                        (final e) => e == widget.action.params.paramName,
                      ) !=
                  -1
              ? widget.action.params.paramName
              : null,
          items: pageLoaded.page.defaultParams
              .map((final e) => e.name)
              .where((final element) => element != 'null')
              .toList(),
          onChange: (final newValue) {
            if (newValue != null) {
              paramName = newValue;
              updateParams();
            }
          },
        ),
        const Padding(
          padding: EdgeInsets.only(top: 16, bottom: 8),
          child: TParagraph('State'),
        ),
        descriptionControlWidget(
          description: 'Select the state where you want to put the value',
          control: CDropdown(
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
              if (newValue == null) return;
              stateName = newValue;
              updateParams();
            },
          ),
        )
      ],
    );
  }
}
