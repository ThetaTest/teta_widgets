// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:teta_core/src/models/dataset.dart';
import 'package:teta_core/src/models/variable.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/templates/clip_rrect.dart';
import 'package:teta_widgets/src/elements/controls/control_model.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/controls/type.dart';
import 'package:teta_widgets/src/elements/features/border_radius.dart';
import 'package:teta_widgets/src/elements/intrinsic_states/class.dart';
import 'package:teta_widgets/src/elements/nodes/categories.dart';
import 'package:teta_widgets/src/elements/nodes/children_enum.dart';
import 'package:teta_widgets/src/elements/nodes/enum.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';
import 'package:teta_widgets/src/elements/widgets/clip_rrect.dart';

const _globalType = NType.clipRoundedRect;

/// Intrinsic States of Center node type
final clipRRectIntrinsicStates = IntrinsicStates(
  nodeIcon: Assets.wIcons.clipRRect,
  nodeVideo: null,
  nodeDescription: 'A widget that centers its child within itself.',
  advicedChildren: [
    NodeType.name(NType.column),
    NodeType.name(NType.row),
    NodeType.name(NType.image),
  ],
  blockedTypes: [],
  synonymous: ['clip rounded', 'mask', 'rounded', 'clipRoundedRect'],
  advicedChildrenCanHaveAtLeastAChild: [],
  displayName: NodeType.name(_globalType),
  type: _globalType,
  category: NodeCategories.advanced,
  maxChildren: 1,
  canHave: ChildrenEnum.child,
  addChildLabels: [],
  gestures: [],
  permissions: [],
  packages: [],
);

/// Set of funcs of Center node
class ClipRRectBody extends NodeBody {
  @override
  // ignore: overridden_fields
  Map<String, dynamic> attributes = <String, dynamic>{
    DBKeys.borderRadius: FBorderRadius(),
  };

  @override
  List<ControlModel> get controls => [
        ControlObject(
          type: ControlType.borderRadius,
          key: DBKeys.borderRadius,
          value: attributes[DBKeys.borderRadius],
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
      WClipRRect(
        ValueKey(
          '''
            ${node.nid}
            $loop
            ${child ?? children}
            ${(attributes[DBKeys.borderRadius] as FBorderRadius).toJson()}, 
            ''',
        ),
        node: node,
        child: child,
        borderRadius: attributes[DBKeys.borderRadius] as FBorderRadius,
        loop: loop,
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
      ClipRRectCodeTemplate.toCode(context, this, child);
}
