// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:teta_core/src/models/dataset.dart';
import 'package:teta_core/src/models/variable.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/templates/page_view.dart';
import 'package:teta_widgets/src/elements/controls/control_model.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/controls/type.dart';
import 'package:teta_widgets/src/elements/features/action.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/index.dart';
import 'package:teta_widgets/src/elements/intrinsic_states/class.dart';
import 'package:teta_widgets/src/elements/nodes/categories.dart';
import 'package:teta_widgets/src/elements/nodes/children_enum.dart';
import 'package:teta_widgets/src/elements/nodes/enum.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';
import 'package:teta_widgets/src/elements/widgets/page_view.dart';

const _globalType = NType.pageView;

/// Intrinsic States of PageView
final pageViewIntrinsicStates = IntrinsicStates(
  nodeIcon: Assets.wIcons.pageView,
  nodeVideo: null,
  nodeDescription: null,
  advicedChildren: [
    NodeType.name(NType.container),
    NodeType.name(NType.column),
    NodeType.name(NType.stack),
  ],
  blockedTypes: [],
  synonymous: ['pageview', 'slider', 'carousel'],
  advicedChildrenCanHaveAtLeastAChild: [],
  displayName: NodeType.name(_globalType),
  type: _globalType,
  category: NodeCategories.list,
  maxChildren: null,
  canHave: ChildrenEnum.children,
  addChildLabels: [],
  gestures: [
    ActionGesture.onChange,
  ],
  permissions: [],
  packages: [],
);

/// PageView's body
class PageViewBody extends NodeBody {
  @override
  // ignore: overridden_fields
  Map<String, dynamic> attributes = <String, dynamic>{
    DBKeys.isVertical: true,
    DBKeys.action: FAction(),
  };

  @override
  List<ControlModel> get controls => [
        ControlObject(
          type: ControlType.action,
          key: DBKeys.action,
          value: attributes[DBKeys.action],
        ),
        FlagControlObject(
          title: 'Is Vertical',
          key: DBKeys.isVertical,
          value: attributes[DBKeys.isVertical],
          description: '',
        ),
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
      WPageView(
        ValueKey(
          '''
      ${node.nid}
      $loop
            ${child ?? children}
      ${attributes[DBKeys.isVertical] as bool}
      ${(attributes[DBKeys.action] as FAction).toJson()}
      ''',
        ),
        node: node,
        children: children ?? [],
        flagValue: false,
        isVertical: attributes[DBKeys.isVertical] as bool,
        action: attributes[DBKeys.action] as FAction,
        forPlay: forPlay,
        loop: loop,
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
      pageViewCodeTemplate(context, pageId, this, node, children ?? [], loop);
}
