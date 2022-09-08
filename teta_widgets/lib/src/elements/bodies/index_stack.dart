// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:teta_core/src/models/dataset.dart';
import 'package:teta_core/src/models/variable.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/templates/indexed_stack.dart';
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
import 'package:teta_widgets/src/elements/widgets/index_stack.dart';

const _globalType = NType.indexedStack;

/// Intrinsic States of IndexedStack
final indexedStackIntrinsicStates = IntrinsicStates(
  nodeIcon: Assets.wIcons.indexStack,
  nodeVideo: null,
  nodeDescription: 'Layout a list of child widgets in the vertical direction.',
  advicedChildren: [
    NodeType.name(NType.container),
    NodeType.name(NType.expanded),
    NodeType.name(NType.gestureDetector),
  ],
  blockedTypes: [],
  synonymous: ['indexed stack', 'list', 'vertical list'],
  advicedChildrenCanHaveAtLeastAChild: [],
  displayName: NodeType.name(_globalType),
  type: _globalType,
  category: NodeCategories.logic,
  maxChildren: null,
  canHave: ChildrenEnum.children,
  addChildLabels: [],
  gestures: [],
  permissions: [],
  packages: [],
);

/// Set of funcs to use Column widget
class IndexedStackBody extends NodeBody {
  @override
  // ignore: overridden_fields
  Map<String, dynamic> attributes = <String, dynamic>{
    DBKeys.value: FTextTypeInput(value: '0'),
  };

  @override
  List<ControlModel> get controls => [
        ControlObject(
          type: ControlType.value,
          key: DBKeys.value,
          value: attributes[DBKeys.value],
          description: 'Use only integer numbers as an input',
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
      WIndexedStack(
        ValueKey(
          '''
      ${node.nid}
      $loop
            ${child ?? children}
      ${(attributes[DBKeys.value] as FTextTypeInput).toJson()}
      ''',
        ),
        index: attributes[DBKeys.value] as FTextTypeInput,
        node: node,
        children: children ?? [],
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
      IndexedStackCodeTemplate.toCode(context, this, children ?? [], loop);
}
