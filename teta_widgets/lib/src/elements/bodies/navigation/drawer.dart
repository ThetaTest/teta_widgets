// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:teta_core/src/models/dataset.dart';
import 'package:teta_core/src/models/variable.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/templates/navigation/drawer.dart';
import 'package:teta_widgets/src/elements/controls/control_model.dart';
import 'package:teta_widgets/src/elements/intrinsic_states/class.dart';
import 'package:teta_widgets/src/elements/nodes/categories.dart';
import 'package:teta_widgets/src/elements/nodes/children_enum.dart';
import 'package:teta_widgets/src/elements/nodes/enum.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';
import 'package:teta_widgets/src/elements/widgets/navigation/drawer.dart';

const _globalType = NType.drawer;

/// Drawer
final drawerIntrinsicStates = IntrinsicStates(
  nodeIcon: Assets.wIcons.drawer,
  nodeVideo: null,
  nodeDescription: null,
  advicedChildren: [],
  blockedTypes: [],
  synonymous: [],
  advicedChildrenCanHaveAtLeastAChild: [],
  displayName: 'Menu (Drawer)',
  type: _globalType,
  category: NodeCategories.unclassified,
  maxChildren: 1,
  canHave: ChildrenEnum.child,
  addChildLabels: ['Add Widget To Drawer'],
  gestures: [],
  permissions: [],
  packages: [],
);

/// Body
class DrawerBody extends NodeBody {
  @override
  // ignore: overridden_fields
  Map<String, dynamic> attributes = <String, dynamic>{};

  @override
  List<ControlModel> get controls => [];

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
      WDrawer(
        const ValueKey('Drawer'),
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
      drawerCodeTemplate(context, this, child);
}
