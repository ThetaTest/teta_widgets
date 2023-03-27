import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:gap/gap.dart';
import 'package:teta_front_end/src/design_system/buttons/element_button.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_front_end/teta_front_end.dart';
import 'package:teta_models/teta_models.dart';

import '../../../../teta_widgets.dart';
import '../../../core/teta_action/action_types/groups.dart';
import '../../../core/teta_action/index.dart';
import 'action_element.dart';

class ActionControl extends StatefulWidget {
  const ActionControl({
    required this.nodeGestureActions,
    required this.onActionChanged,
    final Key? key,
  }) : super(key: key);

  final NodeGestureActions nodeGestureActions;
  final Function(
    NodeGestureActions newActions,
    NodeGestureActions oldActions,
  ) onActionChanged;

  @override
  ActionControlState createState() => ActionControlState();
}

class ActionControlState extends State<ActionControl> {
  String? id;
  String? dropdown;
  PageObject? pageObject;

  @override
  void initState() {
    super.initState();
    final projectPages = context.read<PagesCubit>().state;
    if (projectPages.isNotEmpty) pageObject = projectPages.first;
    if (pageObject != null) dropdown = pageObject!.name;
  }

  @override
  Widget build(final BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(8),
      ),
      child: BlocBuilder<FocusBloc, List<int>>(
        builder: (final context, final state) {
          final nodeId = state.first;
          final node = (context.read<PageCubit>().state as PageLoaded)
              .page
              .flatList
              .firstWhere((final element) => element.nid == nodeId);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final trigger in node.intrinsicState.gestures.isNotEmpty
                  ? node.intrinsicState.gestures
                  : [
                      ActionGesture.onTap,
                      ActionGesture.onLongPress,
                      ActionGesture.onDoubleTap
                    ])
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TParagraph(trigger.gestureName),
                    Divider(
                      color: Palette.txtPrimary.withOpacity(0.3),
                    ),
                    ElementButton(
                      title: 'New action',
                      isSelected: false,
                      icon: FeatherIcons.plus,
                      onTap: () => openNewActionDialog(context, trigger),
                    ),
                    for (final element in widget.nodeGestureActions.actions
                        .where((final element) => element.gesture == trigger)
                        .toList())
                      ActionElementControl(
                        name: element.action.type.actionName,
                        action: element.action,
                        node: node,
                        onActionUpdated: (final newAction, final oldAction) {
                          widget.onActionChanged(
                            widget.nodeGestureActions
                              ..replace(newAction, oldAction),
                            widget.nodeGestureActions,
                          );
                        },
                        onActionDeleted: (final actionId) {
                          widget.onActionChanged(
                            widget.nodeGestureActions..deleteAction(actionId),
                            widget.nodeGestureActions,
                          );
                        },
                      ),
                    const Gap(Grid.medium),
                  ],
                ),
            ],
          );
        },
      ),
    );
  }

  void openNewActionDialog(
    final BuildContext context,
    final ActionGesture trigger,
  ) {
    final pageBloc = BlocProvider.of<PageCubit>(context);
    final prjCubit = context.read<FocusProjectCubit>();
    final configCubit = context.read<ConfigCubit>();
    showDialog<void>(
      context: context,
      builder: (final context) => MultiBlocProvider(
        providers: [
          BlocProvider<PageCubit>.value(value: pageBloc),
          BlocProvider<FocusProjectCubit>.value(value: prjCubit),
          BlocProvider<ConfigCubit>.value(value: configCubit),
        ],
        child: _NewActionPickerDialog(
          onActionSelected: (final actionType) {
            final action = TetaActionFactory.create(
              type: actionType,
              params: null,
            );
            if (action == null) return;
            widget.onActionChanged(
              widget.nodeGestureActions..add(trigger, action),
              widget.nodeGestureActions,
            );
            Navigator.of(context, rootNavigator: true).pop(null);
          },
        ),
      ),
    );
  }
}

class _NewActionPickerDialog extends StatefulWidget {
  const _NewActionPickerDialog({required this.onActionSelected});

  final Function(TetaActionType actionType) onActionSelected;

  @override
  State<_NewActionPickerDialog> createState() => _NewActionPickerDialogState();
}

class _NewActionPickerDialogState extends State<_NewActionPickerDialog> {
  final elements = <_SelectionClass>[];

  @override
  void initState() {
    super.initState();
    final pageCubit = BlocProvider.of<PageCubit>(context);
    final pageState = pageCubit.state as PageLoaded;
    final configCubit =
        BlocProvider.of<ConfigCubit>(context).state as ConfigStateLoaded;

    elements.addAll(
      TetaActionGroups.getActionGroups(pageState.page, configCubit.config).map(
        (final e) => _SelectionClass(title: e.name, actions: e.actions),
      ),
    );
  }

  @override
  Widget build(final BuildContext context) {
    return AlertDialog(
      backgroundColor: Palette.bgDialog,
      content: SizedBox(
        width: 500,
        height: 700,
        child: ListView.builder(
          itemCount: elements.length,
          itemBuilder: (final context, final index) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              THeadline2(elements[index].title),
              const Gap(Grid.small),
              Wrap(
                children: elements[index]
                    .actions
                    .map(
                      (final e) => BounceSmall(
                        onTap: () => widget.onActionSelected(e),
                        child: TContainer(
                          margin: const EdgeInsets.only(right: 8, bottom: 8),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Palette.bgGrey,
                            borderRadius: BR(40),
                          ),
                          child: TParagraph(e.actionName),
                        ),
                      ),
                    )
                    .toList(),
              ),
              const Gap(Grid.medium),
            ],
          ),
        ),
      ),
    );
  }
}

class _SelectionClass {
  _SelectionClass({
    required this.title,
    required this.actions,
  });

  final String title;
  final List<TetaActionType> actions;
}
