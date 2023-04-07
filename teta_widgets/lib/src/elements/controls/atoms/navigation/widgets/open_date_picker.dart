import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_front_end/teta_front_end.dart';

import '../../../../actions/navigation/open_date_picker/action.dart';
import '../../../../actions/navigation/open_date_picker/params.dart';

class NavigationOpenDatePickerControl extends StatefulWidget {
  const NavigationOpenDatePickerControl({
    super.key,
    required this.action,
    required this.onParamsChanged,
  });

  final TANavigationOpenDatePicker action;
  final Function(TANavigationOpenDatePickerParams params) onParamsChanged;

  @override
  State<NavigationOpenDatePickerControl> createState() =>
      NavigationOpenDatePickerControlState();
}

class NavigationOpenDatePickerControlState
    extends State<NavigationOpenDatePickerControl> {
  String? stateName;

  @override
  void initState() {
    super.initState();
    stateName = widget.action.params.stateName;
  }

  void updateParams() {
    setState(() {
      widget.onParamsChanged(
        TANavigationOpenDatePickerParams(
          stateName: stateName,
        ),
      );
    });
  }

  @override
  Widget build(final BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 8, bottom: 8),
          child: TParagraph('Which State needs to change?'),
        ),
        Builder(
          builder: (final context) {
            final pageLoaded = context.read<PageCubit>().state as PageLoaded;
            final states = pageLoaded.page.defaultStates;
            final statesNameList = <String>[];
            for (final item in states) {
              statesNameList.add(item.name);
            }
            return CDropdown(
              value: stateName,
              items: statesNameList,
              onChange: (final newValue) {
                stateName = newValue;
                updateParams();
              },
            );
          },
        ),
      ],
    );
  }
}
