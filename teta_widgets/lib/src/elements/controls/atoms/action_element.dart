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
import 'package:hovering/hovering.dart';
import 'package:teta_core/src/design_system/textfield/minitextfield.dart';
import 'package:teta_core/src/repositories/node.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/controls/atoms/flag.dart';
import 'package:teta_widgets/src/elements/controls/atoms/subapase/delete.dart';
import 'package:teta_widgets/src/elements/controls/atoms/subapase/insert.dart';
import 'package:teta_widgets/src/elements/controls/atoms/subapase/update.dart';
import 'package:teta_widgets/src/elements/controls/atoms/text.dart';
import 'package:teta_widgets/src/elements/controls/type.dart';
import 'package:teta_widgets/src/elements/features/actions/element.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/audio_player.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/camera.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/gestures.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/navigation.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/revenue_cat.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/state.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/supabase.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/type.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/webview.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_widgets/src/elements/nodes/dynamic.dart';
import 'package:teta_widgets/src/elements/nodes/enum.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
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
                    Icons.delete,
                    size: 24,
                    color: Colors.white,
                  ),
                  onHover: (final e) {},
                  child: const Icon(
                    Icons.delete,
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
                value: FActionElement.convertValueToDropdown(
                  widget.element.actionType,
                ),
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
              const Padding(
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
              ),
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
                          setState(() {
                            delayController.text =
                                widget.element.delay?.value ?? '0';
                          });
                          nodeId = state.first.nid;
                        }
                      }
                    },
                    child: CMiniTextField(
                      controller: delayController,
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
                                setState(() {
                                  loopController.text =
                                      widget.element.everyMilliseconds?.value ??
                                          '0';
                                });
                                nodeId = state.first.nid;
                              }
                            }
                          },
                          child: CMiniTextField(
                            controller: loopController,
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
                value: widget.element.withCondition ?? false,
                callBack: (final flag, final old) {
                  final old = widget.element;
                  widget.element.withCondition = flag;
                  widget.callBack(widget.element, old);
                },
              ),
              if (widget.element.withCondition == true)
                TextControl(
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
                            ActionAudioPlayer.values,
                            newValue,
                          ) as ActionAudioPlayer?;
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
              if (widget.element.actionType == ActionType.state &&
                  widget.element.actionState == ActionState.changeWith)
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
                      final old = widget.element;
                      widget.element.stateName = newValue;
                      widget.callBack(widget.element, old);
                    }
                  },
                ),
              if (widget.element.actionType == ActionType.state &&
                  widget.element.actionState != ActionState.changeWith &&
                  widget.element.actionState != ActionState.changeWithParams)
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
                                element.type == VariableType.double,
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
                        "It requires 'int' or 'double' variables",
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
                        'State',
                      ),
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
              if (widget.element.actionType == ActionType.revenueCat)
                CDropdown(
                  value: FActionElement.convertValueToDropdown(
                    widget.element.actionRevenueCat,
                  ),
                  items: FActionElement.getRevenueCat(widget.prj.config)
                      .toSet()
                      .toList(),
                  onChange: (final newValue) {
                    if (newValue != null) {
                      final old = widget.element;
                      widget.element.actionRevenueCat =
                          FActionElement.convertDropdownToValue(
                        ActionRevenueCat.values,
                        newValue,
                      ) as ActionRevenueCat?;
                      widget.callBack(widget.element, old);
                    }
                  },
                ),
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
                          ActionNavigation.launchURL))
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: SizedBox(
                    width: double.maxFinite,
                    child: BlocListener<FocusBloc, List<CNode>>(
                      listener: (final context, final state) {
                        if (state.isNotEmpty) {
                          if (state.first.nid != nodeId) {
                            setState(() {
                              controller.text = widget.element.value ?? '';
                            });
                            nodeId = state.first.nid;
                          }
                        }
                      },
                      child: CMiniTextField(
                        controller: controller,
                        callBack: (final text) {
                          final old = widget.element;
                          widget.element.value = text;
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
                  (widget.element.actionType == ActionType.supabaseAuth))
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
                          setState(() {
                            dropdownLinkPage = newValue;
                          });
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
                                            (final e) => Element(
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
              /*if (widget.element.actionType == ActionType.shopify &&
                  (widget.element.actionShopify ==
                          ActionShopify.shopifyBuyNow ||
                      widget.element.actionShopify ==
                          ActionShopify.shopifyAddToCart))
                ActionvalueControl(
                  title: 'Prod Id',
                  node: widget.node,
                  page: widget.page,
                  actionValue: widget.,
                  callBack: (text, old) => {
                    NodeRepository(context: context).changeMapAttr(
                      prjId: widget.prj.id,
                      pageId: widget.page.id!,
                      nodeId: widget.node.nid!,
                      key: 'actVal',
                      value: text.toJson(),
                      old: old.toJson(),
                    ),
                  },
                ),*/
            ],
          ),
        ),
      ),
    );
  }
}

class Element extends StatefulWidget {
  const Element({
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
  State<Element> createState() => _ElementState();
}

class _ElementState extends State<Element> {
  List<DatasetObject> listDataset = <DatasetObject>[];
  String? dropdownDataset;
  String? dropdown;
  final listSecondDropwdown = <Map<String, dynamic>>[];

  @override
  void initState() {
    super.initState();

    listDataset = <DatasetObject>[
      DatasetObject(
        name: 'Parameters',
        map: [
          <String, dynamic>{for (var e in widget.page.params) e.name: e.get},
        ],
      ),
      DatasetObject(
        name: 'States',
        map: [
          <String, dynamic>{for (var e in widget.page.states) e.name: e.get},
        ],
      ),
      ...widget.page.datasets
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
                setState(() {
                  dropdownDataset = newValue;
                });
              },
            ),
          if (dropdownDataset != null && listSecondDropwdown.isNotEmpty)
            CDropdown(
              value: listSecondDropwdown.first.keys
                      .map((final key) => key)
                      .contains(dropdown)
                  ? dropdown
                  : null,
              items: listSecondDropwdown.first.keys
                  .map((final key) => key)
                  .toSet()
                  .toList(),
              onChange: (final newValue) {
                if (newValue != null) {
                  setState(() {
                    dropdown = newValue;
                  });
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
