// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:theta_widgets/src/core/teta_widget/index.dart';
import 'package:theta_widgets/src/elements/code/snippets.dart';
// Project imports:
import 'package:theta_widgets/src/elements/code/templates/stack.dart';
import 'package:theta_widgets/src/elements/controls/control_model.dart';
import 'package:theta_widgets/src/elements/intrinsic_states/class.dart';
import 'package:theta_widgets/src/elements/nodes/categories.dart';
import 'package:theta_widgets/src/elements/nodes/children_enum.dart';
import 'package:theta_widgets/src/elements/nodes/enum.dart';
import 'package:theta_widgets/src/elements/nodes/node.dart';
import 'package:theta_widgets/src/elements/nodes/node_body.dart';
import 'package:theta_widgets/src/elements/widgets/stack.dart';

const _globalType = NType.stack;

/// IS
final stackIntrinsicStates = IntrinsicStates(
  nodeIcon: Assets.wIcons.stack,
  nodeVideo: 'liEGSeD3Zt8', //Check
  nodeDescription: null,
  advicedChildren: [],
  blockedTypes: [],
  synonymous: ['stack', 'overlay', 'position absolute'],
  advicedChildrenCanHaveAtLeastAChild: [],
  displayName: NodeType.name(_globalType),
  type: _globalType,
  category: NodeCategories.layout,
  maxChildren: null,
  canHave: ChildrenEnum.children,
  addChildLabels: [],
  gestures: [],
  permissions: [],
  packages: [],
);

/// Body for Stack widget
class StackBody extends NodeBody {
  @override
  // ignore: overridden_fields
  Map<String, dynamic> attributes = <String, dynamic>{};

  @override
  List<ControlModel> get controls => [];

  @override
  Widget toWidget({
    required final TetaWidgetState state,
    final CNode? child,
    final List<CNode>? children,
  }) =>
      WStack(
        ValueKey(
          '''
            ${state.toKey}
            ${child ?? children}
            ''',
        ),
        state: state,
        children: children ?? [],
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
      CS.defaultWidgets(
        context,
        node,
        pageId,
        StackCodeTemplate.toCode(context, this, children ?? []),
        loop ?? 0,
      );
}
