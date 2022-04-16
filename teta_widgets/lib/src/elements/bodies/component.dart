// Flutter imports:
// ignore_for_file: lines_longer_than_80_chars

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:teta_core/src/models/dataset.dart';
import 'package:teta_core/src/models/variable.dart';

// Project imports:
import 'package:teta_widgets/src/elements/code/templates/component.dart';
import 'package:teta_widgets/src/elements/controls/control_model.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/controls/type.dart';
import 'package:teta_widgets/src/elements/intrinsic_states/class.dart';
import 'package:teta_widgets/src/elements/nodes/categories.dart';
import 'package:teta_widgets/src/elements/nodes/children_enum.dart';
import 'package:teta_widgets/src/elements/nodes/enum.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';
import 'package:teta_widgets/src/elements/widgets/component.dart';

const _globalType = NType.component;

/// Instrict State of Component
final componentIntrinsicStates = IntrinsicStates(
  nodeIcon: Assets.wIcons.component,
  nodeVideo:'EgtPleVwxBQ', //'EgtPleVwxBQ', //Check
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
  permissions:[],
);

/// Set of funcs to use a Component widget
class ComponentBody extends NodeBody {
  /// Returns the body of Component node
  ComponentBody({final String? name}) {
    attributes[DBKeys.componentName] = name ?? 'Component';
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
    required final List<VariableObject> params,
    required final List<VariableObject> states,
    required final List<DatasetObject> dataset,
    required final bool forPlay,
    required final CNode node,
    final int? loop,
    final CNode? child,
    final List<CNode>? children,
  }) {
    return WComponent(
      ValueKey(
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
    final BuildContext context,
    final CNode node,
    final CNode? child,
    final List<CNode>? children,
    final int pageId,
    final int? loop,
  ) =>
      componentCodeTemplate(context, this, children ?? [], pageId);
}
