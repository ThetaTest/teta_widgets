import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_front_end/src/design_system/textfield/minitextfield.dart';
import 'package:teta_front_end/teta_front_end.dart';
import 'package:teta_models/teta_models.dart';

import '../../../core/teta_action/action_types/groups.dart';
import '../../../core/teta_action/index.dart';
import '../../index.dart';
import 'airtable/airtable.dart';
import 'api_calls/apicalls.dart';
import 'custom_http_request/custom_http_request.dart';
import 'flag.dart';
import 'navigation/navigation.dart';
import 'qonversion/qonversion.dart';
import 'state/state.dart';
import 'supabase/supabase.dart';
import 'teta_cms_auth/teta_cms_auth.dart';
import 'teta_cms_database/teta_cms_database.dart';
import 'text.dart';
import 'translator/translator.dart';
import 'webview/webview.dart';

class ActionSettingsBottomSheet extends StatefulWidget {
  const ActionSettingsBottomSheet({
    super.key,
    required this.action,
    required this.onActionUpdated,
  });

  final TetaAction action;
  final Function(TetaAction newAction, TetaAction oldAction) onActionUpdated;

  @override
  State<ActionSettingsBottomSheet> createState() =>
      _ActionSettingsBottomSheetState();
}

class _ActionSettingsBottomSheetState extends State<ActionSettingsBottomSheet> {
  late List<TetaActionGroup> availableActionGroups;

  // Input controllers
  final loopInputController = TextEditingController();
  final delayInputController = TextEditingController();

  // New action configuration
  late TetaAction newAction;
  late TetaActionGroup currentActionGroup;
  late TetaActionType newActionType;
  late TetaActionParams? newActionParams;
  late int newActionDelay;
  late TetaActionLoop? newActionLoop;
  late TetaActionCondition? newActionCondition;

  @override
  void initState() {
    super.initState();
    // Initialize new action configuration
    newAction = widget.action;
    newActionType = widget.action.type;
    newActionParams = widget.action.params;
    newActionDelay = widget.action.delay;
    newActionLoop = widget.action.loop;
    newActionCondition = widget.action.condition;

    // Initialize action groups
    final pageLoaded = context.read<PageCubit>().state as PageLoaded;
    final configCubit = context.read<ConfigCubit>().state as ConfigStateLoaded;
    availableActionGroups = TetaActionGroups.getActionGroups(
      pageLoaded.page,
      configCubit.config,
    );
    currentActionGroup = availableActionGroups.firstWhere(
      (final group) => group.actions.contains(widget.action.type),
    );

    // Initialize input controllers
    delayInputController.text = newActionDelay.toString();
    loopInputController.text = newActionLoop?.interval.toString() ?? '0';
  }

  void initializeAndReturnNewAction() {
    final action = TetaActionFactory.create(
      type: newActionType,
      params: newActionParams,
      loop: newActionLoop,
      condition: newActionCondition,
      delay: newActionDelay,
    );

    if (action != null) {
      final oldAction = newAction;
      newAction = action;
      setState(() => widget.onActionUpdated.call(newAction, oldAction));
    }
  }

