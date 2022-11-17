// Flutter imports:
// ignore_for_file: public_member_api_docs

import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:gap/gap.dart';
// Package imports:
import 'package:teta_core/src/design_system/buttons/element_button.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/controls/atoms/action_element.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/action_google_maps.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/audio_player_actions.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/braintree.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/camera.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/custom_http_request.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/index.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/mixpanel.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/qonversion.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/revenue_cat.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/stripe.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/teta_cms.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/theme.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/translator.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/webview.dart';
import 'package:teta_widgets/src/elements/index.dart';
import 'package:uuid/uuid.dart';

class ActionControl extends StatefulWidget {
  const ActionControl({
    required this.prj,
    required this.page,
    required this.node,
    required this.action,
    required this.callBack,
    final Key? key,
  }) : super(key: key);

  final ProjectObject prj;
  final PageObject page;
  final CNode node;
  final FAction action;
  final Function(FAction, FAction) callBack;

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
    if (widget.prj.pages != null) pageObject = widget.prj.pages!.first;
    if (pageObject != null) dropdown = pageObject!.name;
  }

  @override
  Widget build(final BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final trigger in widget.node.intrinsicState.gestures.isNotEmpty
              ? widget.node.intrinsicState.gestures
              : [
                  ActionGesture.onTap,
                  ActionGesture.onLongPress,
                  ActionGesture.onDoubleTap
                ])
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TParagraph(
                  EnumToString.convertToString(trigger, camelCase: true),
                ),
                Divider(
                  color: Palette.txtPrimary.withOpacity(0.3),
                ),
                ElementButton(
                  title: 'New action',
                  isSelected: false,
                  icon: FeatherIcons.plus,
                  onTap: () {
                    final pageBloc = BlocProvider.of<PageCubit>(context);
                    showDialog<void>(
                      context: context,
                      builder: (final context) => BlocProvider.value(
                        value: pageBloc,
                        child: _NewActionAlert(
                          callback: (final value, final actionString) {
                            final dynamic action =
                                FActionElement.convertDropdownToValue(
                              value.type,
                              actionString,
                            );
                            final old = widget.action;
                            widget.action.actions = [
                              ...widget.action.actions ?? [],
                              FActionElement(
                                id: const Uuid().v1(),
                                actionType: value.actionType,
                                actionGesture: trigger,
                                actionState:
                                    (action is ActionState) ? action : null,
                                actionNavigation: (action is ActionNavigation)
                                    ? action
                                    : null,
                                actionTheme:
                                    (action is ActionTheme) ? action : null,
                                actionWebView:
                                    (action is ActionWebView) ? action : null,
                                actionQonversion: (action is ActionQonversion)
                                    ? action
                                    : null,
                                actionAudioPlayer:
                                    (action is ActionAudioPlayerActions)
                                        ? action
                                        : null,
                                actionRevenueCat: (action is ActionRevenueCat)
                                    ? action
                                    : null,
                                actionStripe:
                                    (action is ActionStripe) ? action : null,
                                actionCamera:
                                    (action is ActionCamera) ? action : null,
                                actionSupabaseAuth:
                                    (action is ActionSupabaseAuth)
                                        ? action
                                        : null,
                                actionSupabaseDB: (action is ActionSupabaseDB)
                                    ? action
                                    : null,
                                actionTetaAuth: (action is ActionTetaCmsAuth)
                                    ? action
                                    : null,
                                actionTetaDB:
                                    (action is ActionTetaCmsDB) ? action : null,
                                actionCustomHttpRequest:
                                    (action is ActionCustomHttpRequest)
                                        ? action
                                        : null,
                                actionTranslator: (action is ActionTranslator)
                                    ? action
                                    : null,
                              )
                            ];
                            widget.callBack(widget.action, old);
                            Navigator.of(context, rootNavigator: true)
                                .pop(null);
                          },
                        ),
                      ),
                    );
                  },
                ),
                for (final element in (widget.action.actions ??
                        <FActionElement>[])
                    .where((final element) => element.actionGesture == trigger)
                    .toList())
                  ActionElementControl(
                    name: EnumToString.convertToString(
                      element.actionType,
                      camelCase: true,
                    ),
                    element: element,
                    prj: widget.prj,
                    page: widget.page,
                    node: widget.node,
                    callBack: (final value, final old) {
                      final old = widget.action;
                      final index = widget.action.actions!.indexOf(element);
                      widget.action.actions![index] = value;
                      widget.callBack(widget.action, old);
                    },
                    callBackToDelete: () {
                      final old = widget.action;
                      widget.action.actions!.remove(element);
                      widget.callBack(widget.action, old);
                    },
                  ),
                const Gap(Grid.medium),
              ],
            ),
          /*Padding(
            padding: EdgeInsets.only(
              bottom: widget.action.actions?.isEmpty ?? true ? 0 : 8,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const THeadline3(
                  'Actions',
                ),
                Row(
                  children: [
                    BounceSmall(
                      onTap: () {
                        final old = widget.action;
                        widget.action.actions = [
                          ...widget.action.actions ?? [],
                          FActionElement(id: const Uuid().v1())
                        ];
                        widget.callBack(widget.action, old);
                      },
                      child: HoverWidget(
                        hoverChild: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white,
                            ),
                          ),
                          child: const Icon(
                            Icons.add,
                            size: 24,
                            color: Colors.white,
                          ),
                        ),
                        onHover: (final e) {},
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.transparent,
                            ),
                          ),
                          child: const Icon(
                            Icons.add,
                            size: 24,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            children: widget.action.actions!
                .map(
                  (final e) => ActionElementControl(
                    name: 'Action ${widget.action.actions!.indexOf(e)}',
                    element: e,
                    prj: widget.prj,
                    page: widget.page,
                    node: widget.node,
                    callBack: (final value, final old) {
                      final old = widget.action;
                      final index = widget.action.actions!.indexOf(e);
                      widget.action.actions![index] = value;
                      widget.callBack(widget.action, old);
                    },
                    callBackToDelete: () {
                      final old = widget.action;
                      widget.action.actions!.remove(e);
                      widget.callBack(widget.action, old);
                    },
                  ),
                )
                .toList(),
          ),*/
        ],
      ),
    );
  }
}

