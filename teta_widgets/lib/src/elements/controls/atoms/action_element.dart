import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:hovering/hovering.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/index.dart';
import 'package:teta_front_end/teta_front_end.dart';

import '../../../core/teta_action/index.dart';
import 'action_settings_bottom_sheet.dart';

/// Widget to control a single action
class ActionElementControl extends StatefulWidget {
  /// Returns a widget to control a single action
  const ActionElementControl({
    required this.node,
    required this.name,
    required this.action,
    required this.onActionUpdated,
    required this.onActionDeleted,
    final Key? key,
  }) : super(key: key);

  /// Name of action
  final String name;

  /// Action itself
  final TetaAction action;

  /// Current node
  final CNode node;

  /// Function to change the action's properties
  final Function(TetaAction newAction, TetaAction oldAction) onActionUpdated;

  /// Function to delete the action
  final Function(String actionId) onActionDeleted;

  @override
  ActionElementControlState createState() => ActionElementControlState();
}

class ActionElementControlState extends State<ActionElementControl> {
  @override
  Widget build(final BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Palette.txtPrimary.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EI.smA,
      child: BounceLarge(
        onTap: bottomSheet,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TParagraph(widget.name),
            GestureDetector(
              onTap: () => widget.onActionDeleted(widget.action.id),
              child: HoverWidget(
                hoverChild:
                    const Icon(FeatherIcons.x, size: 24, color: Colors.red),
                onHover: (final e) {},
                child: const Icon(
                  FeatherIcons.x,
                  size: 24,
                  color: Colors.white24,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void bottomSheet() {
    final focusBloc = context.read<FocusBloc>();
    final pageCubit = context.read<PageCubit>();
    final configCubit = context.read<ConfigCubit>();
    final deviceModeCubit = context.read<DeviceModeCubit>();
    final pagesCubit = context.read<PagesCubit>();
    final translatorCubit = context.read<TranslatorGeneratorCubit>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      constraints: BoxConstraints(
        maxWidth: 600,
        maxHeight: MediaQuery.of(context).size.height / 8 * 7,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Grid.medium),
          topRight: Radius.circular(Grid.medium),
        ),
      ),
      backgroundColor: Palette.bgDialog,
      clipBehavior: Clip.hardEdge,
      builder: (context) {
        return MultiBlocProvider(
          providers: [
            BlocProvider.value(value: focusBloc),
            BlocProvider.value(value: pageCubit),
            BlocProvider.value(value: configCubit),
            BlocProvider.value(value: deviceModeCubit),
            BlocProvider.value(value: pagesCubit),
            BlocProvider.value(value: translatorCubit),
          ],
          child: ActionSettingsBottomSheet(
            action: widget.action,
            onActionUpdated: widget.onActionUpdated,
          ),
        );
      },
    );
  }
}
