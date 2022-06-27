// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:teta_core/src/models/dataset.dart';
import 'package:teta_core/src/models/variable.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/templates/bouncing_widget.dart';
import 'package:teta_widgets/src/elements/controls/control_model.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/controls/type.dart';
import 'package:teta_widgets/src/elements/features/action.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/index.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_widgets/src/elements/intrinsic_states/class.dart';
import 'package:teta_widgets/src/elements/nodes/categories.dart';
import 'package:teta_widgets/src/elements/nodes/children_enum.dart';
import 'package:teta_widgets/src/elements/nodes/enum.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';
import 'package:teta_widgets/src/elements/widgets/bouncing_widget.dart';

const _globalType = NType.bouncingWidget;

/// Instrict State of Bouncing Widget
final bouncingWidgetIntrinsicStates = IntrinsicStates(
  nodeIcon: Assets.wIcons.bouncing_widget,
  nodeVideo: 'c1xLMaTUWCY',
  nodeDescription: '''''',
  advicedChildren: [
    NodeType.name(NType.column),
    NodeType.name(NType.container),
    NodeType.name(NType.row),
  ],
  blockedTypes: [],
  synonymous: ['bouncing widget', 'animation', 'hover', 'on tap'],
  advicedChildrenCanHaveAtLeastAChild: [],
  displayName: NodeType.name(_globalType),
  type: _globalType,
  category: NodeCategories.animated,
  maxChildren: 1,
  canHave: ChildrenEnum.child,
  addChildLabels: [],
  gestures: [
    ActionGesture.onTap,
  ],
  permissions: [],
  packages: ['bouncing_widget'],
);

/// Set of funcs to use Container widget
class BouncingWidgetBody extends NodeBody {
  @override
  // ignore: overridden_fields
  Map<String, dynamic> attributes = <String, dynamic>{
    DBKeys.action: FAction(),
    DBKeys.value: FTextTypeInput(value: '100'),
    DBKeys.valueOfCondition: FTextTypeInput(value: '1.5'),
  };

  @override
  List<ControlModel> get controls => [
        ControlObject(
          type: ControlType.action,
          key: DBKeys.action,
          value: attributes[DBKeys.action],
        ),
        ControlObject(
          title: 'Duration',
          type: ControlType.value,
          key: DBKeys.value,
          value: attributes[DBKeys.value],
        ),
        ControlObject(
          title: 'Scale Factor',
          type: ControlType.value,
          key: DBKeys.valueOfCondition,
          value: attributes[DBKeys.valueOfCondition],
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
  }) {
    return WBouncingWidget(
      ValueKey(
        '''
      ${node.nid}
      $loop
            ${child ?? children}
      ${(attributes[DBKeys.action] as FAction).toJson()}
      ${(attributes[DBKeys.value] as FTextTypeInput).toJson()}
      ${(attributes[DBKeys.valueOfCondition] as FTextTypeInput).toJson()}
      ''',
      ),
      node: node,
      child: child,
      action: attributes[DBKeys.action] as FAction,
      value: attributes[DBKeys.value] as FTextTypeInput,
      valueOfCondition: attributes[DBKeys.valueOfCondition] as FTextTypeInput,
      forPlay: forPlay,
      loop: loop,
      params: params,
      states: states,
      dataset: dataset,
    );
  }

  @override
  String toCode(
    final BuildContext context,
    final CNode node,
    final CNode? child,
    final List<CNode>? children,
    final int pageId,
    final int? loop,
  ) =>
      bouncingWidgetCodeTemplate(pageId, context, this, node, child, loop ?? 0);
}