  @override
  void dispose() {
    loopInputController.dispose();
    delayInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
      child: ListView(
        padding: EI.mdH,
        children: [
          //Action Type Dropdown
          const Gap(Grid.medium),
          const THeadline1('Edit action'),
          const Gap(Grid.medium),
          const TParagraph('Action Group'),
          const SizedBox(height: 4),
          CDropdown(
            value: currentActionGroup.name,
            items: availableActionGroups.map((final e) => e.name).toList(),
            onChange: (newValue) {
              if (newValue == null) return;
              currentActionGroup = availableActionGroups
                  .firstWhere((group) => group.name == newValue);
              newActionType = currentActionGroup.actions.first;
              newActionParams = null;

              initializeAndReturnNewAction();
            },
          ),
          const SizedBox(height: 8),
          const TParagraph('Action Type'),
          const SizedBox(height: 4),
          CDropdown(
            value: newActionType.actionName,
            items: currentActionGroup.actions
                .map((final e) => e.actionName)
                .toList(),
            onChange: (final newValue) {
              if (newValue == null) return;
              newActionType = currentActionGroup.actions
                  .firstWhere((final e) => e.actionName == newValue);
              newActionParams = null;
              initializeAndReturnNewAction();
            },
          ),
          // Delay
          const Divider(color: Colors.white24),
          const SizedBox(height: 2),
          const TParagraph('Delay (ms)'),
          const SizedBox(height: 4),
          SizedBox(
            width: double.maxFinite,
            child: BlocListener<FocusBloc, List<int>>(
              listener: (final context, final state) {
                if (state.isNotEmpty) {
                  if (mounted) {
                    setState(() {
                      delayInputController.text = '$newActionDelay';
                    });
                  }
                }
              },
              child: CMiniTextField(
                controller: delayInputController,
                backgroundColor: Palette.bgGrey,
                callBack: (final text) {
                  final value = int.tryParse(text);
                  if (value == null) return;

                  newActionDelay = value;
                  initializeAndReturnNewAction();
                },
              ),
            ),
          ),
          const SizedBox(height: 8),
          // Loop
          const Divider(color: Colors.white24),
          FlagControl(
            title: 'Is loop',
            keyValue: null,
            value: newActionLoop != null,
            callBack: (final flag, final old) {
              if (flag) {
                newActionLoop = const TetaActionLoop(interval: 0);
              } else {
                newActionLoop = null;
              }

              initializeAndReturnNewAction();
            },
          ),
          if (newActionLoop != null)
            const Padding(
              padding: EdgeInsets.only(top: 2, bottom: 4),
              child: TParagraph('Every milliseconds'),
            ),
          if (newActionLoop != null)
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: descriptionControlWidget(
                description: 'Loop your action TOT milliseconds',
                control: Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: SizedBox(
                    width: double.maxFinite,
                    child: BlocListener<FocusBloc, List<int>>(
                      listener: (final context, final state) {
                        if (state.isNotEmpty) {
                          if (mounted) {
                            setState(() {
                              loopInputController.text =
                                  newActionLoop?.interval.toString() ?? '0';
                            });
                          }
                        }
                      },
                      child: CMiniTextField(
                        controller: loopInputController,
                        backgroundColor: Palette.bgGrey,
                        callBack: (final text) {
                          final value = int.tryParse(text);
                          if (value == null) return;

                          newActionLoop = newActionLoop!.copyWith(
                            interval: value,
                          );
                          initializeAndReturnNewAction();
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          // Condition
          const Divider(color: Colors.white24),
          FlagControl(
            title: 'By condition',
            keyValue: null,
            value: newActionCondition != null,
            callBack: (final flag, final old) {
              if (flag) {
                newActionCondition = TetaActionCondition(
                  condition: FTextTypeInput(),
                  valueOfCondition: FTextTypeInput(),
                );
              } else {
                newActionCondition = null;
              }

              initializeAndReturnNewAction();
            },
          ),
          if (newActionCondition != null)
            TextControl(
              valueType: VariableType.string,
              value: newActionCondition!.condition ?? FTextTypeInput(),
              title: 'Condition',
              callBack: (final value, final old) {
                newActionCondition = newActionCondition!.copyWith(
                  condition: value,
                );
                initializeAndReturnNewAction();
              },
            ),
          if (newActionCondition != null)
            descriptionControlWidget(
              description:
                  '''If "Condition" and "Value" have the same values, the condition is true. Else, it's false.''',
              control: TextControl(
                valueType: VariableType.string,
                value: newActionCondition!.valueOfCondition ?? FTextTypeInput(),
                title: 'Value',
                callBack: (final value, final old) {
                  newActionCondition = newActionCondition!.copyWith(
                    valueOfCondition: value,
                  );
                  initializeAndReturnNewAction();
                },
              ),
            ),
          const Divider(color: Colors.white24),
          const SizedBox(height: 8),
          if (currentActionGroup.name == 'State')
            TAStateControl(
              action: newAction,
              onParamsChanged: (params) {
                newActionParams = params;
                initializeAndReturnNewAction();
              },
            ),
          if (currentActionGroup.name == 'Teta Auth')
            TATetaCMSAuthControls(
              action: newAction,
              onParamsChanged: (params) {
                newActionParams = params;
                initializeAndReturnNewAction();
              },
            ),
          if (currentActionGroup.name == 'Supabase DB' ||
              currentActionGroup.name == 'Supabase Functions' ||
              currentActionGroup.name == 'Supabase Storage' ||
              currentActionGroup.name == 'Supabase Auth')
            TASupabaseControl(
              action: newAction,
              onParamsChanged: (params) {
                newActionParams = params;
                initializeAndReturnNewAction();
              },
            ),
          if (currentActionGroup.name == 'Teta CMS')
            TATetaCMSDatabaseControls(
              action: newAction,
              onParamsChanged: (params) {
                newActionParams = params;
                initializeAndReturnNewAction();
              },
            ),
          if (currentActionGroup.name == 'Navigation')
            TANavigationControl(
              action: newAction,
              onParamsChanged: (params) {
                newActionParams = params;
                initializeAndReturnNewAction();
              },
            ),
          if (currentActionGroup.name == 'Api Calls')
            TAApiCallsControl(
              action: newAction,
              onParamsChanged: (params) {
                newActionParams = params;
                initializeAndReturnNewAction();
              },
            ),
          if (currentActionGroup.name == 'Translator')
            TATranslatorControl(
              action: newAction,
              onParamsChanged: (params) {
                newActionParams = params;
                initializeAndReturnNewAction();
              },
            ),
          if (currentActionGroup.name == 'Inline HTTP Request')
            TACustomHttpRequestControl(
              action: newAction,
              onParamsChanged: (params) {
                newActionParams = params;
                initializeAndReturnNewAction();
              },
            ),
          if (currentActionGroup.name == 'Qonversion')
            TAQonversionControl(
              action: newAction,
              onParamsChanged: (params) {
                newActionParams = params;
                initializeAndReturnNewAction();
              },
            ),
          if (currentActionGroup.name == 'Airtable')
            TAAirtableControl(
              action: newAction,
              onParamsChanged: (params) {
                newActionParams = params;
                initializeAndReturnNewAction();
              },
            ),
          if (currentActionGroup.name == 'WebView')
            TAWebViewControl(
              action: newAction,
              onParamsChanged: (params) {
                newActionParams = params;
                initializeAndReturnNewAction();
              },
            ),
        ],
      ),
    );
  }
}
