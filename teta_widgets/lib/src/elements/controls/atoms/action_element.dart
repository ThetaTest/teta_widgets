// Flutter imports:
// Package imports:

// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars, avoid_dynamic_calls

// Package imports:
import 'package:collection/collection.dart';
import 'package:expandable/expandable.dart';
// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:gap/gap.dart';
import 'package:hovering/hovering.dart';
import 'package:teta_core/src/design_system/textfield/minitextfield.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_repositories/src/node_repository.dart';
import 'package:teta_widgets/src/elements/actions/teta_cms/database/fetch.dart';
import 'package:teta_widgets/src/elements/controls/atoms/actions/validator.dart';
// Project imports:
import 'package:teta_widgets/src/elements/controls/atoms/flag.dart';
import 'package:teta_widgets/src/elements/controls/atoms/qonversion/buy.dart';
import 'package:teta_widgets/src/elements/controls/atoms/revenuecat/buy.dart';
import 'package:teta_widgets/src/elements/controls/atoms/subapase/delete.dart';
import 'package:teta_widgets/src/elements/controls/atoms/subapase/insert.dart';
import 'package:teta_widgets/src/elements/controls/atoms/subapase/update.dart';
import 'package:teta_widgets/src/elements/controls/atoms/teta_cms/delete.dart';
import 'package:teta_widgets/src/elements/controls/atoms/teta_cms/fetch.dart';
import 'package:teta_widgets/src/elements/controls/atoms/teta_cms/insert.dart';
import 'package:teta_widgets/src/elements/controls/atoms/teta_cms/update.dart';
import 'package:teta_widgets/src/elements/controls/atoms/text.dart';
import 'package:teta_widgets/src/elements/controls/type.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/action_google_maps.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/audio_player_actions.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/braintree.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/camera.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/navigation.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/state.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/stripe.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/supabase.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/teta_cms.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/theme.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/translator.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/type.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/webview.dart';
import 'package:teta_widgets/src/elements/index.dart';
import 'package:teta_widgets/src/elements/nodes/dynamic.dart';
import 'package:uuid/uuid.dart';

/// Widget to control a single action
class ActionElementControl extends StatefulWidget {
  /// Returns a widget to control a single action
  const ActionElementControl({
    required this.name,
    required this.element,
    required this.prj,
    required this.page,
    required this.node,
    required this.callBack,
    required this.callBackToDelete,
    final Key? key,
  }) : super(key: key);

  /// Name of action
  final String name;

  /// Action itself
  final FActionElement element;

  /// Current project
  final ProjectObject prj;

  /// Current page
  final PageObject page;

  /// Current node
  final CNode node;

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
  int? nodeId;

  String? stateTest;
  bool isEmit = false;

  ///needs for custom function
  String? currentCustomFunctionValue;

  ///needs for openDatePicker
  String? currentStateNameValue;

