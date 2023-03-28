// Flutter imports:
import 'package:flutter/material.dart';
import 'package:teta_core/teta_core.dart';
// Package imports:
import 'package:theta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:theta_widgets/src/elements/code/templates/navigation/appbar.dart';
import 'package:theta_widgets/src/elements/controls/control_model.dart';
import 'package:theta_widgets/src/elements/intrinsic_states/class.dart';
import '../../../../../../../teta_open_classes/lib/src/nodes/categories.dart';
import '../../../../../../../teta_open_classes/lib/src/nodes/children_enum.dart';
import '../../../../../../../teta_open_classes/lib/src/nodes/enum.dart';
import '../../../../../../../teta_open_classes/lib/src/nodes/node.dart';
import '../../../../../../../teta_open_classes/lib/src/nodes/node_body.dart';
import 'package:theta_widgets/src/elements/tips/schema.dart';
import 'package:theta_widgets/src/elements/widgets/navigation/appbar.dart';
import 'package:theta_models/theta_models.dart';

const _globalType = NType.appBar;

/// IS
final appBarIntrinsicStates = IntrinsicStates(
  nodeIcon: Assets.wIcons.appBar,
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
      [];

  @override
  Widget toWidget({
    required final TetaWidgetState state,
    final CNode? child,
    final List<CNode>? children,
  }) =>
      WAppBar(
        const ValueKey('AppBar'),
        state: state,
        child: child,
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
      AppBarCodeTemplate.toCode(context, this, child);
}
