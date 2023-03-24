import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_front_end/teta_front_end.dart';
import 'package:teta_models/teta_models.dart';

import '../../../../actions/state/change_with/action.dart';
import '../../../../actions/state/change_with/params.dart';
import '../../../../features/actions/enums/gestures.dart';
import '../../../../features/text_type_input.dart';
import '../../../../nodes/enum.dart';
import '../../../atoms/text.dart';
import '../../../type.dart';

class StateChangeWithControl extends StatefulWidget {
  const StateChangeWithControl({
    super.key,
    required this.action,
    required this.onParamsChanged,
  });

  final TAStateChangeWith action;
  final Function(TAStateChangeWithParams params) onParamsChanged;

  @override
  State<StateChangeWithControl> createState() => StateChangeWithControlState();
}

class StateChangeWithControlState extends State<StateChangeWithControl> {
  String? stateName;
  bool isValueDefault = false;
  FTextTypeInput? valueToChangeWith;

  @override
  void initState() {
    super.initState();
    stateName = widget.action.params.stateName;
    isValueDefault = widget.action.params.isValueDefault;
    valueToChangeWith = widget.action.params.valueToChangeWith;
  }

  void updateParams() {
    widget.onParamsChanged(
      TAStateChangeWithParams(
        stateName: stateName,
        isValueDefault: isValueDefault,
        valueToChangeWith: valueToChangeWith,
      ),
    );
  }

  /// Returns true if the value input control should be visible.
  ///
  /// For example, if the node is a calendar, the value input control
  /// should not be visible because the calendar will emit a runtime value.
  /// Again, if the node contains an onChange gesture, the value input control
  /// should not be visible because the onChange gesture will emit a runtime value.
  bool isValueInputControlVisible(BuildContext context) {
    final focusBloc = context.read<FocusBloc>();
    final nodeId = focusBloc.state.first;
    final node = (context.read<PageCubit>().state as PageLoaded)
        .page
        .flatList
        .firstWhere((final element) => element.nid == nodeId);
    return !node.intrinsicState.gestures.contains(ActionGesture.onChange) &&
        (node.intrinsicState.type != NType.calendar &&
            node.intrinsicState.type != NType.cupertinoSegmentedControl &&
            node.intrinsicState.type != NType.cupertinoSwitch);
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
              .map((final e) => e.name)
              .where((final element) => element != 'null')
              .toList(),
          onChange: (final newValue) {
            if (newValue == null) return;
            stateName = newValue;
            updateParams();
          },
        ),
        if (isValueInputControlVisible(context))
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: SizedBox(
              width: double.maxFinite,
              child: descriptionControlWidget(
                description: '''''',
                control: TextControl(
                  valueType: VariableType.string,
                  value: widget.action.params.valueToChangeWith ??
                      FTextTypeInput(),
                  title: 'Value',
                  callBack: (final value, final old) {
                    valueToChangeWith = value;
                    updateParams();
                  },
                ),
              ),
            ),
          )
      ],
    );
  }
}
