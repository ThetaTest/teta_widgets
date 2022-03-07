// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:teta_core/src/models/dataset.dart';
import 'package:teta_core/src/models/variable.dart';

// Project imports:
import 'package:teta_widgets/src/elements/code/templates/constrained_box.dart';
import 'package:teta_widgets/src/elements/controls/control_model.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/controls/type.dart';
import 'package:teta_widgets/src/elements/features/sizes.dart';
import 'package:teta_widgets/src/elements/intrinsic_states/class.dart';
import 'package:teta_widgets/src/elements/nodes/categories.dart';
import 'package:teta_widgets/src/elements/nodes/children_enum.dart';
import 'package:teta_widgets/src/elements/nodes/enum.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';
import 'package:teta_widgets/src/elements/widgets/constrained_box.dart';

const _globalType = NType.constrainedBox;

/// Intrinsic States of Center node type
final constrainedBoxIntrinsicStates = IntrinsicStates(
  nodeIcon: Assets.wIcons.sizedBox,
  nodeVideo: null,
  nodeDescription: 'A widget that centers its child within itself.',
  advicedChildren: [
    NodeType.name(NType.column),
    NodeType.name(NType.row),
    NodeType.name(NType.image),
  ],
  blockedTypes: [],
  synonymous: ['constrainedbox', 'overflowbox'],
  advicedChildrenCanHaveAtLeastAChild: [],
  displayName: NodeType.name(_globalType),
  type: _globalType,
  category: NodeCategories.advanced,
  maxChildren: 1,
  canHave: ChildrenEnum.child,
  addChildLabels: [],
  gestures: [],
);

/// Set of funcs of Center node
class ConstrainedBoxBody extends NodeBody {
  @override
  // ignore: overridden_fields
  Map<String, dynamic> attributes = <String, dynamic>{
    DBKeys.minWidth: FSize(size: '0'),
    DBKeys.maxWidth: FSize(size: 'max'),
    DBKeys.minHeight: FSize(size: '0'),
    DBKeys.maxHeight: FSize(size: '250'),
  };

  @override
  List<ControlModel> get controls => [
        SizeControlObject(
          type: ControlType.size,
          key: DBKeys.minWidth,
          title: 'Min Width',
          isWidth: true,
          value: attributes[DBKeys.minWidth] as FSize,
        ),
        SizeControlObject(
          type: ControlType.size,
          key: DBKeys.maxWidth,
          title: 'Max Width',
          isWidth: false,
          value: attributes[DBKeys.maxWidth] as FSize,
        ),
        SizeControlObject(
          type: ControlType.size,
          key: DBKeys.minHeight,
          title: 'Min Height',
          isWidth: true,
          value: attributes[DBKeys.minHeight] as FSize,
        ),
        SizeControlObject(
          type: ControlType.size,
          key: DBKeys.maxHeight,
          title: 'Max Height',
          isWidth: false,
          value: attributes[DBKeys.maxHeight] as FSize,
        ),
      ];

  @override
  Widget toWidget({
    required List<VariableObject> params,
    required List<VariableObject> states,
    required List<DatasetObject> dataset,
    required bool forPlay,
    required CNode node,
    int? loop,
    CNode? child,
    List<CNode>? children,
  }) =>
      WConstrainedBox(
        ValueKey(
          '''
            ${node.nid}
            $loop
            ${child ?? children}
            ${(attributes[DBKeys.minWidth] as FSize).toJson()}, 
            ${(attributes[DBKeys.minHeight] as FSize).toJson()}, 
            ${(attributes[DBKeys.maxWidth] as FSize).toJson()}, 
            ${(attributes[DBKeys.maxHeight] as FSize).toJson()}, 
            ''',
        ),
        node: node,
        child: child,
        loop: loop,
        forPlay: forPlay,
        minWidth: attributes[DBKeys.minWidth] as FSize,
        minHeight: attributes[DBKeys.minHeight] as FSize,
        maxWidth: attributes[DBKeys.maxWidth] as FSize,
        maxHeight: attributes[DBKeys.maxHeight] as FSize,
        params: params,
        states: states,
        dataset: dataset,
      );

  @override
  String toCode(
    BuildContext context,
    CNode node,
    CNode? child,
    List<CNode>? children,
    int pageId,
    int? loop,
  ) =>
      constrainedBoxCodeTemplate(context, this, child, loop);
}
