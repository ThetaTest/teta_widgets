// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:teta_core/src/models/variable.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
import 'package:teta_widgets/src/elements/code/snippets.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/templates/condition.dart';
import 'package:teta_widgets/src/elements/controls/control_model.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/controls/type.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_widgets/src/elements/intrinsic_states/class.dart';
import 'package:teta_widgets/src/elements/nodes/categories.dart';
import 'package:teta_widgets/src/elements/nodes/children_enum.dart';
import 'package:teta_widgets/src/elements/nodes/enum.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';
import 'package:teta_widgets/src/elements/widgets/condition.dart';

const _globalType = NType.condition;

/// Instrict State of Condition
final conditionIntrinsicStates = IntrinsicStates(
  nodeIcon: Assets.wIcons.ifCondition,
  nodeVideo: null,
  nodeDescription: null,
  advicedChildren: [
    NodeType.name(NType.column),
    NodeType.name(NType.container),
    NodeType.name(NType.row),
  ],
  blockedTypes: [],
  synonymous: [
    'condition',
    'logic',
    'if',
    'else',
  ],
  advicedChildrenCanHaveAtLeastAChild: [],
  displayName: NodeType.name(_globalType),
  type: _globalType,
  category: NodeCategories.logic,
  maxChildren: 2,
  canHave: ChildrenEnum.children,
  addChildLabels: ['Add Widget If True', 'Add Widget If False'],
  gestures: [],
  permissions: [],
  packages: [],
);

/// Set of funcs to use Condition widget
class ConditionBody extends NodeBody {
  @override
  // ignore: overridden_fields
  Map<String, dynamic> attributes = <String, dynamic>{
    DBKeys.value: FTextTypeInput(),
    DBKeys.valueOfCondition: FTextTypeInput(),
  };

  @override
  List<ControlModel> get controls => [
        ControlObject(
          type: ControlType.value,
          key: DBKeys.value,
          value: attributes[DBKeys.value],
          title: 'Condition',
          valueType: VariableType.dynamic,
        ),
        ControlObject(
          type: ControlType.value,
          key: DBKeys.valueOfCondition,
          value: attributes[DBKeys.valueOfCondition],
          valueType: VariableType.dynamic,
        ),
      ];

  @override
  Widget toWidget({
    required final TetaWidgetState state,
    final CNode? child,
    final List<CNode>? children,
  }) =>
      WCondition(
        ValueKey(
          '''
            ${state.node.nid}
            ${state.loop}
            ${child ?? children}
            ${(attributes[DBKeys.value] as FTextTypeInput).toJson()}, 
            ${(attributes[DBKeys.valueOfCondition] as FTextTypeInput).toJson()}, 
            ''',
        ),
        state: state,
        children: children ?? [],
        value: attributes[DBKeys.value] as FTextTypeInput,
        valueOfCond: attributes[DBKeys.valueOfCondition] as FTextTypeInput,
        conditionType: ConditionType.equal,
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
        ConditionCodeTemplate.toCode(context, this, children ?? [], loop),
        loop ?? 0,
      );
}