  @override
  void initState() {
    try {
      pageObject = widget.prj.pages!.firstWhereOrNull(
        (final element) => element.name == widget.element.nameOfPage,
      );
      if (pageObject != null) {
        dropdownLinkPage = pageObject!.name;
        if (widget.element.paramsToSend != null) {
          map = widget.element.paramsToSend!;
        }
      }
    } catch (_) {}

    nodeId = widget.node.nid;
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
    try {
      final states = widget.page.states;
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
        color: const Color(0xFF222222),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ExpandablePanel(
        theme:
            const ExpandableThemeData(hasIcon: true, iconColor: Colors.white),
        header: Padding(
          padding: const EdgeInsets.only(top: 8, left: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              THeadline3(
                widget.name,
              ),
              GestureDetector(
                onTap: widget.callBackToDelete,
                child: HoverWidget(
                  hoverChild: const Icon(
                    FeatherIcons.trash,
                    size: 24,
                    color: Colors.white,
                  ),
                  onHover: (final e) {},
                  child: const Icon(
                    FeatherIcons.trash,
                    size: 24,
                    color: Colors.white24,
                  ),
                ),
              ),
            ],
          ),
        ),
        collapsed: const SizedBox(),
        expanded: Container(
          padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Action Type Dropdown
              const Padding(
                padding: EdgeInsets.only(top: 2, bottom: 4),
                child: THeadline3(
                  'Action Type',
                ),
              ),
              CDropdown(
                value: FActionElement()
                        .getTypes(widget.prj.config, widget.page)
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
                    .getTypes(widget.prj.config, widget.page)
                    .toSet()
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
              // Gesture Dropdown
              /*const Padding(
                padding: EdgeInsets.only(top: 2, bottom: 4),
                child: THeadline3(
                  'Gesture',
                ),
              ),
              CDropdown(
                value: FActionElement.convertValueToDropdown(
                  widget.element.actionGesture,
                ),
                items: FActionElement.getGestures(widget.node as NDynamic),
                onChange: (final newValue) {
                  if (newValue != null) {
                    final old = widget.element;
                    widget.element.actionGesture =
                        FActionElement.convertDropdownToValue(
                      widget.node.intrinsicState.gestures,
                      newValue,
                    ) as ActionGesture?;
                    widget.callBack(widget.element, old);
                  }
                },
              ),*/
              // Delay
              const Divider(
                color: Colors.white24,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 2, bottom: 4),
                child: THeadline3(
                  'Delay (ms)',
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: SizedBox(
                  width: double.maxFinite,
                  child: BlocListener<FocusBloc, List<CNode>>(
                    listener: (final context, final state) {
                      if (state.isNotEmpty) {
                        if (state.first.nid != nodeId) {
                          if (mounted) {
                            setState(() {
                              delayController.text =
                                  widget.element.delay?.value ?? '0';
                            });
                          }
                          nodeId = state.first.nid;
                        }
                      }
                    },
                    child: CMiniTextField(
                      controller: delayController,
                      backgroundColor: Palette.bgGrey,
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
              FlagControl(
                title: 'Is loop',
                node: widget.node as NDynamic,
                keyValue: null,
                value: widget.element.withLoop ?? false,
                callBack: (final flag, final old) {
                  final old = widget.element;
                  widget.element.withLoop = flag;
                  widget.callBack(widget.element, old);
                },
              ),
              if (widget.element.withLoop == true)
                const Padding(
                  padding: EdgeInsets.only(top: 2, bottom: 4),
                  child: THeadline3(
                    'Every milliseconds',
                  ),
                ),
              if (widget.element.withLoop == true)
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  child: descriptionControlWidget(
                    description: 'Loop your action TOT milliseconds',
                    control: Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: SizedBox(
                        width: double.maxFinite,
                        child: BlocListener<FocusBloc, List<CNode>>(
                          listener: (final context, final state) {
                            if (state.isNotEmpty) {
                              if (state.first.nid != nodeId) {
                                if (mounted) {
                                  setState(() {
                                    loopController.text = widget
                                            .element.everyMilliseconds?.value ??
                                        '0';
                                  });
                                }
                                nodeId = state.first.nid;
                              }
                            }
                          },
                          child: CMiniTextField(
                            controller: loopController,
                            backgroundColor: Palette.bgGrey,
                            callBack: (final text) {
                              if (int.tryParse(text) != null) {
                                final old = widget.element;
                                widget.element.everyMilliseconds!.value = text;
                                widget.callBack(widget.element, old);
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
              FlagControl(
                title: 'By condition',
                node: widget.node as NDynamic,
                keyValue: null,
                value: widget.element.withCondition ?? false,
                callBack: (final flag, final old) {
                  final old = widget.element;
                  widget.element.withCondition = flag;
                  widget.callBack(widget.element, old);
                },
              ),
              if (widget.element.withCondition == true)
                TextControl(
                  valueType: VariableType.string,
                  node: widget.node,
                  value: widget.element.condition ?? FTextTypeInput(),
                  page: widget.page,
                  title: 'Condition',
                  callBack: (final value, final old) {
                    final old = widget.element;
                    widget.element.condition = value;
                    widget.callBack(widget.element, old);
                  },
                ),
              if (widget.element.withCondition == true)
                descriptionControlWidget(
                  description:
                      '''If "Condition" and "Value" have the same values, the condition is true. Else, it's false.''',
                  control: TextControl(
                    valueType: VariableType.string,
                    node: widget.node,
                    value: widget.element.valueOfCondition ?? FTextTypeInput(),
                    page: widget.page,
                    title: 'Value',
                    callBack: (final value, final old) {
                      final old = widget.element;
                      widget.element.valueOfCondition = value;
                      widget.callBack(widget.element, old);
                    },
                  ),
                ),
              const Divider(
                color: Colors.white24,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 8),
              ),
              if (widget.element.actionType == ActionType.camera)
                Column(
                  children: [
                    CDropdown(
                      value: FActionElement.convertValueToDropdown(
                        widget.element.actionCamera,
                      ),
                      items: FActionElement.getCamera(),
                      onChange: (final newValue) {
                        if (newValue != null) {
                          final old = widget.element;
                          widget.element.actionCamera =
                              FActionElement.convertDropdownToValue(
                            ActionCamera.values,
                            newValue,
                          ) as ActionCamera?;
                          widget.callBack(widget.element, old);
                        }
                      },
                    ),
                    CDropdown(
                      value: widget.page.states
                                  .map((final e) => e.name)
                                  .where((final element) => element != 'null')
                                  .toList()
                                  .indexWhere(
                                    (final e) => e == widget.element.stateName,
                                  ) !=
                              -1
                          ? widget.element.stateName
                          : null,
                      items: widget.page.states
                          .where(
                            (final element) =>
                                element.type == VariableType.cameraController,
                          )
                          .map((final e) => e.name)
                          .where((final element) => element != 'null')
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
                CDropdown(
                  value: FActionElement.convertValueToDropdown(
                    widget.element.actionTheme,
                  ),
                  items: FActionElement.getTheme(),
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
              if (widget.element.actionType == ActionType.audioPlayer)
                Column(
                  children: [
                    CDropdown(
                      value: FActionElement.convertValueToDropdown(
                        widget.element.actionAudioPlayer,
                      ),
                      items: FActionElement.getAudioPlayer(),
                      onChange: (final newValue) {
                        if (newValue != null) {
                          final old = widget.element;
                          widget.element.actionAudioPlayer =
                              FActionElement.convertDropdownToValue(
                            ActionAudioPlayerActions.values,
                            newValue,
                          ) as ActionAudioPlayerActions?;
                          widget.callBack(widget.element, old);
                        }
                      },
                    ),
                    CDropdown(
                      value: widget.page.states
                                  .where(
                                    (final element) =>
                                        element.type ==
                                        VariableType.audioController,
                                  )
                                  .map((final e) => e.name)
                                  .where((final element) => element != 'null')
                                  .toList()
                                  .indexWhere(
                                    (final e) => e == widget.element.stateName,
                                  ) !=
                              -1
                          ? widget.element.stateName
                          : null,
                      items: widget.page.states
                          .where(
                            (final element) =>
                                element.type == VariableType.audioController,
                          )
                          .map((final e) => e.name)
                          .where((final element) => element != 'null')
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
              if (widget.element.actionType == ActionType.webview)
                Column(
                  children: [
                    CDropdown(
                      value: FActionElement.convertValueToDropdown(
                        widget.element.actionWebView,
                      ),
                      items: FActionElement.getWebView(),
                      onChange: (final newValue) {
                        if (newValue != null) {
                          final old = widget.element;
                          widget.element.actionWebView =
                              FActionElement.convertDropdownToValue(
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
                    CDropdown(
                      value: widget.page.states
                                  .where(
                                    (final element) =>
                                        element.type ==
                                        VariableType.webViewController,
                                  )
                                  .map((final e) => e.name)
                                  .where((final element) => element != 'null')
                                  .toList()
                                  .indexWhere(
                                    (final e) => e == widget.element.stateName,
                                  ) !=
                              -1
                          ? widget.element.stateName
                          : null,
                      items: widget.page.states
                          .where(
                            (final element) =>
                                element.type == VariableType.webViewController,
                          )
                          .map((final e) => e.name)
                          .where((final element) => element != 'null')
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
                CDropdown(
                  value: FActionElement.convertValueToDropdown(
                    widget.element.actionState,
                  ),
                  items: FActionElement.getState(),
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
              if (widget.element.actionType == ActionType.translator)
                CDropdown(
                  value: FActionElement.getTranslator().contains(
                    FActionElement.convertValueToDropdown(
                      widget.element.actionTranslator,
                    ),
                  )
                      ? FActionElement.convertValueToDropdown(
                          widget.element.actionTranslator,
                        )
                      : null,
                  items: FActionElement.getTranslator(),
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
              if (widget.element.actionType == ActionType.navigation)
                CDropdown(
                  value: FActionElement.convertValueToDropdown(
                    widget.element.actionNavigation,
                  ),
                  items: FActionElement.getNavigation().toSet().toList(),
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
              if (widget.element.actionType == ActionType.state &&
                  (widget.element.actionState == ActionState.emailValidator ||
                      widget.element.actionState ==
                          ActionState.passwordValidator ||
                      widget.element.actionState ==
                          ActionState.websiteValidator ||
                      widget.element.actionState == ActionState.phoneValidator))
                AValidatorControl(
                  page: widget.page,
                  action: widget.element,
                  callback: (final value, final old) {
                    widget.callBack(value, old);
                  },
                ),
              if ((widget.element.actionType == ActionType.state &&
                      widget.element.actionState == ActionState.changeWith) ||
                  (widget.element.actionType == ActionType.translator &&
                      widget.element.actionTranslator ==
                          ActionTranslator.translate))
                CDropdown(
                  value: widget.page.states
                              .map((final e) => e.name)
                              .where((final element) => element != 'null')
                              .toList()
                              .indexWhere(
                                (final e) => e == widget.element.stateName,
                              ) !=
                          -1
                      ? widget.element.stateName
                      : null,
                  items: widget.page.states
                      .map((final e) => e.name)
                      .where((final element) => element != 'null')
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
              if (widget.element.actionType == ActionType.state &&
                  (widget.element.actionState == ActionState.increment ||
                      widget.element.actionState == ActionState.decrement))
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CDropdown(
                      value: widget.page.states
                                  .map((final e) => e.name)
                                  .where((final element) => element != 'null')
                                  .toList()
                                  .indexWhere(
                                    (final e) => e == widget.element.stateName,
                                  ) !=
                              -1
                          ? widget.element.stateName
                          : null,
                      items: widget.page.states
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
              if (widget.element.actionType == ActionType.state &&
                  widget.element.actionState == ActionState.changeWithParams)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 2, bottom: 4),
                      child: THeadline3(
                        'Parameter',
                      ),
                    ),
                    CDropdown(
                      value: widget.page.params
                                  .map((final e) => e.name)
                                  .where((final element) => element != 'null')
                                  .toList()
                                  .indexWhere(
                                    (final e) => e == widget.element.value,
                                  ) !=
                              -1
                          ? widget.element.value
                          : null,
                      items: widget.page.params
                          .map((final e) => e.name)
                          .where((final element) => element != 'null')
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
              if (widget.element.actionType == ActionType.customFunctions)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 8, bottom: 8),
                      child: THeadline3('Which Function?'),
                    ),
                    Builder(
                      builder: (final _) {
                        final functions =
                            BlocProvider.of<CustomFunctionsCubit>(context)
                                .state;
                        final tempList = <String>[];
                        for (final item in functions) {
                          tempList.add(item.name);
                        }
                        if (functions.isNotEmpty) {
                          return SizedBox(
                            height: 50,
                            child: CDropdown(
                              value: currentCustomFunctionValue,
                              items: tempList,
                              onChange: (final newValue) {
                                if (newValue != null) {
                                  currentCustomFunctionValue = newValue;
                                  final old = widget.element;
                                  widget.element.customFunctionId = functions
                                      .firstWhere(
                                        (final element) =>
                                            element.name == newValue,
                                      )
                                      .id;
                                  widget.callBack(widget.element, old);
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
              if (widget.element.actionType == ActionType.navigation &&
                  widget.element.actionNavigation ==
                      ActionNavigation.openDatePicker)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 8, bottom: 8),
                      child: THeadline3('Which State needs to change?'),
                    ),
                    Builder(
                      builder: (final context) {
                        final states = widget.page.states;
                        final statesNameList = <String>[];
                        for (final item in states) {
                          statesNameList.add(item.name);
                        }
                        return CDropdown(
                          value: currentStateNameValue,
                          items: statesNameList,
                          onChange: (final newValue) {
                            if (newValue != null) {
                              currentStateNameValue = newValue;
                              final old = widget.element;
                              widget.element.stateName = states
                                  .firstWhere(
                                    (final element) => element.name == newValue,
                                  )
                                  .name;
                              widget.callBack(widget.element, old);
                            }
                          },
                        );
                      },
                    ),
                  ],
                ),

              if (widget.element.actionType == ActionType.braintree)
                Column(
                  children: [
                    CDropdown(
                      value: FActionElement.convertValueToDropdown(
                        widget.element.actionBraintree,
                      ),
                      items: FActionElement.getBraintree(widget.prj.config)
                          .toSet()
                          .toList(),
                      onChange: (final newValue) {
                        if (newValue != null) {
                          final old = widget.element;
                          widget.element.actionBraintree =
                              FActionElement.convertDropdownToValue(
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
                          node: widget.node,
                          value: widget.element.valueTextTypeInput ??
                              FTextTypeInput(),
                          page: widget.page,
                          title: 'Amount',
                          callBack: (final value, final old) {
                            final old = widget.element;
                            widget.element.valueTextTypeInput = value;
                            widget.element.valueOfCondition = value;
                            widget.callBack(widget.element, old);
                          },
                        ),
                      ),
                    ),
                    const Gap(Grid.medium),
                    const THeadline3(
                      'Choose a variable to save the status of the operation',
                    ),
                    TDetailLabel(
                      "The selected variable is set to 'Loading' during the operation, to 'Successful' if the payment is successful and to 'Failed' if it is not successful. The variable must be of String type.",
                      color: Palette.txtPrimary.withOpacity(0.6),
                    ),
                    const Gap(Grid.small),
                    CDropdown(
                      value: widget.page.states
                                  .map((final e) => e.name)
                                  .where((final element) => element != 'null')
                                  .toList()
                                  .indexWhere(
                                    (final e) => e == widget.element.stateName,
                                  ) !=
                              -1
                          ? widget.element.stateName
                          : null,
                      items: widget.page.states
                          .map((final e) => e.name)
                          .where((final element) => element != 'null')
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
                  ],
                ),
              if (widget.element.actionType == ActionType.revenueCat)
                RevenueCatBuyActionWidget(
                  prj: widget.prj,
                  page: widget.page,
                  node: widget.node as NDynamic,
                  element: widget.element,
                  callback: widget.callBack,
                ),
              if (widget.element.actionType == ActionType.qonversion)
                QonversionActionWidget(
                  prj: widget.prj,
                  page: widget.page,
                  node: widget.node as NDynamic,
                  element: widget.element,
                  callback: widget.callBack,
                ),
              if (ActionType.googleMaps == widget.element.actionType)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(Grid.medium),
                    const THeadline3(
                      'Action type',
                      isCentered: false,
                    ),
                    CDropdown(
                      value: FActionElement.convertValueToDropdown(
                        widget.element.actionGoogleMaps,
                      ),
                      items: FActionElement.getGoogleMaps(widget.prj.config)
                          .toSet()
                          .toList(),
                      onChange: (final newValue) {
                        if (newValue != null) {
                          final old = widget.element;
                          widget.element.actionGoogleMaps =
                              FActionElement.convertDropdownToValue(
                            ActionGoogleMaps.values,
                            newValue,
                          ) as ActionGoogleMaps?;
                          widget.callBack(widget.element, old);
                        }
                      },
                    ),
                    const Gap(Grid.medium),
                    const THeadline3(
                      'Google Maps Cubit',
                      isCentered: false,
                    ),
                    descriptionControlWidget(
                      description: 'Google Maps Cubit',
                      control: CDropdown(
                        value: widget.page.states
                                    .where(
                                      (final element) =>
                                          element.type ==
                                          VariableType.googleMapsCubit,
                                    )
                                    .map((final e) => e.name)
                                    .where((final element) => element != 'null')
                                    .toList()
                                    .indexWhere(
                                      (final e) =>
                                          e == widget.element.stateName,
                                    ) !=
                                -1
                            ? widget.element.stateName
                            : null,
                        items: widget.page.states
                            .where(
                              (final element) =>
                                  element.type == VariableType.googleMapsCubit,
                            )
                            .map((final e) => e.name)
                            .where((final element) => element != 'null')
                            .toList(),
                        onChange: (final newValue) {
                          if (newValue != null) {
                            final old = widget.element;
                            widget.element.stateName = newValue;
                            widget.callBack(widget.element, old);
                          }
                        },
                      ),
                    ),
                    const Gap(Grid.medium),
                    const THeadline3(
                      'Google Maps Controller',
                      isCentered: false,
                    ),
                    descriptionControlWidget(
                      description: 'Google Maps Controller',
                      control: CDropdown(
                        value: widget.page.states
                                    .where(
                                      (final element) =>
                                          element.type ==
                                          VariableType.googleMapsController,
                                    )
                                    .map((final e) => e.name)
                                    .where((final element) => element != 'null')
                                    .toList()
                                    .indexWhere(
                                      (final e) =>
                                          e == widget.element.stateName2,
                                    ) !=
                                -1
                            ? widget.element.stateName2
                            : null,
                        items: widget.page.states
                            .where(
                              (final element) =>
                                  element.type ==
                                  VariableType.googleMapsController,
                            )
                            .map((final e) => e.name)
                            .where((final element) => element != 'null')
                            .toList(),
                        onChange: (final newValue) {
                          if (newValue != null) {
                            final old = widget.element;
                            widget.element.stateName2 = newValue;
                            widget.callBack(widget.element, old);
                          }
                        },
                      ),
                    ),
                    if (ActionGoogleMaps.updateLiveLocation ==
                        widget.element.actionGoogleMaps) ...[
                      const Gap(Grid.medium),
                      const THeadline3(
                        'Latitude variable',
                        isCentered: false,
                      ),
                      descriptionControlWidget(
                        description:
                            'Each time a new location is streamed it will be stored here.',
                        control: CDropdown(
                          value: widget.page.states
                                      .where(
                                        (final element) =>
                                            element.type == VariableType.double,
                                      )
                                      .map((final e) => e.name)
                                      .where(
                                        (final element) => element != 'null',
                                      )
                                      .toList()
                                      .indexWhere(
                                        (final e) =>
                                            e == widget.element.stateName3,
                                      ) !=
                                  -1
                              ? widget.element.stateName3
                              : null,
                          items: widget.page.states
                              .where(
                                (final element) =>
                                    element.type == VariableType.double,
                              )
                              .map((final e) => e.name)
                              .where((final element) => element != 'null')
                              .toList(),
                          onChange: (final newValue) {
                            if (newValue != null) {
                              final old = widget.element;
                              widget.element.stateName3 = newValue;
                              widget.callBack(widget.element, old);
                            }
                          },
                        ),
                      ),
                      const Gap(Grid.medium),
                      const THeadline3(
                        'Longitude Variable',
                        isCentered: false,
                      ),
                      descriptionControlWidget(
                        description:
                            'Each time a new location is streamed it will be stored here.',
                        control: CDropdown(
                          value: widget.page.states
                                      .where(
                                        (final element) =>
                                            element.type == VariableType.double,
                                      )
                                      .map((final e) => e.name)
                                      .where(
                                        (final element) => element != 'null',
                                      )
                                      .toList()
                                      .indexWhere(
                                        (final e) =>
                                            e == widget.element.stateName4,
                                      ) !=
                                  -1
                              ? widget.element.stateName4
                              : null,
                          items: widget.page.states
                              .where(
                                (final element) =>
                                    element.type == VariableType.double,
                              )
                              .map((final e) => e.name)
                              .where((final element) => element != 'null')
                              .toList(),
                          onChange: (final newValue) {
                            if (newValue != null) {
                              final old = widget.element;
                              widget.element.stateName4 = newValue;
                              widget.callBack(widget.element, old);
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
                              node: widget.node,
                              value: widget.element.googleMapsLat ??
                                  FTextTypeInput(),
                              page: widget.page,
                              title: 'Camera Latitude',
                              callBack: (final value, final old) {
                                final old = widget.element;
                                widget.element.googleMapsLat = value;
                                widget.element.valueOfCondition = value;
                                widget.callBack(widget.element, old);
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
                              node: widget.node,
                              value: widget.element.googleMapsLng ??
                                  FTextTypeInput(),
                              page: widget.page,
                              title: 'Camera Longitude',
                              callBack: (final value, final old) {
                                final old = widget.element;
                                widget.element.googleMapsLng = value;
                                widget.element.valueOfCondition = value;
                                widget.callBack(widget.element, old);
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
                              node: widget.node,
                              value: widget.element.googleMapsZoom ??
                                  FTextTypeInput(),
                              page: widget.page,
                              title: 'Camera Zoom',
                              callBack: (final value, final old) {
                                final old = widget.element;
                                widget.element.googleMapsZoom = value;
                                widget.element.valueOfCondition = value;
                                widget.callBack(widget.element, old);
                              },
                            ),
                          ),
                        ),
                      ),
                    ]
                  ],
                ),
              if (widget.element.actionType == ActionType.stripe)
                Column(
                  children: [
                    CDropdown(
                      value: FActionElement.convertValueToDropdown(
                        widget.element.actionStripe,
                      ),
                      items: FActionElement.getStripe(widget.prj.config)
                          .toSet()
                          .toList(),
                      onChange: (final newValue) {
                        if (newValue != null) {
                          final old = widget.element;
                          widget.element.actionStripe =
                              FActionElement.convertDropdownToValue(
                            ActionStripe.values,
                            newValue,
                          ) as ActionStripe?;
                          widget.callBack(widget.element, old);
                        }
                      },
                    ),
                    if (ActionStripe.buyCartItems ==
                        widget.element.actionStripe) ...[
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: SizedBox(
                          width: double.maxFinite,
                          child: descriptionControlWidget(
                            description: 'Billing email',
                            control: TextControl(
                              valueType: VariableType.string,
                              node: widget.node,
                              value: widget.element.stripeBillingInfoEmail ??
                                  FTextTypeInput(),
                              page: widget.page,
                              title: 'Billing email',
                              callBack: (final value, final old) {
                                final old = widget.element;
                                widget.element.stripeBillingInfoEmail = value;
                                widget.element.valueOfCondition = value;
                                widget.callBack(widget.element, old);
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
                              node: widget.node,
                              value: widget.element.stripeBillingInfoPhone ??
                                  FTextTypeInput(),
                              page: widget.page,
                              title: 'Billing phone',
                              callBack: (final value, final old) {
                                final old = widget.element;
                                widget.element.stripeBillingInfoPhone = value;
                                widget.element.valueOfCondition = value;
                                widget.callBack(widget.element, old);
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
                              node: widget.node,
                              value: widget.element.stripeBillingInfoCity ??
                                  FTextTypeInput(),
                              page: widget.page,
                              title: 'Billing city',
                              callBack: (final value, final old) {
                                final old = widget.element;
                                widget.element.stripeBillingInfoCity = value;
                                widget.element.valueOfCondition = value;
                                widget.callBack(widget.element, old);
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
                              node: widget.node,
                              value: widget.element.stripeBillingInfoState ??
                                  FTextTypeInput(),
                              page: widget.page,
                              title: 'Billing state',
                              callBack: (final value, final old) {
                                final old = widget.element;
                                widget.element.stripeBillingInfoState = value;
                                widget.element.valueOfCondition = value;
                                widget.callBack(widget.element, old);
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
                              node: widget.node,
                              value: widget.element.stripeBillingInfoLine ??
                                  FTextTypeInput(),
                              page: widget.page,
                              title: 'Billing line',
                              callBack: (final value, final old) {
                                final old = widget.element;
                                widget.element.stripeBillingInfoLine = value;
                                widget.element.valueOfCondition = value;
                                widget.callBack(widget.element, old);
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
                              node: widget.node,
                              value:
                                  widget.element.stripeBillingInfoPostalCode ??
                                      FTextTypeInput(),
                              page: widget.page,
                              title: 'Billing postal code',
                              callBack: (final value, final old) {
                                final old = widget.element;
                                widget.element.stripeBillingInfoPostalCode =
                                    value;
                                widget.element.valueOfCondition = value;
                                widget.callBack(widget.element, old);
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
                              node: widget.node,
                              value: widget.element.stripeBillingInfoCountry ??
                                  FTextTypeInput(),
                              page: widget.page,
                              title: 'Billing country',
                              callBack: (final value, final old) {
                                final old = widget.element;
                                widget.element.stripeBillingInfoCountry = value;
                                widget.element.valueOfCondition = value;
                                widget.callBack(widget.element, old);
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
                              node: widget.node,
                              value: widget.element.stripeShippingId ??
                                  FTextTypeInput(),
                              page: widget.page,
                              title: 'Shipping id',
                              callBack: (final value, final old) {
                                final old = widget.element;
                                widget.element.stripeShippingId = value;
                                widget.element.valueOfCondition = value;
                                widget.callBack(widget.element, old);
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                    if (ActionStripe.showReceipt ==
                        widget.element.actionStripe) ...[
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: SizedBox(
                          width: double.maxFinite,
                          child: descriptionControlWidget(
                            description: 'Payment Intent Id',
                            control: TextControl(
                              valueType: VariableType.string,
                              node: widget.node,
                              value: widget.element.stripePaymentIntentId ??
                                  FTextTypeInput(),
                              page: widget.page,
                              title: 'Payment Intent Id',
                              callBack: (final value, final old) {
                                final old = widget.element;
                                widget.element.stripePaymentIntentId = value;
                                widget.element.valueOfCondition = value;
                                widget.callBack(widget.element, old);
                              },
                            ),
                          ),
                        ),
                      ),
                    ]
                  ],
                ),
              if (widget.element.actionType == ActionType.tetaAuth)
                CDropdown(
                  value: FActionElement.convertValueToDropdown(
                    widget.element.actionTetaAuth,
                  ),
                  items: FActionElement.getTetaAuth(),
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
              if (widget.element.actionType == ActionType.supabaseAuth)
                CDropdown(
                  value: FActionElement.convertValueToDropdown(
                    widget.element.actionSupabaseAuth,
                  ),
                  items: FActionElement.getSupabaseAuth(widget.prj.config),
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
              if (widget.element.actionType == ActionType.supabaseDatabase)
                CDropdown(
                  value: FActionElement.convertValueToDropdown(
                    widget.element.actionSupabaseDB,
                  ),
                  items: FActionElement.getSupabaseDB(widget.prj.config)
                      .toSet()
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
              if (widget.element.actionType == ActionType.tetaDatabase)
                CDropdown(
                  value: FActionElement.convertValueToDropdown(
                    widget.element.actionTetaDB,
                  ),
                  items: FActionElement.getTetaDB().toSet().toList(),
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
              if ((widget.element.actionType == ActionType.state &&
                      widget.element.actionState == ActionState.changeWith &&
                      !widget.node.intrinsicState.gestures
                          .contains(ActionGesture.onChange) &&
                      (widget.node.intrinsicState.type != NType.calendar &&
                          widget.node.intrinsicState.type !=
                              NType.cupertinoSegmentedControl &&
                          widget.node.intrinsicState.type !=
                              NType.cupertinoSwitch)) ||
                  (widget.element.actionType == ActionType.navigation &&
                      widget.element.actionNavigation ==
                          ActionNavigation.launchURL) ||
                  (widget.element.actionType == ActionType.navigation &&
                      widget.element.actionNavigation ==
                          ActionNavigation.share) ||
                  (widget.element.actionType == ActionType.webview &&
                      widget.element.actionWebView == ActionWebView.navigateTo))
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: SizedBox(
                    width: double.maxFinite,
                    child: descriptionControlWidget(
                      description: '''''',
                      control: TextControl(
                        valueType: VariableType.string,
                        node: widget.node,
                        value: widget.element.valueTextTypeInput ??
                            FTextTypeInput(),
                        page: widget.page,
                        title: 'Value',
                        callBack: (final value, final old) {
                          final old = widget.element;
                          widget.element.valueTextTypeInput = value;
                          widget.element.valueOfCondition = value;
                          widget.callBack(widget.element, old);
                        },
                      ),
                    ),
                  ),
                ),

              if ((widget.element.actionType == ActionType.navigation &&
                      (widget.element.actionNavigation ==
                              ActionNavigation.openPage ||
                          widget.element.actionNavigation ==
                              ActionNavigation.openBottomSheet ||
                          widget.element.actionNavigation ==
                              ActionNavigation.openSnackBar)) ||
                  (widget.element.actionType == ActionType.supabaseAuth ||
                      widget.element.actionType == ActionType.tetaAuth))
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 8),
                      child: Row(
                        children: [
                          THeadline3(
                            widget.element.actionNavigation ==
                                        ActionNavigation.openBottomSheet ||
                                    widget.element.actionNavigation ==
                                        ActionNavigation.openSnackBar
                                ? 'Select component'
                                : 'Which page?',
                          ),
                        ],
                      ),
                    ),
                    CDropdown(
                      value: widget.prj.pages!
                              .where((final element) {
                                if (widget.element.actionNavigation ==
                                        ActionNavigation.openBottomSheet ||
                                    widget.element.actionNavigation ==
                                        ActionNavigation.openSnackBar) {
                                  return !element.isPage;
                                } else {
                                  return element.isPage;
                                }
                              })
                              .toList()
                              .contains(pageObject)
                          ? dropdownLinkPage
                          : null,
                      items: widget.prj.pages!
                          .where((final element) {
                            if (widget.element.actionNavigation ==
                                    ActionNavigation.openBottomSheet ||
                                widget.element.actionNavigation ==
                                    ActionNavigation.openSnackBar) {
                              return !element.isPage;
                            } else {
                              return element.isPage;
                            }
                          })
                          .map((final e) => e.name)
                          .toSet()
                          .toList(),
                      onChange: (final newValue) {
                        if (newValue != null) {
                          final old = widget.element;
                          pageObject = widget.prj.pages!.firstWhere(
                            (final element) => element.name == newValue,
                          );
                          widget.element.nameOfPage = newValue;
                          if (mounted) {
                            setState(() {
                              dropdownLinkPage = newValue;
                            });
                          }
                          widget.callBack(widget.element, old);
                        }
                      },
                    ),
                    if (pageObject != null &&
                        pageObject?.params != <VariableObject>[])
                      pageObject?.params.isNotEmpty ?? false
                          ? Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: Stack(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(top: 8),
                                    padding: const EdgeInsets.only(
                                      left: 16,
                                      right: 16,
                                      top: 16,
                                    ),
                                    width: double.maxFinite,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: const Color(0xFFFFBF2F),
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: pageObject!.params
                                          .map(
                                            (final e) => _Element(
                                              variable: e,
                                              page: widget.page,
                                              map: map,
                                              element: widget.element,
                                              callBack: widget.callBack,
                                            ),
                                          )
                                          .toList(),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(
                                      right: 8,
                                      bottom: 8,
                                    ),
                                    color: const Color(0xFF222222),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: const [
                                        Icon(
                                          FeatherIcons.database,
                                          size: 16,
                                          color: Color(0xFFFFBF2F),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 4),
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
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Row(
                                children: [
                                  TDetailLabel(
                                    'This page has not params',
                                    color: Colors.white.withOpacity(0.8),
                                  ),
                                ],
                              ),
                            ),
                    if (widget.element.actionType == ActionType.supabaseAuth &&
                        (widget.element.actionSupabaseAuth ==
                                ActionSupabaseAuth.signUp ||
                            widget.element.actionSupabaseAuth ==
                                ActionSupabaseAuth.signInWithCredential) &&
                        (widget.page.states.indexWhere(
                                  (final element) =>
                                      element.name.toLowerCase() == 'email',
                                ) ==
                                -1 ||
                            widget.page.states.indexWhere(
                                  (final element) =>
                                      element.name.toLowerCase() == 'password',
                                ) ==
                                -1 ||
                            widget.page.states.indexWhere(
                                  (final element) =>
                                      element.name.toLowerCase() == 'status',
                                ) ==
                                -1 ||
                            widget.page.states.indexWhere(
                                  (final element) =>
                                      element.name.toLowerCase() == 'status',
                                ) ==
                                -1))
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFFFFBF2F)),
                          borderRadius: BorderRadius.circular(8),
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
                              padding: EdgeInsets.only(top: 8, bottom: 8),
                              child: TParagraph(
                                'The names of the variables are not case sensitive',
                              ),
                            ),
                            if (kDebugMode)
                              TextButton(
                                onPressed: () {
                                  var flag = false;
                                  if (widget.page.states.indexWhere(
                                        (final element) =>
                                            element.name.toLowerCase() ==
                                            'email',
                                      ) ==
                                      -1) {
                                    widget.page.states.add(
                                      VariableObject(
                                        id: const Uuid().v1(),
                                        type: VariableType.string,
                                        name: 'Email',
                                        defaultValue: '0',
                                      ),
                                    );
                                    flag = true;
                                  }
                                  if (widget.page.states.indexWhere(
                                        (final element) =>
                                            element.name.toLowerCase() ==
                                            'password',
                                      ) ==
                                      -1) {
                                    widget.page.states.add(
                                      VariableObject(
                                        id: const Uuid().v1(),
                                        type: VariableType.string,
                                        name: 'Password',
                                        defaultValue: '0',
                                      ),
                                    );
                                    flag = true;
                                  }
                                  if (widget.page.states.indexWhere(
                                        (final element) =>
                                            element.name.toLowerCase() ==
                                            'status',
                                      ) ==
                                      -1) {
                                    widget.page.states.add(
                                      VariableObject(
                                        id: const Uuid().v1(),
                                        type: VariableType.string,
                                        name: 'Status',
                                        defaultValue: '0',
                                      ),
                                    );
                                    flag = true;
                                  }

                                  if (flag) {
                                    NodeRepository.change(
                                      nodeId: widget.page.scaffold!.nid,
                                      node: widget.page.scaffold! as NDynamic,
                                      pageId: widget.page.id,
                                      key: 'states',
                                      value: widget.page.states
                                          .map((final e) => e.toJson())
                                          .toList(),
                                      old: null,
                                    );
                                  }
                                  BlocProvider.of<FocusBloc>(context)
                                      .add(OnFocus(node: widget.node));
                                  BlocProvider.of<RefreshCubit>(context)
                                      .change();
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.white24,
                                    borderRadius: BorderRadius.circular(8),
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
              if (widget.element.actionType == ActionType.supabaseDatabase &&
                  widget.element.actionSupabaseDB == ActionSupabaseDB.insert)
                SupabaseInsertControl(
                  prj: widget.prj,
                  page: widget.page,
                  node: widget.node,
                  action: widget.element,
                  callback: () {
                    final old = widget.element;
                    widget.callBack(widget.element, old);
                  },
                ),
              if (widget.element.actionType == ActionType.tetaDatabase &&
                  widget.element.actionTetaDB == ActionTetaCmsDB.insert)
                TetaCmsInsertControl(
                  prj: widget.prj,
                  page: widget.page,
                  node: widget.node,
                  action: widget.element,
                  callback: () {
                    final old = widget.element;
                    widget.callBack(widget.element, old);
                  },
                ),
              if (widget.element.actionType == ActionType.tetaDatabase &&
                  widget.element.actionTetaDB == ActionTetaCmsDB.fetch)
                TetaCmsFetchControl(
                  prj: widget.prj,
                  page: widget.page,
                  node: widget.node,
                  action: widget.element,
                  callback: () {
                    final old = widget.element;
                    widget.callBack(widget.element, old);
                    final page = BlocProvider.of<PageCubit>(context).state;
                    FATetaCMSFetch.action(
                      context,
                      widget.element.cmsCollectionId ?? '',
                      widget.element.cmsLimit ?? FTextTypeInput(),
                      widget.element.cmsPage ?? FTextTypeInput(),
                      widget.element.cmsKeyValue ?? FTextTypeInput(),
                      widget.element.cmsKeyName ?? FTextTypeInput(),
                      false,
                      page.params,
                      page.states,
                      page.datasets,
                      0,
                    );
                  },
                ),
              if (widget.element.actionType == ActionType.supabaseDatabase &&
                  widget.element.actionSupabaseDB == ActionSupabaseDB.update)
                SupabaseUpdateControl(
                  prj: widget.prj,
                  page: widget.page,
                  node: widget.node,
                  action: widget.element,
                  callback: () {
                    final old = widget.element;
                    widget.callBack(widget.element, old);
                  },
                ),
              if (widget.element.actionType == ActionType.tetaDatabase &&
                  widget.element.actionTetaDB == ActionTetaCmsDB.update)
                TetaCmsUpdateControl(
                  prj: widget.prj,
                  page: widget.page,
                  node: widget.node,
                  action: widget.element,
                  callback: () {
                    final old = widget.element;
                    widget.callBack(widget.element, old);
                  },
                ),
              if (widget.element.actionType == ActionType.supabaseDatabase &&
                  widget.element.actionSupabaseDB == ActionSupabaseDB.delete)
                SupabaseDeleteControl(
                  prj: widget.prj,
                  page: widget.page,
                  node: widget.node,
                  action: widget.element,
                  callback: () {
                    final old = widget.element;
                    widget.callBack(widget.element, old);
                  },
                ),
              if (widget.element.actionType == ActionType.tetaDatabase &&
                  widget.element.actionTetaDB == ActionTetaCmsDB.delete)
                TetaCmsDeleteControl(
                  prj: widget.prj,
                  page: widget.page,
                  node: widget.node,
                  action: widget.element,
                  callback: () {
                    final old = widget.element;
                    widget.callBack(widget.element, old);
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Element extends StatefulWidget {
  const _Element({
    required this.variable,
    required this.page,
    required this.map,
    required this.element,
    required this.callBack,
    final Key? key,
  }) : super(key: key);

  final VariableObject variable;
  final PageObject page;
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
    Logger.printMessage('${widget.page.datasets}');
    Logger.printMessage('Params: ${widget.page.params}');
    final params = Map<String, dynamic>.fromEntries(
      widget.page.params
          .where((final element) => widget.variable.type == element.type)
          .map((final e) => MapEntry<String, dynamic>(e.name, e.get)),
    );
    final states = Map<String, dynamic>.fromEntries(
      widget.page.states
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
      if (widget.variable.type == VariableType.string) ...widget.page.datasets
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
    Logger.printMessage('Params: ${widget.page.params}');
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
            child: THeadline3(
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
