// Flutter imports:
import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:teta_core/src/models/dataset.dart';
import 'package:teta_core/src/models/variable.dart';
import 'package:teta_elements/src/elements/code/templates/row.dart';
import 'package:teta_elements/src/elements/controls/control_model.dart';
import 'package:teta_elements/src/elements/controls/key_constants.dart';
import 'package:teta_elements/src/elements/controls/type.dart';
import 'package:teta_elements/src/elements/features/cross_axis_alignment.dart';
import 'package:teta_elements/src/elements/features/main_axis_alignment.dart';
import 'package:teta_elements/src/elements/features/main_axis_size.dart';
import 'package:teta_elements/src/elements/intrinsic_states/class.dart';
import 'package:teta_elements/src/elements/nodes/categories.dart';
import 'package:teta_elements/src/elements/nodes/children_enum.dart';
import 'package:teta_elements/src/elements/nodes/enum.dart';
import 'package:teta_elements/src/elements/nodes/node.dart';
import 'package:teta_elements/src/elements/nodes/node_body.dart';
import 'package:teta_widgets/src/widgets/row.dart';

const _globalType = NType.row;

/// IS
final rowIntrinsicStates = IntrinsicStates(
  nodeIcon: Assets.wIcons.row,
  nodeVideo: null,
  nodeDescription:
      'Layout a list of child widgets in the horizontal direction.',
  advicedChildren: [
    NodeType.name(NType.text),
    NodeType.name(NType.icon),
    NodeType.name(NType.gestureDetector),
  ],
  blockedTypes: [],
  synonymous: ['row', 'horizontal list'],
  advicedChildrenCanHaveAtLeastAChild: [],
  displayName: NodeType.name(_globalType),
  type: _globalType,
  category: NodeCategories.basic,
  maxChildren: null,
  canHave: ChildrenEnum.children,
  addChildLabels: [],
  gestures: [],
);

/// Body
class RowBody extends NodeBody {
  @override
  // ignore: overridden_fields
  Map<String, dynamic> attributes = <String, dynamic>{
    DBKeys.mainAxisAlignment: FMainAxisAlignment(),
    DBKeys.crossAxisAlignment: FCrossAxisAlignment(),
    DBKeys.mainAxisSize: FMainAxisSize(),
  };

  @override
  List<ControlModel> get controls => [
        ControlObject(
          type: ControlType.mainAxisAlignment,
          key: DBKeys.mainAxisAlignment,
          value: attributes[DBKeys.mainAxisAlignment],
        ),
        ControlObject(
          type: ControlType.crossAxisAlignment,
          key: DBKeys.crossAxisAlignment,
          value: attributes[DBKeys.crossAxisAlignment],
        ),
      ];

  @override
  Widget toWidget({
    required List<VariableObject> params,
    required List<VariableObject> states,
    required List<DatasetObject> dataset,
    int? loop,
    required bool forPlay,
    required CNode node,
    CNode? child,
    List<CNode>? children,
  }) =>
      WRow(
        key: ValueKey(
          '''
            ${node.nid}
            $loop
            ${child ?? children}
            ${(attributes[DBKeys.mainAxisAlignment] as FMainAxisAlignment).toJson()}
            ${(attributes[DBKeys.crossAxisAlignment] as FCrossAxisAlignment).toJson()}
            ''',
        ),
        node: node,
        children: children ?? [],
        mainAxisAlignment:
            attributes[DBKeys.mainAxisAlignment] as FMainAxisAlignment,
        crossAxisAlignment:
            attributes[DBKeys.crossAxisAlignment] as FCrossAxisAlignment,
        forPlay: forPlay,
        loop: loop,
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
      rowCodeTemplate(context, this, children ?? []);
}
