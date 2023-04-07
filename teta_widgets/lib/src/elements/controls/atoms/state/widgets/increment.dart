import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_front_end/teta_front_end.dart';
import 'package:teta_models/teta_models.dart';

import '../../../../actions/state/increment/action.dart';
import '../../../../actions/state/increment/params.dart';

class StateIncrementControl extends StatefulWidget {
  const StateIncrementControl({
    super.key,
    required this.action,
    required this.onParamsChanged,
  });

  final TAStateIncrement action;
  final Function(TAStateIncrementParams params) onParamsChanged;

  @override
  State<StateIncrementControl> createState() => StateIncrementControlState();
}

class StateIncrementControlState extends State<StateIncrementControl> {
  String? stateName;

  @override
  void initState() {
    super.initState();
    stateName = widget.action.params.stateName;
  }

  void updateParams() {
    setState(() {
      widget.onParamsChanged(TAStateIncrementParams(stateName: stateName));
    });
  }

  @override
  Widget build(final BuildContext context) {
    final pageLoaded = context.read<PageCubit>().state as PageLoaded;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
              .where(
                (final element) =>
                    element.type == VariableType.int ||
                    element.type == VariableType.double ||
                    element.type == VariableType.string,
              )
              .map((final e) => e.name)
              .where((final element) => element != 'null')
              .toList(),
          onChange: (final newValue) {
            if (newValue != null) {
              stateName = newValue;
              updateParams();
            }
          },
        ),
        const Padding(
          padding: EdgeInsets.only(bottom: 8),
          child: TDetailLabel(
            "It requires an'int','double' or 'string' variable",
          ),
        ),
      ],
    );
  }
}
