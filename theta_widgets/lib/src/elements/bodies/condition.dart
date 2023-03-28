// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:theta_models/src/models/variable.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
import 'package:teta_widgets/src/elements/code/snippets.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/templates/condition.dart';
import 'package:teta_widgets/src/elements/controls/control_model.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/controls/type.dart';
import 'package:teta_widgets/src/elements/features/condition_type.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_widgets/src/elements/intrinsic_states/class.dart';
import '../../../../../../teta_open_classes/lib/src/nodes/categories.dart';
import '../../../../../../teta_open_classes/lib/src/nodes/children_enum.dart';
import '../../../../../../teta_open_classes/lib/src/nodes/enum.dart';
import '../../../../../../teta_open_classes/lib/src/nodes/node.dart';
import '../../../../../../teta_open_classes/lib/src/nodes/node_body.dart';
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
  category: NodeCategories.visibility,
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
    DBKeys.conditionType: FConditionType(),
  };

  @override
  List<ControlModel> get controls => [
        ControlObject(
          type: ControlType.value,
          key: DBKeys.value,
          value: attributes[DBKeys.value],
          title: 'Value 1',
          valueType: VariableType.dynamic,
          description: 'First value to compare',
        ),
        ControlObject(
            type: ControlType.condition,
            key: DBKeys.conditionType,
            value: attributes[DBKeys.conditionType],
            title: 'Condition type',
            valueType: VariableType.dynamic,
            description:
                'Choose between Is Equal, Is Greater Than, Is Less Than'),
        ControlObject(
          type: ControlType.value,
          key: DBKeys.valueOfCondition,
          value: attributes[DBKeys.valueOfCondition],
          valueType: VariableType.dynamic,
          title: 'Value 2',
          description: 'Second value to compare',
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
            ${state.toKey}
            ${child ?? children}
            ${(attributes[DBKeys.value] as FTextTypeInput).toJson()}, 
            ${(attributes[DBKeys.valueOfCondition] as FTextTypeInput).toJson()}, 
            ''',
        ),
        state: state,
        children: children ?? [],
        value: attributes[DBKeys.value] as FTextTypeInput,
        valueOfCond: attributes[DBKeys.valueOfCondition] as FTextTypeInput,
        conditionType: attributes[DBKeys.conditionType] as FConditionType,
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
