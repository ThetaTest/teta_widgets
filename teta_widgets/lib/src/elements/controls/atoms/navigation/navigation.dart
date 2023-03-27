import 'package:dart_airtable/dart_airtable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_front_end/teta_front_end.dart';
import 'package:teta_models/teta_models.dart';
import 'package:teta_widgets/src/elements/controls/atoms/destination_page_selector.dart';

import '../../../../core/teta_action/index.dart';
import '../../../actions/actions_index.dart';
import '../../../actions/params_index.dart';
import '../../../features/text_type_input.dart';
import '../../atoms/text.dart';
import '../../type.dart';

class TANavigationControls extends StatefulWidget {
  const TANavigationControls({
    super.key,
    required this.action,
    required this.onParamsChanged,
  });

  final TetaAction action;
  final Function(TetaActionParams params) onParamsChanged;

  @override
  State<TANavigationControls> createState() => _TANavigationControlsState();
}

class _TANavigationControlsState extends State<TANavigationControls> {
  TetaActionParams? newParams;
  final List<PageObject> projectPages = [];
  PageObject? selectedPage;
  String? openDatePickerStateName;

  @override
  void initState() {
    super.initState();
    newParams = widget.action.params;
    final pagesCubit = context.read<PagesCubit>();
    projectPages.addAll(
      pagesCubit.state.where((final elm) => elm.isPage).toSet().toList(),
    );

    try {
      selectedPage = pagesCubit.state.firstWhereOrNull(
        (final elm) =>
            elm.name ==
            (widget.action as TANavigationOpenPage).params.nameOfPage,
      );
    } catch (_) {}

    if (widget.action.type == TetaActionType.navigationOpenDatePicker) {
      openDatePickerStateName =
          (widget.action as TANavigationOpenDatePicker).params.stateName;
    }
  }

  @override
  Widget build(final BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Launch URL
        if (widget.action.type == TetaActionType.navigationLaunchUrl)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: SizedBox(
              width: double.maxFinite,
              child: descriptionControlWidget(
                description: '''''',
                control: TextControl(
                  valueType: VariableType.string,
                  value:
                      (widget.action as TANavigationLaunchUrl).params.value ??
                          FTextTypeInput(),
                  title: 'URL to open',
                  callBack: (final value, final old) {
                    if (newParams is TANavigationLaunchUrlParams?) {
                      newParams =
                          (newParams as TANavigationLaunchUrlParams?)?.copyWith(
                        value: value,
                      );
                    }
                    newParams ??= TANavigationLaunchUrlParams(value: value);

                    widget.onParamsChanged(newParams!);
                  },
                ),
              ),
            ),
          ),
        // Open Date Picker
        if (widget.action.type == TetaActionType.navigationOpenDatePicker)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 8, bottom: 8),
                child: TParagraph('Which State needs to change?'),
              ),
              Builder(
                builder: (final context) {
                  final pageLoaded =
                      context.read<PageCubit>().state as PageLoaded;
                  final states = pageLoaded.page.defaultStates;
                  final statesNameList = <String>[];
                  for (final item in states) {
                    statesNameList.add(item.name);
                  }
                  return CDropdown(
                    value: openDatePickerStateName,
                    items: statesNameList,
                    onChange: (final newValue) {
                      if (newValue == null) return;
                      openDatePickerStateName = newValue;

                      if (newParams is TANavigationOpenDatePickerParams?) {
                        newParams =
                            (newParams as TANavigationOpenDatePickerParams?)
                                ?.copyWith(stateName: openDatePickerStateName);
                      }
                      newParams ??= TANavigationOpenDatePickerParams(
                        stateName: openDatePickerStateName,
                      );

                      widget.onParamsChanged(newParams!);
                    },
                  );
                },
              ),
            ],
          ),

        // Share
        if (widget.action.type == TetaActionType.navigationShare)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: SizedBox(
              width: double.maxFinite,
              child: descriptionControlWidget(
                description: '''''',
                control: TextControl(
                  valueType: VariableType.string,
                  value: (widget.action as TANavigationShare).params.value ??
                      FTextTypeInput(),
                  title: 'Value',
                  callBack: (final value, final old) {
                    if (newParams is TANavigationShareParams?) {
                      newParams =
                          (newParams as TANavigationShareParams?)?.copyWith(
                        value: value,
                      );
                    }
                    newParams ??= TANavigationShareParams(value: value);

                    widget.onParamsChanged(newParams!);
                  },
                ),
              ),
            ),
          ),
        // Open Page
        if (widget.action.type == TetaActionType.navigationOpenPage)
          DestinationPageSelector(
            pageToOpen: selectedPage?.name,
            paramsToSend:
                (newParams as TANavigationOpenPageParams?)?.paramsToSend,
            onParamsChanged: (pageToOpen, paramsToSend) {
              newParams = TANavigationOpenPageParams(
                nameOfPage: pageToOpen,
                paramsToSend: paramsToSend,
              );
              widget.onParamsChanged(newParams!);
            },
          )
      ],
    );
  }
}
