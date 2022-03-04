// Flutter imports:
// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:teta_core/src/models/dataset.dart';
import 'package:teta_core/src/models/variable.dart';
import 'package:teta_elements/src/elements/code/templates/component.dart';
import 'package:teta_elements/src/elements/controls/control_model.dart';
import 'package:teta_elements/src/elements/controls/key_constants.dart';
import 'package:teta_elements/src/elements/controls/type.dart';
import 'package:teta_elements/src/elements/intrinsic_states/class.dart';
import 'package:teta_elements/src/elements/nodes/categories.dart';
import 'package:teta_elements/src/elements/nodes/children_enum.dart';
import 'package:teta_elements/src/elements/nodes/enum.dart';
import 'package:teta_elements/src/elements/nodes/node.dart';
import 'package:teta_elements/src/elements/nodes/node_body.dart';
import 'package:teta_widgets/src/widgets/component.dart';

const _globalType = NType.component;

/// Instrict State of Component
final componentIntrinsicStates = IntrinsicStates(
  nodeIcon: Assets.wIcons.component,
  nodeVideo: 'EgtPleVwxBQ', //Check
  nodeDescription: null,
  advicedChildren: [],
  blockedTypes: [],
  synonymous: ['component', 'symbol', 'widget'],
  advicedChildrenCanHaveAtLeastAChild: [],
  displayName: NodeType.name(_globalType),
  type: _globalType,
  category: NodeCategories.advanced,
  maxChildren: 0,
  canHave: ChildrenEnum.none,
  addChildLabels: [],
  gestures: [],
);

/// Set of funcs to use a Component widget
class ComponentBody extends NodeBody {
  /// Returns the body of Component node
  ComponentBody({String? name}) {
    attributes[DBKeys.componentName] = name;
  }

  @override
  // ignore: overridden_fields
  Map<String, dynamic> attributes = <String, dynamic>{
    DBKeys.componentName: '',
    DBKeys.paramsToSend: <String, dynamic>{},
  };

  @override
  List<ControlModel> get controls => [
        ControlObject(
          type: ControlType.component,
          key: DBKeys.componentName,
          value: attributes[DBKeys.componentName],
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
  }) {
    return WComponent(
      key: ValueKey(
        '''
          ${node.nid} 
          $loop
            ${child ?? children}
          ${attributes[DBKeys.componentName] as String} 
          ${attributes[DBKeys.paramsToSend] as Map<String, dynamic>}
          ''',
      ),
      node: node,
      child: child,
      forPlay: forPlay,
      componentName: attributes[DBKeys.componentName] as String,
      paramsToSend: attributes[DBKeys.paramsToSend] as Map<String, dynamic>,
      loop: loop,
      params: params,
      states: states,
      dataset: dataset,
    );
  }

  @override
  String toCode(
    BuildContext context,
    CNode node,
    CNode? child,
    List<CNode>? children,
    int pageId,
    int? loop,
  ) =>
      componentCodeTemplate(context, this, children ?? []);
}
