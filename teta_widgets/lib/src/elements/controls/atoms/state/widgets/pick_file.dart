import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_front_end/teta_front_end.dart';

import '../../../../actions/state/pick_file/action.dart';
import '../../../../actions/state/pick_file/params.dart';

class StatePickFileControl extends StatefulWidget {
  const StatePickFileControl({
    super.key,
    required this.action,
    required this.onParamsChanged,
  });

  final TAStatePickFile action;
  final Function(TAStatePickFileParams params) onParamsChanged;

  @override
  State<StatePickFileControl> createState() => StatePickFileControlState();
}

class StatePickFileControlState extends State<StatePickFileControl> {
  String? stateName;

  @override
  void initState() {
    super.initState();
    stateName = widget.action.params.stateName;
  }

  void updateParams() {
    setState(() {
      widget.onParamsChanged(
        TAStatePickFileParams(
          stateName: stateName,
        ),
      );
    });
  }

  @override
  Widget build(final BuildContext context) {
    final pageLoaded = context.read<PageCubit>().state as PageLoaded;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CDropdown(
          value: pageLoaded.page.defaultStates
                      .map((final e) => e.name)
                      .where((final element) => element != 'null')
                      .toList()
                      .indexWhere(
                        (final e) => e == widget.action.params.stateName,
                      ) !=
                  -1
              ? widget.action.params.stateName
              : null,
          items: pageLoaded.page.defaultStates
              .map((final e) => e.name)
              .where((final element) => element != 'null')
              .toList(),
          onChange: (final newValue) {
            if (newValue == null) return;
            stateName = newValue;
            updateParams();
          },
        ),
      ],
    );
  }
}
