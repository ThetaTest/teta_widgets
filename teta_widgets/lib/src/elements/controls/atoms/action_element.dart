// Flutter imports:
// Package imports:

// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars, avoid_dynamic_calls

import 'package:collection/collection.dart';
// Package imports:
// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:gap/gap.dart';
import 'package:hovering/hovering.dart';
import 'package:teta_front_end/src/design_system/textfield/minitextfield.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_repositories/src/node_repository.dart';
import 'package:teta_widgets/src/elements/controls/atoms/actions/validator.dart';
import 'package:teta_widgets/src/elements/controls/atoms/airtable/delete.dart';
import 'package:teta_widgets/src/elements/controls/atoms/airtable/insert.dart';
import 'package:teta_widgets/src/elements/controls/atoms/airtable/update.dart';
import 'package:teta_widgets/src/elements/controls/atoms/alert/snackbar.dart';
import 'package:teta_widgets/src/elements/controls/atoms/apicalls/apicalls.dart';
import 'package:teta_widgets/src/elements/controls/atoms/cms_condition.dart';
import 'package:teta_widgets/src/elements/controls/atoms/firebase/firebase_analytics/log_app_open.dart';
import 'package:teta_widgets/src/elements/controls/atoms/firebase/firebase_analytics/log_event.dart';
import 'package:teta_widgets/src/elements/controls/atoms/firebase/firebase_analytics/log_join_group.dart';
import 'package:teta_widgets/src/elements/controls/atoms/firebase/firebase_analytics/log_login.dart';
import 'package:teta_widgets/src/elements/controls/atoms/firebase/firebase_analytics/log_screen_view.dart';
import 'package:teta_widgets/src/elements/controls/atoms/firebase/firebase_analytics/log_share.dart';
import 'package:teta_widgets/src/elements/controls/atoms/firebase/firebase_analytics/reset_analytics_data.dart';
import 'package:teta_widgets/src/elements/controls/atoms/firebase/firebase_analytics/set_current_screen.dart';
import 'package:teta_widgets/src/elements/controls/atoms/firebase/firebase_analytics/set_user_id.dart';
import 'package:teta_widgets/src/elements/controls/atoms/firebase/firebase_analytics/set_user_property.dart';
import 'package:teta_widgets/src/elements/controls/atoms/firebase/firebase_messages/subscribe_to_topic.dart';
import 'package:teta_widgets/src/elements/controls/atoms/firebase/firebase_messages/unsubscribe_from_topic.dart';
// Project imports:
import 'package:teta_widgets/src/elements/controls/atoms/flag.dart';
import 'package:teta_widgets/src/elements/controls/atoms/https_requests_custom_backend/delete.dart';
import 'package:teta_widgets/src/elements/controls/atoms/https_requests_custom_backend/post.dart';
import 'package:teta_widgets/src/elements/controls/atoms/https_requests_custom_backend/update.dart';
import 'package:teta_widgets/src/elements/controls/atoms/mixpanel/set_user_id.dart';
import 'package:teta_widgets/src/elements/controls/atoms/mixpanel/track.dart';
import 'package:teta_widgets/src/elements/controls/atoms/qonversion/buy.dart';
import 'package:teta_widgets/src/elements/controls/atoms/revenuecat/buy.dart';
import 'package:teta_widgets/src/elements/controls/atoms/subapase/delete.dart';
import 'package:teta_widgets/src/elements/controls/atoms/subapase/insert.dart';
import 'package:teta_widgets/src/elements/controls/atoms/subapase/invoke.dart';
import 'package:teta_widgets/src/elements/controls/atoms/subapase/storage_remove.dart';
import 'package:teta_widgets/src/elements/controls/atoms/subapase/storage_upload.dart';
import 'package:teta_widgets/src/elements/controls/atoms/subapase/update.dart';
import 'package:teta_widgets/src/elements/controls/atoms/teta_cms/delete.dart';
import 'package:teta_widgets/src/elements/controls/atoms/teta_cms/insert.dart';
import 'package:teta_widgets/src/elements/controls/atoms/teta_cms/update.dart';
import 'package:teta_widgets/src/elements/controls/atoms/text.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/action_google_maps.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/airtable.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/alert.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/apicalls.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/audio_player_actions.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/braintree.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/camera.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/custom_http_request.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/firebase/firebase_analytics.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/firebase/firebase_message.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/mixpanel.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/navigation.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/state.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/stripe.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/supabase.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/teta_cms.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/theme.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/translator.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/type.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/webview.dart';
import 'package:teta_widgets/src/elements/features/condition_type.dart';
import 'package:teta_widgets/src/elements/index.dart';
import 'package:uuid/uuid.dart';
import 'package:teta_front_end/teta_front_end.dart';

/// Widget to control a single action
class ActionElementControl extends StatefulWidget {
  /// Returns a widget to control a single action
  const ActionElementControl({
    required this.name,
    required this.element,
    required this.callBack,
    required this.callBackToDelete,
    final Key? key,
  }) : super(key: key);

  /// Name of action
  final String name;

  /// Action itself
  final FActionElement element;

  /// Function to change the action's properties
  final Function(FActionElement, FActionElement) callBack;

  /// Function to delete the action
  final Function() callBackToDelete;

  @override
  ActionElementControlState createState() => ActionElementControlState();
}

/// State
class ActionElementControlState extends State<ActionElementControl> {
  String dropdownLinkPage = '';
  PageObject? pageObject;
  Map<String, dynamic> map = <String, dynamic>{};
  TextEditingController controller = TextEditingController();
  TextEditingController delayController = TextEditingController();
  TextEditingController loopController = TextEditingController();

  String? stateTest;
  bool isEmit = false;

  ///needs for custom function
  String? currentCustomFunctionValue;

  ///needs for openDatePicker
  String? currentStateNameValue;

