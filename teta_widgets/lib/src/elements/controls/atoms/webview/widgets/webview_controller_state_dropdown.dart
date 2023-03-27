import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:teta_front_end/teta_front_end.dart';
import 'package:teta_models/teta_models.dart';

class WebViewControllerStateDropdown extends StatefulWidget {
  const WebViewControllerStateDropdown({
    super.key,
    this.initialValue,
    required this.onParamsChanged,
  });

  final String? initialValue;
  final Function(String? value) onParamsChanged;

  @override
  State<WebViewControllerStateDropdown> createState() =>
      _WebViewControllerStateDropdownState();
}

class _WebViewControllerStateDropdownState
    extends State<WebViewControllerStateDropdown> {
  String? stateName;

  @override
  void initState() {
    super.initState();
    stateName = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    final pageLoaded = context.read<PageCubit>().state as PageLoaded;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Gap(Grid.medium),
        const TParagraph('Which controller?'),
        const Gap(Grid.small),
        CDropdownCustom<String>(
          expanded: true,
          value: pageLoaded.page.defaultStates
                      .where(
                        (final element) =>
                            element.type == VariableType.webViewController,
                      )
                      .map((final e) => e.name)
                      .where((final element) => element != 'null')
                      .toList()
                      .indexWhere(
                        (final e) => e == stateName,
                      ) !=
                  -1
              ? stateName
              : null,
          items: pageLoaded.page.defaultStates
              .where(
                (final element) =>
                    element.type == VariableType.webViewController,
              )
              .map((final e) => e.name)
              .where((final element) => element != 'null')
              .map(
                (e) => DropdownCustomMenuItem(
                  value: e,
                  child: TParagraph(e),
                ),
              )
              .toList(),
          onChange: (final newValue) {
            setState(() => stateName = newValue);
            widget.onParamsChanged(newValue);
          },
        ),
      ],
    );
  }
}
