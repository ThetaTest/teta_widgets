// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/src/repositories/node.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/templates/navigation/appbar.dart';
import 'package:teta_widgets/src/elements/controls/control_model.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/intrinsic_states/class.dart';
import 'package:teta_widgets/src/elements/nodes/categories.dart';
import 'package:teta_widgets/src/elements/nodes/children_enum.dart';
import 'package:teta_widgets/src/elements/nodes/dynamic.dart';
import 'package:teta_widgets/src/elements/nodes/enum.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';
import 'package:teta_widgets/src/elements/tips/schema.dart';
import 'package:teta_widgets/src/elements/widgets/navigation/appbar.dart';

const _globalType = NType.appBar;

/// IS
final appBarIntrinsicStates = IntrinsicStates(
  nodeIcon: Assets.wIcons.appbar,
  nodeVideo: null,
  nodeDescription: null,
  advicedChildren: [],
  blockedTypes: [],
  synonymous: [],
  advicedChildrenCanHaveAtLeastAChild: [],
  displayName: NodeType.name(_globalType),
  type: _globalType,
  category: NodeCategories.unclassified,
  maxChildren: 1,
  canHave: ChildrenEnum.child,
  addChildLabels: ['Add AppBar Widget'],
  gestures: [],
  permissions: [],
  packages: [],
);

/// Body
class AppBarBody extends NodeBody {
  @override
  // ignore: overridden_fields
  Map<String, dynamic> attributes = <String, dynamic>{};

  @override
  List<ControlModel> get controls => [];

  List<TipObject> tips(
    final BuildContext context,
    final PageObject page,
    final CNode node,
  ) =>
      [
        TipObject(
          isVisible: node.child == null,
          title: 'Add Automatic AppBar',
          description: 'Automatic AppBar is the default AppBar',
          networkImage: '',
          onTap: () {
            NodeRepository.change(
              nodeId: page.scaffold!.nid,
              node: page.scaffold! as NDynamic,
              pageId: page.id,
              key: DBKeys.showAppBar,
              value: true,
              old: page.scaffold!.body.attributes[DBKeys.showAppBar] as bool,
            );
            page.scaffold!.body.attributes[DBKeys.showAppBar] = true;
          },
        )
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
      WAppBar(
        const ValueKey('AppBar'),
        node: node,
        child: child,
        forPlay: forPlay,
        params: params,
        states: states,
        dataset: dataset,
      );

  @override
  Future<String> toCode(
    final BuildContext context,
    final CNode node,
    final CNode? child,
    final List<CNode>? children,
    final int pageId,
    final int? loop,
  ) =>
      appBarCodeTemplate(context, this, child);
}