  @override
  void initState() {
    try {
      final pages = context.read<PagesCubit>().state;
      pageObject = pages.firstWhereOrNull(
        (final element) => element.name == widget.element.nameOfPage,
      );
      if (pageObject != null) {
        dropdownLinkPage = pageObject!.name;
        if (widget.element.paramsToSend != null) {
          map = widget.element.paramsToSend!;
        }
      }
    } catch (_) {}

    controller.text = widget.element.value ?? '';
    delayController.text = widget.element.delay?.value ?? '0';
    loopController.text = widget.element.everyMilliseconds?.value ?? '0';
    //initialization for custom functions
    try {
      final functions = BlocProvider.of<CustomFunctionsCubit>(context).state;
      if (functions.isNotEmpty) {
        final currentFunc = functions.firstWhere(
          (final element) => element.id == widget.element.customFunctionId,
        );
        currentCustomFunctionValue = currentFunc.name;
      }
    } catch (e) {
      Logger.printError(e.toString());
    }
    //initialization for openDatePicker for states
    final page = context.read<PageCubit>().state as PageLoaded;
    try {
      final states = page.states;
      if (states.isNotEmpty) {
        final currentState = states.firstWhere(
          (final element) => element.name == widget.element.stateName,
        );
        currentStateNameValue = currentState.name;
      }
    } catch (e) {
      Logger.printError(e.toString());
    }

    super.initState();
  }

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
        onTap: () {
          bottomSheet();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TParagraph(
              widget.name,
            ),
            GestureDetector(
              onTap: widget.callBackToDelete,
              child: HoverWidget(
                hoverChild: const Icon(
                  FeatherIcons.x,
                  size: 24,
                  color: Colors.red,
                ),
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
            maxHeight: MediaQuery.of(context).size.height / 8 * 7),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Grid.medium),
            topRight: Radius.circular(Grid.medium),
          ),
        ),
        backgroundColor: Palette.bgDialog,
        clipBehavior: Clip.hardEdge,
        builder: (context) {
          return BlocProvider.value(
            value: focusBloc,
            child: BlocProvider.value(
              value: configCubit,
              child: BlocProvider.value(
                value: deviceModeCubit,
                child: BlocProvider.value(
                  value: pageCubit,
                  child: BlocProvider.value(
                    value: pagesCubit,
                    child: BlocProvider.value(
                      value: translatorCubit,
                      child: Builder(builder: (context) {
                        final pageState =
                            context.watch<PageCubit>().state as PageLoaded;
                        final config = (context.watch<ConfigCubit>().state
                                as ConfigStateLoaded)
                            .config;
                        return Container(
                          padding: const EdgeInsets.only(
                              left: 8, right: 8, bottom: 8),
                          child: ListView(
                            padding: EI.mdH,
                            children: [
                              const Gap(Grid.medium),
                              const THeadline1('Edit action'),
                              const Gap(Grid.medium),
                              //Action Type Dropdown
                              const Padding(
                                padding: EdgeInsets.only(top: 2, bottom: 4),
                                child: TParagraph(
                                  'Action Type',
                                ),
                              ),
                              CDropdownCustom<String>(
                                expanded: true,
                                value: FActionElement()
                                        .getTypes(config, pageState.page)
                                        .toSet()
                                        .toList()
                                        .contains(
                                          FActionElement.convertValueToDropdown(
                                            widget.element.actionType,
                                          ),
                                        )
                                    ? FActionElement.convertValueToDropdown(
                                        widget.element.actionType,
                                      )
                                    : null,
                                items: FActionElement()
                                    .getTypes(config, pageState.page)
                                    .toSet()
                                    .map(
                                      (e) => DropdownCustomMenuItem(
                                        value: e,
                                        child: TParagraph(e),
                                      ),
                                    )
                                    .toList(),
                                onChange: (final newValue) {
                                  if (newValue != null) {
                                    final old = widget.element;
                                    widget.element.actionType =
                                        FActionElement.convertDropdownToValue(
                                      ActionType.values,
                                      newValue,
                                    ) as ActionType?;
                                    widget.callBack(widget.element, old);
                                  }
                                },
                              ),
                              // Delay
                              const Divider(
                                color: Colors.white24,
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 2, bottom: 4),
                                child: TParagraph(
                                  'Delay (ms)',
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: SizedBox(
                                  width: double.maxFinite,
                                  child: BlocListener<FocusBloc, List<int>>(
                                    listener: (final context, final state) {
                                      if (state.isNotEmpty) {
                                        delayController.text =
                                            widget.element.delay?.value ?? '0';
                                      }
                                    },
                                    child: CMiniTextField(
                                      controller: delayController,
                                      backgroundColor: Palette.bgTertiary,
                                      callBack: (final text) {
                                        if (int.tryParse(text) != null) {
                                          final old = widget.element;
                                          widget.element.delay!.value = text;
                                          widget.callBack(widget.element, old);
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              // Loop
                              const Divider(
                                color: Colors.white24,
                              ),
                              descriptionControlWidget(
                                description:
                                    'Should this action be executed in a loop?',
                                control: FlagControl(
                                  title: 'Is looped',
                                  keyValue: null,
                                  value: widget.element.withLoop ?? false,
                                  callBack: (final flag, final old) {
                                    final old = widget.element;
                                    widget.element.withLoop = flag;
                                    widget.callBack(widget.element, old);
                                  },
                                ),
                              ),
                              const Gap(Grid.small),
                              if (widget.element.withLoop == true)
                                const Padding(
                                  padding: EdgeInsets.only(top: 2, bottom: 4),
                                  child: TParagraph(
                                    'Every milliseconds',
                                  ),
                                ),
                              if (widget.element.withLoop == true)
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 8, bottom: 8),
                                  child: descriptionControlWidget(
                                    description:
                                        'Loop your action TOT milliseconds',
                                    control: Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: SizedBox(
                                        width: double.maxFinite,
                                        child:
                                            BlocListener<FocusBloc, List<int>>(
                                          listener:
                                              (final context, final state) {
                                            if (state.isNotEmpty) {
                                              loopController.text = widget
                                                      .element
                                                      .everyMilliseconds
                                                      ?.value ??
                                                  '0';
                                            }
                                          },
                                          child: CMiniTextField(
                                            backgroundColor: Palette.bgTertiary,
                                            controller: loopController,
                                            callBack: (final text) {
                                              if (int.tryParse(text) != null) {
                                                final old = widget.element;
                                                widget
                                                    .element
                                                    .everyMilliseconds!
                                                    .value = text;
                                                widget.callBack(
                                                    widget.element, old);
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              // Condition
                              const Divider(
                                color: Colors.white24,
                              ),
                              const Gap(Grid.small),
                              descriptionControlWidget(
                                description:
                                    'Should this action be launched if a condition is true?',
                                control: FlagControl(
                                  title: 'By condition',
                                  keyValue: null,
                                  value: widget.element.withCondition ?? false,
                                  callBack: (final flag, final old) {
                                    final old = widget.element;
                                    widget.element.withCondition = flag;
                                    widget.callBack(widget.element, old);
                                  },
                                ),
                              ),
                              const Gap(Grid.small),
                              if (widget.element.withCondition == true)
                                Column(
                                  children: [
                                    TextControl(
                                      valueType: VariableType.string,
                                      value: widget.element.condition ??
                                          FTextTypeInput(),
                                      title: 'Value 1',
                                      callBack: (final value, final old) {
                                        final old = widget.element;
                                        widget.element.condition = value;
                                        widget.callBack(widget.element, old);
                                      },
                                    ),
                                    const Gap(Grid.large),
                                    descriptionControlWidget(
                                      description:
                                          'Condition type: equal, greater than, less than, etc.',
                                      control: ConditionTypeControl(
                                        conditionType:
                                            widget.element.conditionType ??
                                                FConditionType(),
                                        callBack: (final value, final old) {
                                          final old = widget.element;
                                          widget.element.conditionType = value;
                                          widget.callBack(widget.element, old);
                                        },
                                      ),
                                    ),
                                    const Gap(Grid.large),
                                    TextControl(
                                      valueType: VariableType.string,
                                      value: widget.element.valueOfCondition ??
                                          FTextTypeInput(),
                                      title: 'Value 2',
                                      callBack: (final value, final old) {
                                        final old = widget.element;
                                        widget.element.valueOfCondition = value;
                                        widget.callBack(widget.element, old);
                                      },
                                    ),
                                    const Gap(Grid.small),
                                  ],
                                ),
                              const Divider(
                                color: Colors.white24,
                              ),
                              if (widget.element.actionType ==
                                  ActionType.camera)
                                Column(
                                  children: [
                                    CDropdownCustom<String>(
                                      expanded: true,
                                      value:
                                          FActionElement.convertValueToDropdown(
                                        widget.element.actionCamera,
                                      ),
                                      items: FActionElement.getCamera()
                                          .map(
                                            (e) => DropdownCustomMenuItem(
                                              value: e,
                                              child: TParagraph(e),
                                            ),
                                          )
                                          .toList(),
                                      onChange: (final newValue) {
                                        if (newValue != null) {
                                          final old = widget.element;
                                          widget.element.actionCamera =
                                              FActionElement
                                                  .convertDropdownToValue(
                                            ActionCamera.values,
                                            newValue,
                                          ) as ActionCamera?;
                                          widget.callBack(widget.element, old);
                                        }
                                      },
                                    ),
                                    CDropdownCustom<String>(
                                      expanded: true,
                                      value: pageState.page.defaultStates
                                                  .map((final e) => e.name)
                                                  .where((final element) =>
                                                      element != 'null')
                                                  .toList()
                                                  .indexWhere(
                                                    (final e) =>
                                                        e ==
                                                        widget
                                                            .element.stateName,
                                                  ) !=
                                              -1
                                          ? widget.element.stateName
                                          : null,
                                      items: pageState.page.defaultStates
                                          .where(
                                            (final element) =>
                                                element.type ==
                                                VariableType.cameraController,
                                          )
                                          .map((final e) => e.name)
                                          .where((final element) =>
                                              element != 'null')
                                          .map(
                                            (e) => DropdownCustomMenuItem(
                                              value: e,
                                              child: TParagraph(e),
                                            ),
                                          )
                                          .toList(),
                                      onChange: (final newValue) {
                                        if (newValue != null) {
                                          final old = widget.element;
                                          widget.element.stateName = newValue;
                                          widget.callBack(widget.element, old);
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              if (widget.element.actionType == ActionType.theme)
                                CDropdownCustom<String>(
                                  expanded: true,
                                  value: FActionElement.convertValueToDropdown(
                                    widget.element.actionTheme,
                                  ),
                                  items: FActionElement.getTheme()
                                      .map(
                                        (e) => DropdownCustomMenuItem(
                                          value: e,
                                          child: TParagraph(e),
                                        ),
                                      )
                                      .toList(),
                                  onChange: (final newValue) {
                                    if (newValue != null) {
                                      final old = widget.element;
                                      widget.element.actionTheme =
                                          FActionElement.convertDropdownToValue(
                                        ActionTheme.values,
                                        newValue,
                                      ) as ActionTheme?;
                                      widget.callBack(widget.element, old);
                                    }
                                  },
                                ),
                              if (widget.element.actionType ==
                                  ActionType.audioPlayer)
                                Column(
                                  children: [
                                    CDropdownCustom<String>(
                                      expanded: true,
                                      value:
                                          FActionElement.convertValueToDropdown(
                                        widget.element.actionAudioPlayer,
                                      ),
                                      items: FActionElement.getAudioPlayer()
                                          .map(
                                            (e) => DropdownCustomMenuItem(
                                              value: e,
                                              child: TParagraph(e),
                                            ),
                                          )
                                          .toList(),
                                      onChange: (final newValue) {
                                        if (newValue != null) {
                                          final old = widget.element;
                                          widget.element.actionAudioPlayer =
                                              FActionElement
                                                  .convertDropdownToValue(
                                            ActionAudioPlayerActions.values,
                                            newValue,
                                          ) as ActionAudioPlayerActions?;
                                          widget.callBack(widget.element, old);
                                        }
                                      },
                                    ),
                                    CDropdownCustom<String>(
                                      expanded: true,
                                      value: pageState.page.defaultStates
                                                  .where(
                                                    (final element) =>
                                                        element.type ==
                                                        VariableType
                                                            .audioController,
                                                  )
                                                  .map((final e) => e.name)
                                                  .where((final element) =>
                                                      element != 'null')
                                                  .toList()
                                                  .indexWhere(
                                                    (final e) =>
                                                        e ==
                                                        widget
                                                            .element.stateName,
                                                  ) !=
                                              -1
                                          ? widget.element.stateName
                                          : null,
                                      items: pageState.page.defaultStates
                                          .where(
                                            (final element) =>
                                                element.type ==
                                                VariableType.audioController,
                                          )
                                          .map((final e) => e.name)
                                          .where((final element) =>
                                              element != 'null')
                                          .map(
                                            (e) => DropdownCustomMenuItem(
                                              value: e,
                                              child: TParagraph(e),
                                            ),
                                          )
                                          .toList(),
                                      onChange: (final newValue) {
                                        if (newValue != null) {
                                          final old = widget.element;
                                          widget.element.stateName = newValue;
                                          widget.callBack(widget.element, old);
                                        }
                                      },
                                    ),
                                    // TextControl(node: widget.node,
                                    //     value: widget.element.audioPlayerUrl!,
                                    //     page: widget.page,
                                    //     title: 'Url',
                                    //     callBack: (final newVal, final oldVal) {
                                    //       final old = widget.element;
                                    //       widget.element.audioPlayerUrl = newVal;
                                    //       widget.callBack(widget.element, old);
                                    //     },
                                    // ),
                                  ],
                                ),
                              if (widget.element.actionType ==
                                  ActionType.webview)
                                Column(
                                  children: [
                                    CDropdownCustom<String>(
                                      expanded: true,
                                      value:
                                          FActionElement.convertValueToDropdown(
                                        widget.element.actionWebView,
                                      ),
                                      items: FActionElement.getWebView()
                                          .map(
                                            (e) => DropdownCustomMenuItem(
                                              value: e,
                                              child: TParagraph(e),
                                            ),
                                          )
                                          .toList(),
                                      onChange: (final newValue) {
                                        if (newValue != null) {
                                          final old = widget.element;
                                          widget.element.actionWebView =
                                              FActionElement
                                                  .convertDropdownToValue(
                                            ActionWebView.values,
                                            newValue,
                                          ) as ActionWebView?;
                                          widget.callBack(widget.element, old);
                                        }
                                      },
                                    ),
                                    const Gap(Grid.medium),
                                    const TParagraph('Which controller?'),
                                    const Gap(Grid.small),
                                    CDropdownCustom<String>(
                                      expanded: true,
                                      value: pageState.page.defaultStates
                                                  .where(
                                                    (final element) =>
                                                        element.type ==
                                                        VariableType
                                                            .webViewController,
                                                  )
                                                  .map((final e) => e.name)
                                                  .where((final element) =>
                                                      element != 'null')
                                                  .toList()
                                                  .indexWhere(
                                                    (final e) =>
                                                        e ==
                                                        widget
                                                            .element.stateName,
                                                  ) !=
                                              -1
                                          ? widget.element.stateName
                                          : null,
                                      items: pageState.page.defaultStates
                                          .where(
                                            (final element) =>
                                                element.type ==
                                                VariableType.webViewController,
                                          )
                                          .map((final e) => e.name)
                                          .where((final element) =>
                                              element != 'null')
                                          .map(
                                            (e) => DropdownCustomMenuItem(
                                              value: e,
                                              child: TParagraph(e),
                                            ),
                                          )
                                          .toList(),
                                      onChange: (final newValue) {
                                        if (newValue != null) {
                                          final old = widget.element;
                                          widget.element.stateName = newValue;
                                          widget.callBack(widget.element, old);
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              if (widget.element.actionType == ActionType.state)
                                CDropdownCustom<String>(
                                  expanded: true,
                                  value: FActionElement.convertValueToDropdown(
                                    widget.element.actionState,
                                  ),
                                  items: FActionElement.getState()
                                      .map(
                                        (e) => DropdownCustomMenuItem(
                                          value: e,
                                          child: TParagraph(e),
                                        ),
                                      )
                                      .toList(),
                                  onChange: (final newValue) {
                                    if (newValue != null) {
                                      final old = widget.element;
                                      widget.element.actionState =
                                          FActionElement.convertDropdownToValue(
                                        ActionState.values,
                                        newValue,
                                      ) as ActionState?;
                                      widget.callBack(widget.element, old);
                                    }
                                  },
                                ),
                              if (widget.element.actionType ==
                                  ActionType.translator)
                                CDropdownCustom<String>(
                                  expanded: true,
                                  value: FActionElement.getTranslator()
                                          .contains(
                                    FActionElement.convertValueToDropdown(
                                      widget.element.actionTranslator,
                                    ),
                                  )
                                      ? FActionElement.convertValueToDropdown(
                                          widget.element.actionTranslator,
                                        )
                                      : null,
                                  items: FActionElement.getTranslator()
                                      .map(
                                        (e) => DropdownCustomMenuItem(
                                          value: e,
                                          child: TParagraph(e),
                                        ),
                                      )
                                      .toList(),
                                  onChange: (final newValue) {
                                    if (newValue != null) {
                                      final old = widget.element;
                                      widget.element.actionTranslator =
                                          FActionElement.convertDropdownToValue(
                                        ActionTranslator.values,
                                        newValue,
                                      ) as ActionTranslator?;
                                      widget.callBack(widget.element, old);
                                    }
                                  },
                                ),
                              const Gap(Grid.small),
                              if (widget.element.actionType ==
                                  ActionType.navigation)
                                CDropdownCustom<String>(
                                  expanded: true,
                                  value: FActionElement.convertValueToDropdown(
                                    widget.element.actionNavigation,
                                  ),
                                  items: FActionElement.getNavigation()
                                      .toSet()
                                      .map(
                                        (e) => DropdownCustomMenuItem(
                                          value: e,
                                          child: TParagraph(e),
                                        ),
                                      )
                                      .toList(),
                                  onChange: (final newValue) {
                                    if (newValue != null) {
                                      final old = widget.element;
                                      widget.element.actionNavigation =
                                          FActionElement.convertDropdownToValue(
                                        ActionNavigation.values,
                                        newValue,
                                      ) as ActionNavigation?;
                                      widget.callBack(widget.element, old);
                                    }
                                  },
                                ),
                              const Gap(Grid.small),
                              if (widget.element.actionType ==
                                      ActionType.state &&
                                  (widget.element.actionState ==
                                          ActionState.emailValidator ||
                                      widget.element.actionState ==
                                          ActionState.passwordValidator ||
                                      widget.element.actionState ==
                                          ActionState.websiteValidator ||
                                      widget.element.actionState ==
                                          ActionState.phoneValidator))
                                AValidatorControl(
                                  action: widget.element,
                                  callback: (final value, final old) {
                                    widget.callBack(value, old);
                                  },
                                ),
                              if ((widget.element.actionType ==
                                          ActionType.state &&
                                      widget.element.actionState ==
                                          ActionState.changeWith) ||
                                  (widget.element.actionType ==
                                          ActionType.state &&
                                      widget.element.actionState ==
                                          ActionState.pickFile) ||
                                  (widget.element.actionType ==
                                          ActionType.translator &&
                                      widget.element.actionTranslator ==
                                          ActionTranslator.translate))
                                CDropdownCustom<String>(
                                  expanded: true,
                                  value: pageState.page.defaultStates
                                              .map((final e) => e.name)
                                              .where((final element) =>
                                                  element != 'null')
                                              .toList()
                                              .indexWhere(
                                                (final e) =>
                                                    e ==
                                                    widget.element.stateName,
                                              ) !=
                                          -1
                                      ? widget.element.stateName
                                      : null,
                                  items: pageState.page.defaultStates
                                      .map((final e) => e.name)
                                      .where(
                                          (final element) => element != 'null')
                                      .map(
                                        (e) => DropdownCustomMenuItem(
                                          value: e,
                                          child: TParagraph(e),
                                        ),
                                      )
                                      .toList(),
                                  onChange: (final newValue) {
                                    if (newValue != null) {
                                      try {
                                        final old = widget.element;
                                        widget.element.stateName = newValue;
                                        widget.callBack(widget.element, old);
                                      } catch (e) {}
                                    }
                                  },
                                ),
                              const Gap(Grid.small),
                              if (widget.element.actionType ==
                                      ActionType.state &&
                                  (widget.element.actionState ==
                                          ActionState.increment ||
                                      widget.element.actionState ==
                                          ActionState.decrement))
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CDropdownCustom<String>(
                                      expanded: true,
                                      value: pageState.page.defaultStates
                                                  .map((final e) => e.name)
                                                  .where((final element) =>
                                                      element != 'null')
                                                  .toList()
                                                  .indexWhere(
                                                    (final e) =>
                                                        e ==
                                                        widget
                                                            .element.stateName,
                                                  ) !=
                                              -1
                                          ? widget.element.stateName
                                          : null,
                                      items: pageState.page.defaultStates
                                          .where(
                                            (final element) =>
                                                element.type ==
                                                    VariableType.int ||
                                                element.type ==
                                                    VariableType.double ||
                                                element.type ==
                                                    VariableType.string,
                                          )
                                          .map((final e) => e.name)
                                          .where((final element) =>
                                              element != 'null')
                                          .map(
                                            (e) => DropdownCustomMenuItem(
                                              value: e,
                                              child: TParagraph(e),
                                            ),
                                          )
                                          .toList(),
                                      onChange: (final newValue) {
                                        if (newValue != null) {
                                          final old = widget.element;
                                          widget.element.stateName = newValue;
                                          widget.callBack(widget.element, old);
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
                                ),
                              if (widget.element.actionType ==
                                      ActionType.state &&
                                  widget.element.actionState ==
                                      ActionState.changeWithParams)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding:
                                          EdgeInsets.only(top: 2, bottom: 4),
                                      child: TParagraph(
                                        'Parameter',
                                      ),
                                    ),
                                    CDropdownCustom<String>(
                                      expanded: true,
                                      value: pageState.page.defaultParams
                                                  .map((final e) => e.name)
                                                  .where((final element) =>
                                                      element != 'null')
                                                  .toList()
                                                  .indexWhere(
                                                    (final e) =>
                                                        e ==
                                                        widget.element.value,
                                                  ) !=
                                              -1
                                          ? widget.element.value
                                          : null,
                                      items: pageState.page.defaultParams
                                          .map((final e) => e.name)
                                          .where((final element) =>
                                              element != 'null')
                                          .map(
                                            (e) => DropdownCustomMenuItem(
                                              value: e,
                                              child: TParagraph(e),
                                            ),
                                          )
                                          .toList(),
                                      onChange: (final newValue) {
                                        if (newValue != null) {
                                          final old = widget.element;
                                          widget.element.value = newValue;
                                          widget.callBack(widget.element, old);
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              if (widget.element.actionType ==
                                  ActionType.customFunctions)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding:
                                          EdgeInsets.only(top: 8, bottom: 8),
                                      child: TParagraph('Which Function?'),
                                    ),
                                    Builder(
                                      builder: (final _) {
                                        final functions = BlocProvider.of<
                                                CustomFunctionsCubit>(context)
                                            .state;
                                        final tempList = <String>[];
                                        for (final item in functions) {
                                          tempList.add(item.name);
                                        }
                                        if (functions.isNotEmpty) {
                                          return SizedBox(
                                            height: 50,
                                            child: CDropdownCustom<String>(
                                              expanded: true,
                                              value: currentCustomFunctionValue,
                                              items: tempList
                                                  .map(
                                                    (e) =>
                                                        DropdownCustomMenuItem(
                                                      value: e,
                                                      child: TParagraph(e),
                                                    ),
                                                  )
                                                  .toList(),
                                              onChange: (final newValue) {
                                                if (newValue != null) {
                                                  currentCustomFunctionValue =
                                                      newValue;
                                                  final old = widget.element;
                                                  widget.element
                                                          .customFunctionId =
                                                      functions
                                                          .firstWhere(
                                                            (final element) =>
                                                                element.name ==
                                                                newValue,
                                                          )
                                                          .id;
                                                  widget.callBack(
                                                      widget.element, old);
                                                }
                                              },
                                            ),
                                          );
                                        } else {
                                          return Container();
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              //todo: make the open date picker
                              if (widget.element.actionType ==
                                      ActionType.navigation &&
                                  widget.element.actionNavigation ==
                                      ActionNavigation.openDatePicker)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding:
                                          EdgeInsets.only(top: 8, bottom: 8),
                                      child: TParagraph(
                                          'Which State needs to change?'),
                                    ),
                                    Builder(
                                      builder: (final context) {
                                        final states =
                                            pageState.page.defaultStates;
                                        final statesNameList = <String>[];
                                        for (final item in states) {
                                          statesNameList.add(item.name);
                                        }
                                        return CDropdownCustom<String>(
                                          expanded: true,
                                          value: currentStateNameValue,
                                          items: statesNameList
                                              .map(
                                                (e) => DropdownCustomMenuItem(
                                                  value: e,
                                                  child: TParagraph(e),
                                                ),
                                              )
                                              .toList(),
                                          onChange: (final newValue) {
                                            if (newValue != null) {
                                              currentStateNameValue = newValue;
                                              final old = widget.element;
                                              widget.element.stateName = states
                                                  .firstWhere(
                                                    (final element) =>
                                                        element.name ==
                                                        newValue,
                                                  )
                                                  .name;
                                              widget.callBack(
                                                  widget.element, old);
                                            }
                                          },
                                        );
                                      },
                                    ),
                                  ],
                                ),

                              if (widget.element.actionType ==
                                  ActionType.braintree)
                                Column(
                                  children: [
                                    CDropdownCustom<String>(
                                      expanded: true,
                                      value:
                                          FActionElement.convertValueToDropdown(
                                        widget.element.actionBraintree,
                                      ),
                                      items: FActionElement.getBraintree(config)
                                          .toSet()
                                          .map(
                                            (e) => DropdownCustomMenuItem(
                                              value: e,
                                              child: TParagraph(e),
                                            ),
                                          )
                                          .toList(),
                                      onChange: (final newValue) {
                                        if (newValue != null) {
                                          final old = widget.element;
                                          widget.element.actionBraintree =
                                              FActionElement
                                                  .convertDropdownToValue(
                                            ActionBraintree.values,
                                            newValue,
                                          ) as ActionBraintree?;
                                          widget.callBack(widget.element, old);
                                        }
                                      },
                                    ),
                                    const Gap(Grid.medium),
                                    SizedBox(
                                      width: double.maxFinite,
                                      child: descriptionControlWidget(
                                        description: 'e.g. 4.20',
                                        control: TextControl(
                                          valueType: VariableType.double,
                                          value: widget
                                                  .element.valueTextTypeInput ??
                                              FTextTypeInput(),
                                          title: 'Amount',
                                          callBack: (final value, final old) {
                                            final old = widget.element;
                                            widget.element.valueTextTypeInput =
                                                value;
                                            widget.element.valueOfCondition =
                                                value;
                                            widget.callBack(
                                                widget.element, old);
                                          },
                                        ),
                                      ),
                                    ),
                                    const Gap(Grid.medium),
                                    const TParagraph(
                                      'Choose a variable to save the status of the operation',
                                    ),
                                    TDetailLabel(
                                      "The selected variable is set to 'Loading' during the operation, to 'Successful' if the payment is successful and to 'Failed' if it is not successful. The variable must be of String type.",
                                      color:
                                          Palette.txtPrimary.withOpacity(0.6),
                                    ),
                                    const Gap(Grid.small),
                                    CDropdownCustom<String>(
                                      expanded: true,
                                      value: pageState.page.defaultStates
                                                  .map((final e) => e.name)
                                                  .where((final element) =>
                                                      element != 'null')
                                                  .toList()
                                                  .indexWhere(
                                                    (final e) =>
                                                        e ==
                                                        widget
                                                            .element.stateName,
                                                  ) !=
                                              -1
                                          ? widget.element.stateName
                                          : null,
                                      items: pageState.page.defaultStates
                                          .map((final e) => e.name)
                                          .where((final element) =>
                                              element != 'null')
                                          .map(
                                            (e) => DropdownCustomMenuItem(
                                              value: e,
                                              child: TParagraph(e),
                                            ),
                                          )
                                          .toList(),
                                      onChange: (final newValue) {
                                        if (newValue != null) {
                                          try {
                                            final old = widget.element;
                                            widget.element.stateName = newValue;
                                            widget.callBack(
                                                widget.element, old);
                                          } catch (e) {}
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              if (widget.element.actionType ==
                                  ActionType.revenueCat)
                                RevenueCatBuyActionWidget(
                                  element: widget.element,
                                  callback: widget.callBack,
                                ),
                              if (widget.element.actionType ==
                                  ActionType.qonversion)
                                QonversionActionWidget(
                                  element: widget.element,
                                  callback: widget.callBack,
                                ),
                              if (ActionType.googleMaps ==
                                  widget.element.actionType)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Gap(Grid.medium),
                                    const TParagraph(
                                      'Action type',
                                      isCentered: false,
                                    ),
                                    CDropdownCustom<String>(
                                      expanded: true,
                                      value:
                                          FActionElement.convertValueToDropdown(
                                        widget.element.actionGoogleMaps,
                                      ),
                                      items:
                                          FActionElement.getGoogleMaps(config)
                                              .toSet()
                                              .map(
                                                (e) => DropdownCustomMenuItem(
                                                  value: e,
                                                  child: TParagraph(e),
                                                ),
                                              )
                                              .toList(),
                                      onChange: (final newValue) {
                                        if (newValue != null) {
                                          final old = widget.element;
                                          widget.element.actionGoogleMaps =
                                              FActionElement
                                                  .convertDropdownToValue(
                                            ActionGoogleMaps.values,
                                            newValue,
                                          ) as ActionGoogleMaps?;
                                          widget.callBack(widget.element, old);
                                        }
                                      },
                                    ),
                                    const Gap(Grid.medium),
                                    const TParagraph(
                                      'Google Maps Cubit',
                                      isCentered: false,
                                    ),
                                    descriptionControlWidget(
                                      description: 'Google Maps Cubit',
                                      control: CDropdownCustom<String>(
                                        expanded: true,
                                        value: pageState.page.defaultStates
                                                    .where(
                                                      (final element) =>
                                                          element.type ==
                                                          VariableType
                                                              .googleMapsCubit,
                                                    )
                                                    .map((final e) => e.name)
                                                    .where((final element) =>
                                                        element != 'null')
                                                    .toList()
                                                    .indexWhere(
                                                      (final e) =>
                                                          e ==
                                                          widget.element
                                                              .stateName,
                                                    ) !=
                                                -1
                                            ? widget.element.stateName
                                            : null,
                                        items: pageState.page.defaultStates
                                            .where(
                                              (final element) =>
                                                  element.type ==
                                                  VariableType.googleMapsCubit,
                                            )
                                            .map((final e) => e.name)
                                            .where((final element) =>
                                                element != 'null')
                                            .map(
                                              (e) => DropdownCustomMenuItem(
                                                value: e,
                                                child: TParagraph(e),
                                              ),
                                            )
                                            .toList(),
                                        onChange: (final newValue) {
                                          if (newValue != null) {
                                            final old = widget.element;
                                            widget.element.stateName = newValue;
                                            widget.callBack(
                                                widget.element, old);
                                          }
                                        },
                                      ),
                                    ),
                                    const Gap(Grid.medium),
                                    const TParagraph(
                                      'Google Maps Controller',
                                      isCentered: false,
                                    ),
                                    descriptionControlWidget(
                                      description: 'Google Maps Controller',
                                      control: CDropdownCustom<String>(
                                        expanded: true,
                                        value: pageState.page.defaultStates
                                                    .where(
                                                      (final element) =>
                                                          element.type ==
                                                          VariableType
                                                              .googleMapsController,
                                                    )
                                                    .map((final e) => e.name)
                                                    .where((final element) =>
                                                        element != 'null')
                                                    .toList()
                                                    .indexWhere(
                                                      (final e) =>
                                                          e ==
                                                          widget.element
                                                              .stateName2,
                                                    ) !=
                                                -1
                                            ? widget.element.stateName2
                                            : null,
                                        items: pageState.page.defaultStates
                                            .where(
                                              (final element) =>
                                                  element.type ==
                                                  VariableType
                                                      .googleMapsController,
                                            )
                                            .map((final e) => e.name)
                                            .where((final element) =>
                                                element != 'null')
                                            .map(
                                              (e) => DropdownCustomMenuItem(
                                                value: e,
                                                child: TParagraph(e),
                                              ),
                                            )
                                            .toList(),
                                        onChange: (final newValue) {
                                          if (newValue != null) {
                                            final old = widget.element;
                                            widget.element.stateName2 =
                                                newValue;
                                            widget.callBack(
                                                widget.element, old);
                                          }
                                        },
                                      ),
                                    ),
                                    if (ActionGoogleMaps.updateLiveLocation ==
                                        widget.element.actionGoogleMaps) ...[
                                      const Gap(Grid.medium),
                                      const TParagraph(
                                        'Latitude variable',
                                        isCentered: false,
                                      ),
                                      descriptionControlWidget(
                                        description:
                                            'Each time a new location is streamed it will be stored here.',
                                        control: CDropdownCustom<String>(
                                          expanded: true,
                                          value: pageState.page.defaultStates
                                                      .where(
                                                        (final element) =>
                                                            element.type ==
                                                            VariableType.double,
                                                      )
                                                      .map((final e) => e.name)
                                                      .where(
                                                        (final element) =>
                                                            element != 'null',
                                                      )
                                                      .toList()
                                                      .indexWhere(
                                                        (final e) =>
                                                            e ==
                                                            widget.element
                                                                .stateName3,
                                                      ) !=
                                                  -1
                                              ? widget.element.stateName3
                                              : null,
                                          items: pageState.page.defaultStates
                                              .where(
                                                (final element) =>
                                                    element.type ==
                                                    VariableType.double,
                                              )
                                              .map((final e) => e.name)
                                              .where((final element) =>
                                                  element != 'null')
                                              .map(
                                                (e) => DropdownCustomMenuItem(
                                                  value: e,
                                                  child: TParagraph(e),
                                                ),
                                              )
                                              .toList(),
                                          onChange: (final newValue) {
                                            if (newValue != null) {
                                              final old = widget.element;
                                              widget.element.stateName3 =
                                                  newValue;
                                              widget.callBack(
                                                  widget.element, old);
                                            }
                                          },
                                        ),
                                      ),
                                      const Gap(Grid.medium),
                                      const TParagraph(
                                        'Longitude Variable',
                                        isCentered: false,
                                      ),
                                      descriptionControlWidget(
                                        description:
                                            'Each time a new location is streamed it will be stored here.',
                                        control: CDropdownCustom<String>(
                                          expanded: true,
                                          value: pageState.page.defaultStates
                                                      .where(
                                                        (final element) =>
                                                            element.type ==
                                                            VariableType.double,
                                                      )
                                                      .map((final e) => e.name)
                                                      .where(
                                                        (final element) =>
                                                            element != 'null',
                                                      )
                                                      .toList()
                                                      .indexWhere(
                                                        (final e) =>
                                                            e ==
                                                            widget.element
                                                                .stateName4,
                                                      ) !=
                                                  -1
                                              ? widget.element.stateName4
                                              : null,
                                          items: pageState.page.defaultStates
                                              .where(
                                                (final element) =>
                                                    element.type ==
                                                    VariableType.double,
                                              )
                                              .map((final e) => e.name)
                                              .where((final element) =>
                                                  element != 'null')
                                              .map(
                                                (e) => DropdownCustomMenuItem(
                                                  value: e,
                                                  child: TParagraph(e),
                                                ),
                                              )
                                              .toList(),
                                          onChange: (final newValue) {
                                            if (newValue != null) {
                                              final old = widget.element;
                                              widget.element.stateName4 =
                                                  newValue;
                                              widget.callBack(
                                                  widget.element, old);
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                    if (ActionGoogleMaps.setCameraPosition ==
                                        widget.element.actionGoogleMaps) ...[
                                      Padding(
                                        padding: const EdgeInsets.only(top: 8),
                                        child: SizedBox(
                                          width: double.maxFinite,
                                          child: descriptionControlWidget(
                                            description: 'Camera Latitude',
                                            control: TextControl(
                                              valueType: VariableType.double,
                                              value: widget
                                                      .element.googleMapsLat ??
                                                  FTextTypeInput(),
                                              title: 'Camera Latitude',
                                              callBack:
                                                  (final value, final old) {
                                                final old = widget.element;
                                                widget.element.googleMapsLat =
                                                    value;
                                                widget.element
                                                    .valueOfCondition = value;
                                                widget.callBack(
                                                    widget.element, old);
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 8),
                                        child: SizedBox(
                                          width: double.maxFinite,
                                          child: descriptionControlWidget(
                                            description: 'Camera Longitude',
                                            control: TextControl(
                                              valueType: VariableType.double,
                                              value: widget
                                                      .element.googleMapsLng ??
                                                  FTextTypeInput(),
                                              title: 'Camera Longitude',
                                              callBack:
                                                  (final value, final old) {
                                                final old = widget.element;
                                                widget.element.googleMapsLng =
                                                    value;
                                                widget.element
                                                    .valueOfCondition = value;
                                                widget.callBack(
                                                    widget.element, old);
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 8),
                                        child: SizedBox(
                                          width: double.maxFinite,
                                          child: descriptionControlWidget(
                                            description: 'Camera Zoom',
                                            control: TextControl(
                                              valueType: VariableType.string,
                                              value: widget
                                                      .element.googleMapsZoom ??
                                                  FTextTypeInput(),
                                              title: 'Camera Zoom',
                                              callBack:
                                                  (final value, final old) {
                                                final old = widget.element;
                                                widget.element.googleMapsZoom =
                                                    value;
                                                widget.element
                                                    .valueOfCondition = value;
                                                widget.callBack(
                                                    widget.element, old);
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ]
                                  ],
                                ),
                              if (widget.element.actionType ==
                                  ActionType.tetaStore)
                                Column(
                                  children: [
                                    CDropdownCustom<String>(
                                      expanded: true,
                                      value:
                                          FActionElement.convertValueToDropdown(
                                        widget.element.actionTetaStore,
                                      ),
                                      items: FActionElement.getTetaStore()
                                          .toSet()
                                          .map(
                                            (e) => DropdownCustomMenuItem(
                                              value: e,
                                              child: TParagraph(e),
                                            ),
                                          )
                                          .toList(),
                                      onChange: (final newValue) {
                                        if (newValue != null) {
                                          final old = widget.element;
                                          widget.element.actionTetaStore =
                                              FActionElement
                                                  .convertDropdownToValue(
                                            ActionTetaStore.values,
                                            newValue,
                                          ) as ActionTetaStore?;
                                          widget.callBack(widget.element, old);
                                        }
                                      },
                                    ),
                                    if (ActionTetaStore.buyCartItems ==
                                        widget.element.actionTetaStore) ...[
                                      Padding(
                                        padding: const EdgeInsets.only(top: 8),
                                        child: SizedBox(
                                          width: double.maxFinite,
                                          child: descriptionControlWidget(
                                            description: 'Billing email',
                                            control: TextControl(
                                              valueType: VariableType.string,
                                              value: widget.element
                                                      .stripeBillingInfoEmail ??
                                                  FTextTypeInput(),
                                              title: 'Billing email',
                                              callBack:
                                                  (final value, final old) {
                                                final old = widget.element;
                                                widget.element
                                                        .stripeBillingInfoEmail =
                                                    value;
                                                widget.element
                                                    .valueOfCondition = value;
                                                widget.callBack(
                                                    widget.element, old);
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 8),
                                        child: SizedBox(
                                          width: double.maxFinite,
                                          child: descriptionControlWidget(
                                            description: 'Billing phone',
                                            control: TextControl(
                                              valueType: VariableType.string,
                                              value: widget.element
                                                      .stripeBillingInfoPhone ??
                                                  FTextTypeInput(),
                                              title: 'Billing phone',
                                              callBack:
                                                  (final value, final old) {
                                                final old = widget.element;
                                                widget.element
                                                        .stripeBillingInfoPhone =
                                                    value;
                                                widget.element
                                                    .valueOfCondition = value;
                                                widget.callBack(
                                                    widget.element, old);
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 8),
                                        child: SizedBox(
                                          width: double.maxFinite,
                                          child: descriptionControlWidget(
                                            description: 'Billing city',
                                            control: TextControl(
                                              valueType: VariableType.string,
                                              value: widget.element
                                                      .stripeBillingInfoCity ??
                                                  FTextTypeInput(),
                                              title: 'Billing city',
                                              callBack:
                                                  (final value, final old) {
                                                final old = widget.element;
                                                widget.element
                                                        .stripeBillingInfoCity =
                                                    value;
                                                widget.element
                                                    .valueOfCondition = value;
                                                widget.callBack(
                                                    widget.element, old);
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 8),
                                        child: SizedBox(
                                          width: double.maxFinite,
                                          child: descriptionControlWidget(
                                            description: 'Billing state',
                                            control: TextControl(
                                              valueType: VariableType.string,
                                              value: widget.element
                                                      .stripeBillingInfoState ??
                                                  FTextTypeInput(),
                                              title: 'Billing state',
                                              callBack:
                                                  (final value, final old) {
                                                final old = widget.element;
                                                widget.element
                                                        .stripeBillingInfoState =
                                                    value;
                                                widget.element
                                                    .valueOfCondition = value;
                                                widget.callBack(
                                                    widget.element, old);
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 8),
                                        child: SizedBox(
                                          width: double.maxFinite,
                                          child: descriptionControlWidget(
                                            description: 'Billing line',
                                            control: TextControl(
                                              valueType: VariableType.string,
                                              value: widget.element
                                                      .stripeBillingInfoLine ??
                                                  FTextTypeInput(),
                                              title: 'Billing line',
                                              callBack:
                                                  (final value, final old) {
                                                final old = widget.element;
                                                widget.element
                                                        .stripeBillingInfoLine =
                                                    value;
                                                widget.element
                                                    .valueOfCondition = value;
                                                widget.callBack(
                                                    widget.element, old);
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 8),
                                        child: SizedBox(
                                          width: double.maxFinite,
                                          child: descriptionControlWidget(
                                            description: 'Billing Postal Code',
                                            control: TextControl(
                                              valueType: VariableType.string,
                                              value: widget.element
                                                      .stripeBillingInfoPostalCode ??
                                                  FTextTypeInput(),
                                              title: 'Billing postal code',
                                              callBack:
                                                  (final value, final old) {
                                                final old = widget.element;
                                                widget.element
                                                        .stripeBillingInfoPostalCode =
                                                    value;
                                                widget.element
                                                    .valueOfCondition = value;
                                                widget.callBack(
                                                    widget.element, old);
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 8),
                                        child: SizedBox(
                                          width: double.maxFinite,
                                          child: descriptionControlWidget(
                                            description: 'Billing country',
                                            control: TextControl(
                                              valueType: VariableType.string,
                                              value: widget.element
                                                      .stripeBillingInfoCountry ??
                                                  FTextTypeInput(),
                                              title: 'Billing country',
                                              callBack:
                                                  (final value, final old) {
                                                final old = widget.element;
                                                widget.element
                                                        .stripeBillingInfoCountry =
                                                    value;
                                                widget.element
                                                    .valueOfCondition = value;
                                                widget.callBack(
                                                    widget.element, old);
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 8),
                                        child: SizedBox(
                                          width: double.maxFinite,
                                          child: descriptionControlWidget(
                                            description: 'Shipping id',
                                            control: TextControl(
                                              valueType: VariableType.string,
                                              value: widget.element
                                                      .stripeShippingId ??
                                                  FTextTypeInput(),
                                              title: 'Shipping id',
                                              callBack:
                                                  (final value, final old) {
                                                final old = widget.element;
                                                widget.element
                                                    .stripeShippingId = value;
                                                widget.element
                                                    .valueOfCondition = value;
                                                widget.callBack(
                                                    widget.element, old);
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                    if (ActionTetaStore.showReceipt ==
                                        widget.element.actionTetaStore) ...[
                                      Padding(
                                        padding: const EdgeInsets.only(top: 8),
                                        child: SizedBox(
                                          width: double.maxFinite,
                                          child: descriptionControlWidget(
                                            description: 'Payment Intent Id',
                                            control: TextControl(
                                              valueType: VariableType.string,
                                              value: widget.element
                                                      .stripePaymentIntentId ??
                                                  FTextTypeInput(),
                                              title: 'Payment Intent Id',
                                              callBack:
                                                  (final value, final old) {
                                                final old = widget.element;
                                                widget.element
                                                        .stripePaymentIntentId =
                                                    value;
                                                widget.element
                                                    .valueOfCondition = value;
                                                widget.callBack(
                                                    widget.element, old);
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ]
                                  ],
                                ),
                              if (widget.element.actionType ==
                                  ActionType.tetaAuth)
                                CDropdownCustom<String>(
                                  expanded: true,
                                  value: FActionElement.convertValueToDropdown(
                                    widget.element.actionTetaAuth,
                                  ),
                                  items: FActionElement.getTetaAuth()
                                      .map(
                                        (e) => DropdownCustomMenuItem(
                                          value: e,
                                          child: TParagraph(e),
                                        ),
                                      )
                                      .toList(),
                                  onChange: (final newValue) {
                                    if (newValue != null) {
                                      final old = widget.element;
                                      widget.element.actionTetaAuth =
                                          FActionElement.convertDropdownToValue(
                                        ActionTetaCmsAuth.values,
                                        newValue,
                                      ) as ActionTetaCmsAuth?;
                                      widget.callBack(widget.element, old);
                                    }
                                  },
                                ),
                              if (widget.element.actionType == ActionType.alert)
                                CDropdownCustom<String>(
                                  expanded: true,
                                  value: FActionElement.convertValueToDropdown(
                                    widget.element.actionAlert,
                                  ),
                                  items: FActionElement.getAlert()
                                      .toSet()
                                      .map(
                                        (e) => DropdownCustomMenuItem(
                                          value: e,
                                          child: TParagraph(e),
                                        ),
                                      )
                                      .toList(),
                                  onChange: (final newValue) {
                                    if (newValue != null) {
                                      final old = widget.element;
                                      widget.element.actionAlert =
                                          FActionElement.convertDropdownToValue(
                                        ActionAlert.values,
                                        newValue,
                                      ) as ActionAlert?;
                                      widget.callBack(widget.element, old);
                                    }
                                  },
                                ),

                              if (widget.element.actionType ==
                                  ActionType.airtable)
                                CDropdownCustom<String>(
                                  expanded: true,
                                  value: FActionElement.convertValueToDropdown(
                                    widget.element.actionAirtableDB,
                                  ),
                                  items: FActionElement.getAirtableDB(config)
                                      .map(
                                        (e) => DropdownCustomMenuItem(
                                          value: e,
                                          child: TParagraph(e),
                                        ),
                                      )
                                      .toList(),
                                  onChange: (final newValue) {
                                    if (newValue != null) {
                                      final old = widget.element;
                                      widget.element.actionAirtableDB =
                                          FActionElement.convertDropdownToValue(
                                        ActionAirtableDB.values,
                                        newValue,
                                      ) as ActionAirtableDB?;
                                      widget.callBack(widget.element, old);
                                    }
                                  },
                                ),
                              if (widget.element.actionType ==
                                  ActionType.supabaseAuth)
                                CDropdownCustom<String>(
                                  expanded: true,
                                  value: FActionElement.convertValueToDropdown(
                                    widget.element.actionSupabaseAuth,
                                  ),
                                  items: FActionElement.getSupabaseAuth(config)
                                      .map(
                                        (e) => DropdownCustomMenuItem(
                                          value: e,
                                          child: TParagraph(e),
                                        ),
                                      )
                                      .toList(),
                                  onChange: (final newValue) {
                                    if (newValue != null) {
                                      final old = widget.element;
                                      widget.element.actionSupabaseAuth =
                                          FActionElement.convertDropdownToValue(
                                        ActionSupabaseAuth.values,
                                        newValue,
                                      ) as ActionSupabaseAuth?;
                                      widget.callBack(widget.element, old);
                                    }
                                  },
                                ),
                              if (widget.element.actionType ==
                                  ActionType.supabaseDatabase)
                                CDropdownCustom<String>(
                                  expanded: true,
                                  value: FActionElement.convertValueToDropdown(
                                    widget.element.actionSupabaseDB,
                                  ),
                                  items: FActionElement.getSupabaseDB(config)
                                      .toSet()
                                      .map(
                                        (e) => DropdownCustomMenuItem(
                                          value: e,
                                          child: TParagraph(e),
                                        ),
                                      )
                                      .toList(),
                                  onChange: (final newValue) {
                                    if (newValue != null) {
                                      final old = widget.element;
                                      widget.element.actionSupabaseDB =
                                          FActionElement.convertDropdownToValue(
                                        ActionSupabaseDB.values,
                                        newValue,
                                      ) as ActionSupabaseDB?;
                                      widget.callBack(widget.element, old);
                                    }
                                  },
                                ),
                              if (widget.element.actionType ==
                                  ActionType.supabaseFunctions)
                                Column(
                                  children: [
                                    CDropdownCustom<String>(
                                      expanded: true,
                                      value:
                                          FActionElement.convertValueToDropdown(
                                        widget.element.actionSupabaseFunctions,
                                      ),
                                      items:
                                          FActionElement.getSupabaseFunctions(
                                                  config)
                                              .toSet()
                                              .map(
                                                (e) => DropdownCustomMenuItem(
                                                  value: e,
                                                  child: TParagraph(e),
                                                ),
                                              )
                                              .toList(),
                                      onChange: (final newValue) {
                                        if (newValue != null) {
                                          final old = widget.element;
                                          widget.element
                                                  .actionSupabaseFunctions =
                                              FActionElement
                                                  .convertDropdownToValue(
                                            ActionSupabaseFunctions.values,
                                            newValue,
                                          ) as ActionSupabaseFunctions?;
                                          widget.callBack(widget.element, old);
                                        }
                                      },
                                    ),
                                    SupabaseInvokeControl(
                                      action: widget.element,
                                      callback: () {
                                        final old = widget.element;
                                        widget.callBack(widget.element, old);
                                      },
                                    ),
                                  ],
                                ),
                              if (widget.element.actionType ==
                                  ActionType.supabaseStorage)
                                Column(
                                  children: [
                                    CDropdownCustom<String>(
                                      expanded: true,
                                      value:
                                          FActionElement.convertValueToDropdown(
                                        widget.element.actionSupabaseStorage,
                                      ),
                                      items: FActionElement.getSupabaseStorage(
                                              config)
                                          .toSet()
                                          .map(
                                            (e) => DropdownCustomMenuItem(
                                              value: e,
                                              child: TParagraph(e),
                                            ),
                                          )
                                          .toList(),
                                      onChange: (final newValue) {
                                        if (newValue != null) {
                                          final old = widget.element;
                                          widget.element.actionSupabaseStorage =
                                              FActionElement
                                                  .convertDropdownToValue(
                                            ActionSupabaseStorage.values,
                                            newValue,
                                          ) as ActionSupabaseStorage?;
                                          widget.callBack(widget.element, old);
                                        }
                                      },
                                    ),
                                    if (widget.element.actionSupabaseStorage ==
                                        ActionSupabaseStorage.upload)
                                      SupabaseStorageUploadControl(
                                        action: widget.element,
                                        callback: () {
                                          final old = widget.element;
                                          widget.callBack(widget.element, old);
                                        },
                                      )
                                    else
                                      SupabaseStorageRemoveControl(
                                        action: widget.element,
                                        callback: () {
                                          final old = widget.element;
                                          widget.callBack(widget.element, old);
                                        },
                                      ),
                                  ],
                                ),
                              if (widget.element.actionType ==
                                  ActionType.mixpanel)
                                Column(
                                  children: [
                                    CDropdownCustom<String>(
                                      expanded: true,
                                      value:
                                          FActionElement.convertValueToDropdown(
                                        widget.element.actionMixpanel,
                                      ),
                                      items: FActionElement.getMixpanel(config)
                                          .toSet()
                                          .map(
                                            (e) => DropdownCustomMenuItem(
                                              value: e,
                                              child: TParagraph(e),
                                            ),
                                          )
                                          .toList(),
                                      onChange: (final newValue) {
                                        if (newValue != null) {
                                          final old = widget.element;
                                          widget.element.actionMixpanel =
                                              FActionElement
                                                  .convertDropdownToValue(
                                            ActionMixpanel.values,
                                            newValue,
                                          ) as ActionMixpanel?;
                                          widget.callBack(widget.element, old);
                                        }
                                      },
                                    ),
                                    if (widget.element.actionMixpanel ==
                                        ActionMixpanel.track)
                                      MixPanelTrack(
                                        action: widget.element,
                                        callback: () {
                                          final old = widget.element;
                                          widget.callBack(widget.element, old);
                                        },
                                      )
                                    else
                                      MixPanelSetUserId(
                                        action: widget.element,
                                        callback: () {
                                          final old = widget.element;
                                          widget.callBack(widget.element, old);
                                        },
                                      )
                                  ],
                                ),
                              if (widget.element.actionType ==
                                  ActionType.tetaDatabase)
                                CDropdownCustom<String>(
                                  expanded: true,
                                  value: FActionElement.convertValueToDropdown(
                                    widget.element.actionTetaDB,
                                  ),
                                  items: FActionElement.getTetaDB()
                                      .toSet()
                                      .map(
                                        (e) => DropdownCustomMenuItem(
                                          value: e,
                                          child: TParagraph(e),
                                        ),
                                      )
                                      .toList(),
                                  onChange: (final newValue) {
                                    if (newValue != null) {
                                      final old = widget.element;
                                      widget.element.actionTetaDB =
                                          FActionElement.convertDropdownToValue(
                                        ActionTetaCmsDB.values,
                                        newValue,
                                      ) as ActionTetaCmsDB?;
                                      widget.callBack(widget.element, old);
                                    }
                                  },
                                ),
                              if (widget.element.actionType ==
                                  ActionType.customHttpRequest)
                                CDropdownCustom<String>(
                                  expanded: true,
                                  value: FActionElement.convertValueToDropdown(
                                    widget.element.actionCustomHttpRequest,
                                  ),
                                  items: FActionElement.getCustomHttpRequest()
                                      .toSet()
                                      .map(
                                        (e) => DropdownCustomMenuItem(
                                          value: e,
                                          child: TParagraph(e),
                                        ),
                                      )
                                      .toList(),
                                  onChange: (final newValue) {
                                    if (newValue != null) {
                                      final old = widget.element;
                                      widget.element.actionCustomHttpRequest =
                                          FActionElement.convertDropdownToValue(
                                        ActionCustomHttpRequest.values,
                                        newValue,
                                      ) as ActionCustomHttpRequest?;
                                      widget.callBack(widget.element, old);
                                    }
                                  },
                                ),
                              BlocBuilder<FocusBloc, List<int>>(
                                builder: (final context, final state) {
                                  final nodeId = state.first;
                                  final node = (context.read<PageCubit>().state
                                          as PageLoaded)
                                      .page
                                      .flatList
                                      .firstWhere((final element) =>
                                          element.nid == nodeId);
                                  if ((widget.element.actionType ==
                                              ActionType.state &&
                                          widget.element.actionState ==
                                              ActionState.changeWith &&
                                          !node.intrinsicState.gestures
                                              .contains(
                                                  ActionGesture.onChange) &&
                                          (node.intrinsicState.type !=
                                                  NType.calendar &&
                                              node.intrinsicState.type !=
                                                  NType
                                                      .cupertinoSegmentedControl &&
                                              node.intrinsicState.type !=
                                                  NType.cupertinoSwitch)) ||
                                      (widget.element.actionType ==
                                              ActionType.navigation &&
                                          widget.element.actionNavigation ==
                                              ActionNavigation.launchURL) ||
                                      (widget.element.actionType ==
                                              ActionType.navigation &&
                                          widget.element.actionNavigation ==
                                              ActionNavigation.share) ||
                                      (widget.element.actionType ==
                                              ActionType.webview &&
                                          widget.element.actionWebView ==
                                              ActionWebView.navigateTo)) {
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 8),
                                      child: SizedBox(
                                        width: double.maxFinite,
                                        child: descriptionControlWidget(
                                          description: '''''',
                                          control: TextControl(
                                            valueType: VariableType.string,
                                            value: widget.element
                                                    .valueTextTypeInput ??
                                                FTextTypeInput(),
                                            title: 'Value',
                                            callBack: (final value, final old) {
                                              final old = widget.element;
                                              widget.element
                                                  .valueTextTypeInput = value;
                                              widget.callBack(
                                                  widget.element, old);
                                            },
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                  return const SizedBox();
                                },
                              ),

                              if ((widget.element.actionType ==
                                          ActionType.navigation &&
                                      (widget.element.actionNavigation ==
                                              ActionNavigation.openPage ||
                                          widget.element.actionNavigation ==
                                              ActionNavigation
                                                  .openBottomSheet ||
                                          widget.element.actionNavigation ==
                                              ActionNavigation.openSnackBar)) ||
                                  (widget.element.actionType ==
                                          ActionType.supabaseAuth ||
                                      widget.element.actionType ==
                                          ActionType.tetaAuth))
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8, bottom: 8),
                                      child: Row(
                                        children: [
                                          TParagraph(
                                            widget.element.actionNavigation ==
                                                        ActionNavigation
                                                            .openBottomSheet ||
                                                    widget.element
                                                            .actionNavigation ==
                                                        ActionNavigation
                                                            .openSnackBar
                                                ? 'Select component'
                                                : 'Which page?',
                                          ),
                                        ],
                                      ),
                                    ),
                                    BlocBuilder<PagesCubit, List<PageObject>>(
                                      builder: (final context, final state) {
                                        return CDropdownCustom<String>(
                                          expanded: true,
                                          value: state
                                                  .where((final element) {
                                                    if (widget.element
                                                                .actionNavigation ==
                                                            ActionNavigation
                                                                .openBottomSheet ||
                                                        widget.element
                                                                .actionNavigation ==
                                                            ActionNavigation
                                                                .openSnackBar) {
                                                      return !element.isPage;
                                                    } else {
                                                      return element.isPage;
                                                    }
                                                  })
                                                  .toList()
                                                  .contains(pageObject)
                                              ? dropdownLinkPage
                                              : null,
                                          items: state
                                              .where((final element) {
                                                if (widget.element
                                                            .actionNavigation ==
                                                        ActionNavigation
                                                            .openBottomSheet ||
                                                    widget.element
                                                            .actionNavigation ==
                                                        ActionNavigation
                                                            .openSnackBar) {
                                                  return !element.isPage;
                                                } else {
                                                  return element.isPage;
                                                }
                                              })
                                              .map((final e) => e.name)
                                              .toSet()
                                              .map(
                                                (e) => DropdownCustomMenuItem(
                                                  value: e,
                                                  child: TParagraph(e),
                                                ),
                                              )
                                              .toList(),
                                          onChange: (final newValue) {
                                            if (newValue != null) {
                                              final old = widget.element;
                                              pageObject = state.firstWhere(
                                                (final element) =>
                                                    element.name == newValue,
                                              );
                                              widget.element.nameOfPage =
                                                  newValue;
                                              if (mounted) {
                                                setState(() {
                                                  dropdownLinkPage = newValue;
                                                });
                                              }
                                              widget.callBack(
                                                  widget.element, old);
                                            }
                                          },
                                        );
                                      },
                                    ),
                                    if (pageObject != null &&
                                        pageObject?.defaultParams !=
                                            <VariableObject>[])
                                      pageObject?.defaultParams.isNotEmpty ??
                                              false
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 16),
                                              child: Stack(
                                                children: [
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            top: 8),
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 16,
                                                      right: 16,
                                                      top: 16,
                                                    ),
                                                    width: double.maxFinite,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color: const Color(
                                                            0xFFFFBF2F),
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: pageObject!
                                                          .defaultParams
                                                          .map(
                                                            (final e) =>
                                                                _Element(
                                                              pageState:
                                                                  pageState,
                                                              variable: e,
                                                              map: map,
                                                              element: widget
                                                                  .element,
                                                              callBack: widget
                                                                  .callBack,
                                                            ),
                                                          )
                                                          .toList(),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      right: 8,
                                                      bottom: 8,
                                                    ),
                                                    color:
                                                        const Color(0xFF222222),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: const [
                                                        Icon(
                                                          FeatherIcons.database,
                                                          size: 16,
                                                          color:
                                                              Color(0xFFFFBF2F),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 4),
                                                          child: TActionLabel(
                                                            'Send Params',
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )
                                          : Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 8),
                                              child: Row(
                                                children: [
                                                  TDetailLabel(
                                                    'This page has not params',
                                                    color: Colors.white
                                                        .withOpacity(0.8),
                                                  ),
                                                ],
                                              ),
                                            ),
                                    if (widget.element.actionType ==
                                            ActionType.supabaseAuth &&
                                        (widget.element.actionSupabaseAuth ==
                                                ActionSupabaseAuth.signUp ||
                                            widget.element.actionSupabaseAuth ==
                                                ActionSupabaseAuth
                                                    .signInWithCredential) &&
                                        (pageState.page.defaultStates
                                                    .indexWhere(
                                                  (final element) =>
                                                      element.name
                                                          .toLowerCase() ==
                                                      'email',
                                                ) ==
                                                -1 ||
                                            pageState.page.defaultStates
                                                    .indexWhere(
                                                  (final element) =>
                                                      element.name
                                                          .toLowerCase() ==
                                                      'password',
                                                ) ==
                                                -1 ||
                                            pageState.page.defaultStates
                                                    .indexWhere(
                                                  (final element) =>
                                                      element.name
                                                          .toLowerCase() ==
                                                      'status',
                                                ) ==
                                                -1 ||
                                            pageState.page.defaultStates
                                                    .indexWhere(
                                                  (final element) =>
                                                      element.name
                                                          .toLowerCase() ==
                                                      'status',
                                                ) ==
                                                -1))
                                      Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: const Color(0xFFFFBF2F)),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        clipBehavior: Clip.hardEdge,
                                        child: Wrap(
                                          children: [
                                            const Icon(
                                              Icons.warning,
                                              color: Color(0xFFFFBF2F),
                                              size: 24,
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.only(top: 12),
                                              child: TParagraph(
                                                "This action needs the following state variables: 'Email', 'Password', 'Status'",
                                              ),
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.only(
                                                  top: 8, bottom: 8),
                                              child: TParagraph(
                                                'The names of the variables are not case sensitive',
                                              ),
                                            ),
                                            if (kDebugMode)
                                              TextButton(
                                                onPressed: () {
                                                  var flag = false;
                                                  if (pageState
                                                          .page.defaultStates
                                                          .indexWhere(
                                                        (final element) =>
                                                            element.name
                                                                .toLowerCase() ==
                                                            'email',
                                                      ) ==
                                                      -1) {
                                                    pageState.page.defaultStates
                                                        .add(
                                                      VariableObject(
                                                        id: const Uuid().v1(),
                                                        type:
                                                            VariableType.string,
                                                        name: 'Email',
                                                        defaultValue: '0',
                                                      ),
                                                    );
                                                    flag = true;
                                                  }
                                                  if (pageState
                                                          .page.defaultStates
                                                          .indexWhere(
                                                        (final element) =>
                                                            element.name
                                                                .toLowerCase() ==
                                                            'password',
                                                      ) ==
                                                      -1) {
                                                    pageState.page.defaultStates
                                                        .add(
                                                      VariableObject(
                                                        id: const Uuid().v1(),
                                                        type:
                                                            VariableType.string,
                                                        name: 'Password',
                                                        defaultValue: '0',
                                                      ),
                                                    );
                                                    flag = true;
                                                  }
                                                  if (pageState
                                                          .page.defaultStates
                                                          .indexWhere(
                                                        (final element) =>
                                                            element.name
                                                                .toLowerCase() ==
                                                            'status',
                                                      ) ==
                                                      -1) {
                                                    pageState.page.defaultStates
                                                        .add(
                                                      VariableObject(
                                                        id: const Uuid().v1(),
                                                        type:
                                                            VariableType.string,
                                                        name: 'Status',
                                                        defaultValue: '0',
                                                      ),
                                                    );
                                                    flag = true;
                                                  }

                                                  if (flag) {
                                                    sl
                                                        .get<NodeRepository>()
                                                        .changeNode(
                                                          node: pageState
                                                                  .page.scaffold
                                                              as NDynamic,
                                                        );
                                                  }
                                                },
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white24,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  child: const Center(
                                                    child: TActionLabel(
                                                      'Generate',
                                                    ),
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                  ],
                                ),
                              if (widget.element.actionType ==
                                      ActionType.supabaseDatabase &&
                                  widget.element.actionSupabaseDB ==
                                      ActionSupabaseDB.insert)
                                SupabaseInsertControl(
                                  action: widget.element,
                                  callback: () {
                                    final old = widget.element;
                                    widget.callBack(widget.element, old);
                                  },
                                ),
                              if (widget.element.actionType ==
                                      ActionType.tetaDatabase &&
                                  widget.element.actionTetaDB ==
                                      ActionTetaCmsDB.insert)
                                TetaCmsInsertControl(
                                  action: widget.element,
                                  callback: () {
                                    final old = widget.element;
                                    widget.callBack(widget.element, old);
                                  },
                                ),
                              if (widget.element.actionType ==
                                      ActionType.airtable &&
                                  widget.element.actionAirtableDB ==
                                      ActionAirtableDB.insert)
                                AirtableInsertControl(
                                  action: widget.element,
                                  callback: () {
                                    final old = widget.element;
                                    widget.callBack(widget.element, old);
                                  },
                                ),
                              if (widget.element.actionType ==
                                      ActionType.airtable &&
                                  widget.element.actionAirtableDB ==
                                      ActionAirtableDB.delete)
                                AirtableDeleteControl(
                                  action: widget.element,
                                  callback: () {
                                    final old = widget.element;
                                    widget.callBack(widget.element, old);
                                  },
                                ),
                              if (widget.element.actionType ==
                                      ActionType.airtable &&
                                  widget.element.actionAirtableDB ==
                                      ActionAirtableDB.update)
                                AirtableUpdateControl(
                                  action: widget.element,
                                  callback: () {
                                    final old = widget.element;
                                    widget.callBack(widget.element, old);
                                  },
                                ),
                              if (widget.element.actionType ==
                                      ActionType.supabaseDatabase &&
                                  widget.element.actionSupabaseDB ==
                                      ActionSupabaseDB.update)
                                SupabaseUpdateControl(
                                  action: widget.element,
                                  callback: () {
                                    final old = widget.element;
                                    widget.callBack(widget.element, old);
                                  },
                                ),
                              if (widget.element.actionType ==
                                      ActionType.tetaDatabase &&
                                  widget.element.actionTetaDB ==
                                      ActionTetaCmsDB.update)
                                TetaCmsUpdateControl(
                                  action: widget.element,
                                  callback: () {
                                    final old = widget.element;
                                    widget.callBack(widget.element, old);
                                  },
                                ),
                              if (widget.element.actionType ==
                                      ActionType.supabaseDatabase &&
                                  widget.element.actionSupabaseDB ==
                                      ActionSupabaseDB.delete)
                                SupabaseDeleteControl(
                                  action: widget.element,
                                  callback: () {
                                    final old = widget.element;
                                    widget.callBack(widget.element, old);
                                  },
                                ),
                              if (widget.element.actionType ==
                                      ActionType.tetaDatabase &&
                                  widget.element.actionTetaDB ==
                                      ActionTetaCmsDB.delete)
                                TetaCmsDeleteControl(
                                  action: widget.element,
                                  callback: () {
                                    final old = widget.element;
                                    widget.callBack(widget.element, old);
                                  },
                                ),
                              if (widget.element.actionType ==
                                      ActionType.customHttpRequest &&
                                  widget.element.actionCustomHttpRequest ==
                                      ActionCustomHttpRequest.post)
                                CustomHttpRequestPostControl(
                                  action: widget.element,
                                  callback: () {
                                    final old = widget.element;
                                    widget.callBack(widget.element, old);
                                  },
                                ),
                              if (widget.element.actionType ==
                                      ActionType.customHttpRequest &&
                                  widget.element.actionCustomHttpRequest ==
                                      ActionCustomHttpRequest.update)
                                CustomHttpRequestUpdateControl(
                                  action: widget.element,
                                  callback: () {
                                    final old = widget.element;
                                    widget.callBack(widget.element, old);
                                  },
                                ),
                              if (widget.element.actionType ==
                                      ActionType.customHttpRequest &&
                                  widget.element.actionCustomHttpRequest ==
                                      ActionCustomHttpRequest.delete)
                                CustomHttpRequestDeleteControl(
                                  action: widget.element,
                                  callback: () {
                                    final old = widget.element;
                                    widget.callBack(widget.element, old);
                                  },
                                ),
                              if (widget.element.actionType ==
                                      ActionType.apiCalls &&
                                  widget.element.actionApiCalls ==
                                      ActionApiCalls.apiCalls)
                                ApiCallsControl(
                                  action: widget.element,
                                  callback: () {
                                    final old = widget.element;
                                    widget.callBack(widget.element, old);
                                  },
                                ),
                              if (widget.element.actionType ==
                                      ActionType.firebaseAnalytics &&
                                  widget.element.actionFirebaseAnalytics ==
                                      ActionFirebaseAnalytics.logLogin)
                                FirebaseAnalyticsLogLoginControl(
                                  action: widget.element,
                                  callback: () {
                                    final old = widget.element;
                                    widget.callBack(widget.element, old);
                                  },
                                ),
                              if (widget.element.actionType ==
                                      ActionType.firebaseAnalytics &&
                                  widget.element.actionFirebaseAnalytics ==
                                      ActionFirebaseAnalytics.logEvent)
                                FirebaseAnalyticsLogEventControl(
                                  action: widget.element,
                                  callback: () {
                                    final old = widget.element;
                                    widget.callBack(widget.element, old);
                                  },
                                ),

                              /////
                              ///
                              if (widget.element.actionType ==
                                      ActionType.firebaseAnalytics &&
                                  widget.element.actionFirebaseAnalytics ==
                                      ActionFirebaseAnalytics.logScreenView)
                                FirebaseAnalyticsLogScreenViewControl(
                                  action: widget.element,
                                  callback: () {
                                    final old = widget.element;
                                    widget.callBack(widget.element, old);
                                  },
                                ),
                              if (widget.element.actionType ==
                                      ActionType.firebaseAnalytics &&
                                  widget.element.actionFirebaseAnalytics ==
                                      ActionFirebaseAnalytics.logShare)
                                FirebaseAnalyticsLogShareControl(
                                  action: widget.element,
                                  callback: () {
                                    final old = widget.element;
                                    widget.callBack(widget.element, old);
                                  },
                                ),
                              if (widget.element.actionType ==
                                      ActionType.firebaseAnalytics &&
                                  widget.element.actionFirebaseAnalytics ==
                                      ActionFirebaseAnalytics.logJoinGroup)
                                FirebaseAnalyticsLogJoinGroupControl(
                                  action: widget.element,
                                  callback: () {
                                    final old = widget.element;
                                    widget.callBack(widget.element, old);
                                  },
                                ),
                              if (widget.element.actionType ==
                                      ActionType.firebaseAnalytics &&
                                  widget.element.actionFirebaseAnalytics ==
                                      ActionFirebaseAnalytics.logAppOpen)
                                FirebaseAnalyticsLogAppOpenControl(
                                  action: widget.element,
                                  callback: () {
                                    final old = widget.element;
                                    widget.callBack(widget.element, old);
                                  },
                                ),
                              if (widget.element.actionType ==
                                      ActionType.firebaseAnalytics &&
                                  widget.element.actionFirebaseAnalytics ==
                                      ActionFirebaseAnalytics
                                          .resetAnalyticsData)
                                FirebaseAnalyticsLogResetAnalyticsDataControl(
                                  action: widget.element,
                                  callback: () {
                                    final old = widget.element;
                                    widget.callBack(widget.element, old);
                                  },
                                ),
                              if (widget.element.actionType ==
                                      ActionType.firebaseAnalytics &&
                                  widget.element.actionFirebaseAnalytics ==
                                      ActionFirebaseAnalytics.setUserProperty)
                                FirebaseAnalyticsLogSetUserPropertyControl(
                                  action: widget.element,
                                  callback: () {
                                    final old = widget.element;
                                    widget.callBack(widget.element, old);
                                  },
                                ),
                              if (widget.element.actionType ==
                                      ActionType.firebaseAnalytics &&
                                  widget.element.actionFirebaseAnalytics ==
                                      ActionFirebaseAnalytics.setCurrentScreen)
                                FirebaseAnalyticsLogSetCurrentScreenControl(
                                  action: widget.element,
                                  callback: () {
                                    final old = widget.element;
                                    widget.callBack(widget.element, old);
                                  },
                                ),
                              if (widget.element.actionType ==
                                      ActionType.firebaseAnalytics &&
                                  widget.element.actionFirebaseAnalytics ==
                                      ActionFirebaseAnalytics.setUserId)
                                FirebaseAnalyticsLogSetUserIdControl(
                                  action: widget.element,
                                  callback: () {
                                    final old = widget.element;
                                    widget.callBack(widget.element, old);
                                  },
                                ),

                              ///Firebase Messages
                              if (widget.element.actionType ==
                                      ActionType.firebaseMessages &&
                                  widget.element.actionFirebaseMessages ==
                                      ActionFirebaseMessages.subscribeToTopic)
                                FirebaseMessagesSubscribeToTopicControl(
                                  action: widget.element,
                                  callback: () {
                                    final old = widget.element;
                                    widget.callBack(widget.element, old);
                                  },
                                ),
                              if (widget.element.actionType ==
                                      ActionType.firebaseMessages &&
                                  widget.element.actionFirebaseMessages ==
                                      ActionFirebaseMessages.unsubscribeToTopic)
                                FirebaseMessagesUnsubscribeFromTopicControl(
                                  action: widget.element,
                                  callback: () {
                                    final old = widget.element;
                                    widget.callBack(widget.element, old);
                                  },
                                ),
                              if (widget.element.actionType ==
                                      ActionType.alert &&
                                  widget.element.actionAlert ==
                                      ActionAlert.snackbar)
                                AlertSnackbarControl(
                                  action: widget.element,
                                  callback: () {
                                    final old = widget.element;
                                    widget.callBack(widget.element, old);
                                  },
                                ),
                              const Gap(Grid.extraLarge),
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}

class _Element extends StatefulWidget {
  const _Element({
    required this.variable,
    required this.pageState,
    required this.map,
    required this.element,
    required this.callBack,
    final Key? key,
  }) : super(key: key);

  final VariableObject variable;
  final PageLoaded pageState;
  final Map<String, dynamic> map;
  final FActionElement element;
  final Function(FActionElement, FActionElement) callBack;

  @override
  State<_Element> createState() => __ElementState();
}

class __ElementState extends State<_Element> {
  List<DatasetObject> listDataset = <DatasetObject>[];
  String? dropdownDataset;
  String? dropdown;
  List<Map<String, dynamic>> listSecondDropwdown = <Map<String, dynamic>>[];

  @override
  void initState() {
    super.initState();
    final params = Map<String, dynamic>.fromEntries(
      widget.pageState.page.defaultParams
          .where((final element) => widget.variable.type == element.type)
          .map((final e) => MapEntry<String, dynamic>(e.name, e.get)),
    );
    final states = Map<String, dynamic>.fromEntries(
      widget.pageState.page.defaultStates
          .where((final element) => widget.variable.type == element.type)
          .map((final e) => MapEntry<String, dynamic>(e.name, e.get)),
    );
    listDataset = <DatasetObject>[
      DatasetObject(
        name: 'Parameters',
        map: [
          params,
        ],
      ),
      DatasetObject(
        name: 'States',
        map: [
          states,
        ],
      ),
      if (widget.variable.type == VariableType.string)
        ...widget.pageState.datasets
    ];
    try {
      dropdown = widget.map[widget.variable.id]?['label'] as String;
    } catch (e) {
      debugPrint('$e');
    }
    try {
      dropdownDataset = widget.map[widget.variable.id]?['dataset'] as String;
    } catch (e) {
      debugPrint('$e');
    }
  }

  @override
  Widget build(final BuildContext context) {
    if (dropdownDataset != null) {
      try {
        listSecondDropwdown.addAll(
          listDataset
              .firstWhere((final element) => element.getName == dropdownDataset)
              .getMap,
        );
      } catch (e) {
        if (kDebugMode) {
          // ignore: avoid_print
          print(e);
        }
      }
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: TParagraph(
              widget.variable.name,
            ),
          ),
          if (listDataset
              .where((final element) => element.getMap.isNotEmpty)
              .isNotEmpty)
            CDropdown(
              value: listDataset
                      .where((final element) => element.getMap.isNotEmpty)
                      .map((final e) => e.getName)
                      .contains(dropdownDataset)
                  ? dropdownDataset
                  : null,
              items: listDataset
                  .where((final element) => element.getMap.isNotEmpty)
                  .map((final e) => e.getName)
                  .toSet()
                  .toList(),
              onChange: (final newValue) {
                if (mounted) {
                  setState(() {
                    dropdownDataset = newValue;
                    listSecondDropwdown = <Map<String, dynamic>>[];
                    listSecondDropwdown.addAll(
                      listDataset
                          .where(
                            (final element) =>
                                element.getName == dropdownDataset,
                          )
                          .map(
                            (final e) => e.getMap.first,
                          ),
                    );
                  });
                }
              },
            ),
          if (dropdownDataset != null && listSecondDropwdown.isNotEmpty)
            CDropdown(
              value: listSecondDropwdown.first.keys
                      .map((final key) => key)
                      .contains(dropdown)
                  ? dropdown
                  : null,
              items: listSecondDropwdown.first.keys.toList(),
              onChange: (final newValue) {
                if (newValue != null) {
                  if (mounted) {
                    setState(() {
                      dropdown = newValue;
                    });
                  }
                  if (widget.variable.id != null) {
                    widget.map[widget.variable.id!] = {
                      'dataset': dropdownDataset,
                      'label': newValue,
                    };
                  }
                  final old = widget.element;
                  widget.element.paramsToSend = widget.map;
                  widget.callBack(widget.element, old);
                }
              },
            ),
        ],
      ),
    );
  }
}