class _NewActionAlert extends StatefulWidget {
  const _NewActionAlert({
    final Key? key,
    required this.callback,
  }) : super(key: key);

  final Function(_SelectionClass, String) callback;

  @override
  State<_NewActionAlert> createState() => __NewActionAlertState();
}

class __NewActionAlertState extends State<_NewActionAlert> {
  final elements = <_SelectionClass>[];

  @override
  void initState() {
    super.initState();
    final prj =
        (BlocProvider.of<FocusProjectBloc>(context).state as ProjectLoaded).prj;
    final page = BlocProvider.of<PageCubit>(context).state;
    elements.addAll([
      _SelectionClass(
        title: 'State',
        actionType: ActionType.state,
        options: FActionElement.getState(),
        type: ActionState.values,
      ),
      _SelectionClass(
        title: 'Navigation',
        actionType: ActionType.navigation,
        options: FActionElement.getNavigation(),
        type: ActionNavigation.values,
      ),
      _SelectionClass(
        title: 'Teta Auth',
        actionType: ActionType.tetaAuth,
        options: FActionElement.getTetaAuth(),
        type: ActionTetaCmsAuth.values,
      ),
      _SelectionClass(
        title: 'Teta CMS',
        actionType: ActionType.tetaDatabase,
        options: FActionElement.getTetaDB(),
        type: ActionTetaCmsDB.values,
      ),
      _SelectionClass(
        title: 'Custom Http Request',
        actionType: ActionType.customHttpRequest,
        options: FActionElement.getCustomHttpRequest(),
        type: ActionCustomHttpRequest.values,
      ),
      _SelectionClass(
        title: 'Multi languages',
        actionType: ActionType.translator,
        options: FActionElement.getTranslator(),
        type: ActionTranslator.values,
      ),
      _SelectionClass(
        title: 'Theme',
        actionType: ActionType.theme,
        options: FActionElement.getTheme(),
        type: ActionTheme.values,
      ),
      _SelectionClass(
        title: 'Mixpanel',
        actionType: ActionType.mixpanel,
        options: FActionElement.getMixpanel(prj.config),
        type: ActionMixpanel.values,
      ),
      _SelectionClass(
        title: 'Supabase Auth',
        actionType: ActionType.supabaseAuth,
        options: FActionElement.getSupabaseAuth(prj.config),
        type: ActionSupabaseAuth.values,
      ),
      _SelectionClass(
        title: 'Supabase DB',
        actionType: ActionType.supabaseDatabase,
        options: FActionElement.getSupabaseDB(prj.config),
        type: ActionSupabaseDB.values,
      ),
      _SelectionClass(
        title: 'Supabase Functions',
        actionType: ActionType.supabaseFunctions,
        options: FActionElement.getSupabaseFunctions(prj.config),
        type: ActionSupabaseFunctions.values,
      ),
      _SelectionClass(
        title: 'Supabase Storage',
        actionType: ActionType.supabaseStorage,
        options: FActionElement.getSupabaseStorage(prj.config),
        type: ActionSupabaseStorage.values,
      ),
      _SelectionClass(
        title: 'RevenueCat',
        actionType: ActionType.revenueCat,
        options: FActionElement.getRevenueCat(prj.config),
        type: ActionRevenueCat.values,
      ),
      _SelectionClass(
        title: 'Qonversion',
        actionType: ActionType.qonversion,
        options: FActionElement.getQonversion(prj.config),
        type: ActionQonversion.values,
      ),
      _SelectionClass(
        title: 'Braintree',
        actionType: ActionType.braintree,
        options: FActionElement.getBraintree(prj.config),
        type: ActionBraintree.values,
      ),
      _SelectionClass(
        title: 'WebView',
        actionType: ActionType.webview,
        options: ((page.flatList ?? <CNode>[]).indexWhere(
                  (final element) =>
                      element.intrinsicState.type == NType.webview,
                ) !=
                -1)
            ? FActionElement.getWebView()
            : [],
        type: ActionWebView.values,
      ),
      _SelectionClass(
        title: 'Audio Player',
        actionType: ActionType.audioPlayer,
        options: ((page.flatList ?? <CNode>[]).indexWhere(
                  (final element) =>
                      element.intrinsicState.type == NType.audioPlayer,
                ) !=
                -1)
            ? FActionElement.getAudioPlayer()
            : [],
        type: ActionAudioPlayerActions.values,
      ),
      _SelectionClass(
        title: 'Google Maps',
        actionType: ActionType.googleMaps,
        options: ((page.flatList ?? <CNode>[]).indexWhere(
                  (final element) =>
                      element.intrinsicState.type == NType.googleMaps,
                ) !=
                -1)
            ? FActionElement.getGoogleMaps(null)
            : [],
        type: ActionGoogleMaps.values,
      ),
    ]);
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
                    .options
                    .map(
                      (final e) => BounceSmall(
                        onTap: () {
                          widget.callback(
                            elements[index],
                            e,
                          );
                        },
                        child: TContainer(
                          margin: const EdgeInsets.only(
                            right: 8,
                            bottom: 8,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Palette.bgGrey,
                            borderRadius: BR(40),
                          ),
                          child: TParagraph(e),
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
    required this.actionType,
    required this.options,
    required this.type,
  });

  final String title;
  final ActionType actionType;
  final List<String> options;
  final List<dynamic> type;
}
