// Flutter imports:
// ignore_for_file: lines_longer_than_80_chars

// Package imports:
import 'package:collection/collection.dart';
// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/code/page/code_component.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/page/scaffold.dart';
import 'package:teta_widgets/src/elements/controls/control_model.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/controls/type.dart';
import 'package:teta_widgets/src/elements/features/action.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/index.dart';
import 'package:teta_widgets/src/elements/features/children_ids.dart';
import 'package:teta_widgets/src/elements/features/fill.dart';
import 'package:teta_widgets/src/elements/features/margins.dart';
import 'package:teta_widgets/src/elements/features/sizes.dart';
import 'package:teta_widgets/src/elements/intrinsic_states/class.dart';
import 'package:teta_widgets/src/elements/nodes/categories.dart';
import 'package:teta_widgets/src/elements/nodes/children_enum.dart';
import 'package:teta_widgets/src/elements/nodes/dynamic.dart';
import 'package:teta_widgets/src/elements/nodes/enum.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';
import 'package:teta_widgets/src/elements/widgets/scaffold.dart';

const _globalType = NType.scaffold;

/// Intrinsic State of Scaffold
final scaffoldIntrinsicStates = IntrinsicStates(
  nodeIcon: Assets.icons.devices.smartphone,
  nodeVideo: null,
  nodeDescription: null,
  advicedChildren: [
    NodeType.name(NType.listView),
    NodeType.name(NType.column),
  ],
  blockedTypes: [],
  synonymous: ['safearea', 'padding'],
  advicedChildrenCanHaveAtLeastAChild: [],
  displayName: NodeType.name(_globalType),
  type: _globalType,
  category: NodeCategories.unclassified,
  maxChildren: 4,
  canHave: ChildrenEnum.children,
  addChildLabels: ['Add To Body', 'Add To Body', 'Add To Body', 'Add To Body'],
  gestures: [
    ActionGesture.initState,
  ],
  permissions: [],
  packages: [],
);

/// Body of Scaffold
class ScaffoldBody extends NodeBody {
  /// Constructor
  /// name is used to set the page name
  ScaffoldBody() : super();

  @override
  // ignore: overridden_fields
  Map<String, dynamic> attributes = <String, dynamic>{
    DBKeys.width: FSize(
      size: '375',
      unit: SizeUnit.pixel,
    ),
    DBKeys.height: FSize(
      size: '812',
      unit: SizeUnit.pixel,
    ),
    DBKeys.padding: FMargins(),
    DBKeys.fill: FFill(),
    DBKeys.action: FAction(),
    DBKeys.showAppBar: false,
    DBKeys.showBottomBar: false,
    DBKeys.showDrawer: false,
    DBKeys.flag: true,
  };

  /// Parameters of the page
  List<VariableObject> params = [];

  /// States of the page
  List<VariableObject> states = [];

  /// Dataset of the page
  List<DatasetObject> dataset = [];

  /// AppBar node. It will be instantiate in node rendering class.
  NDynamic appBar = NDynamic(
    globalType: NType.appBar,
    body: NDynamic.getBody(NType.appBar),
    childrenIds: FChildrenIds(),
    inSpawned: false,
  );

  /// BottomBar node. It will be instantiate in node rendering class.
  NDynamic bottomBar = NDynamic(
    globalType: NType.bottomBar,
    body: NDynamic.getBody(NType.bottomBar),
    childrenIds: FChildrenIds(),
    inSpawned: false,
  );

  /// Drawer node. It will be instantiate in node rendering class.
  NDynamic drawer = NDynamic(
    globalType: NType.drawer,
    body: NDynamic.getBody(NType.drawer),
    childrenIds: FChildrenIds(),
    inSpawned: false,
  );

  @override
  List<ControlModel> get controls => [
        ControlObject(
          type: ControlType.action,
          key: DBKeys.action,
          value: attributes[DBKeys.action],
        ),
        FlagControlObject(
          title: 'ResizeToAvoidBottomInset',
          key: DBKeys.flag,
          value: attributes[DBKeys.flag],
          description:
              'if true, the bottombar is hidden under the keyboard. if false it is put on top',
        ),
        /*FlagControlObject(
          title: 'Show AppBar',
          key: DBKeys.showAppBar,
          value: attributes[DBKeys.showAppBar],
          description:
              'It is a horizontal bar typically shown at the top of an app using the appBar property',
        ),
        FlagControlObject(
          title: 'Show BottomBar',
          key: DBKeys.showBottomBar,
          value: attributes[DBKeys.showBottomBar],
          description:
              'It is a horizontal bar typically shown at the bottom of an app using the bottomNavigationBar property',
        ),
        */
      ];

  @override
  Widget toWidget({
    required final List<VariableObject> params,
    required final List<VariableObject> states,
    required final List<DatasetObject> dataset,
    required final bool forPlay,
    required final CNode node,
    final int? loop,
    final CNode? child,
    final List<CNode>? children,
  }) =>
      WScaffold(
        ValueKey(
          '''
            ${node.nid}
            $loop
            ${child ?? children}
            ${(attributes[DBKeys.fill] as FFill).toJson()}
            ${(attributes[DBKeys.width] as FSize).toJson()}
            ${(attributes[DBKeys.height] as FSize).toJson()}
            ${(attributes[DBKeys.action] as FAction).toJson()}
            ${attributes[DBKeys.showAppBar] as bool}
            ${attributes[DBKeys.showBottomBar] as bool}
            ${attributes[DBKeys.showDrawer] as bool}
            ${attributes[DBKeys.flag] as bool}
            ''',
        ),
        node: node,
        children: children ?? [],
        fill: attributes[DBKeys.fill] as FFill,
        width: attributes[DBKeys.width] as FSize,
        height: attributes[DBKeys.height] as FSize,
        action: attributes[DBKeys.action] as FAction,
        forPlay: forPlay,
        appBar: appBar,
        bottomBar: bottomBar,
        drawer: drawer,
        flag: attributes[DBKeys.flag] as bool,
        showAppBar: attributes[DBKeys.showAppBar] as bool,
        showBottomBar: attributes[DBKeys.showBottomBar] as bool,
        showDrawer: attributes[DBKeys.showDrawer] as bool,
        isScrollable: false,
        isClipped: false,
        bodyExtended: false,
        params: params.map((final e) {
          if (forPlay) {
            try {
              final par = params
                  .firstWhereOrNull((final element) => element.id == e.id);

              e.value = par?.value ?? par?.defaultValue;
            } catch (e) {
              debugPrint('$e');
            }
          }
          return e;
        }).toList(),
        states: states,
        dataset: dataset,
        loop: loop,
      );

  @override
  String toCode(
    final BuildContext context,
    final CNode node,
    final CNode? child,
    final List<CNode>? children,
    final int pageId,
    final int? loop,
  ) {
    final prj =
        (BlocProvider.of<FocusProjectBloc>(context).state as ProjectLoaded).prj;
    final page = prj.pages!.firstWhere((final element) => element.id == pageId);
    if (!page.isHardCoded) {
      return pageCodeTemplate(context, node, children ?? [], pageId);
    } else {
      return codeComponentTemplate(context, node, children ?? [], pageId);
    }
  }
}
