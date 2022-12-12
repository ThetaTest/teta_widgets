// Flutter imports:
// ignore_for_file: lines_longer_than_80_chars

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:teta_core/src/models/variable.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
import 'package:teta_widgets/src/elements/code/snippets.dart';
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
import 'package:teta_widgets/src/elements/nodes/suggestion.dart';
import 'package:teta_widgets/src/elements/widgets/component.dart';

const _globalType = NType.component;

/// Instrict State of Component
final componentIntrinsicStates = IntrinsicStates(
  nodeIcon: Assets.wIcons.component,
  nodeVideo: 'EgtPleVwxBQ', //'EgtPleVwxBQ', //Check
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
  permissions: [],
  packages: [],
  suggestionsTitle: 'Why use Component in Teta?',
  suggestions: [
    const Suggestion(
      title: 'Why use Component in Teta?',
      description: 'Test',
      linkToOpen:
          'https://docs.teta.so/teta-docs/widget/advanced-widgets/component',
    )
  ],
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
          valueType: VariableType.string,
        ),
      ];

  @override
  Widget toWidget({
    required final TetaWidgetState state,
    final CNode? child,
    final List<CNode>? children,
  }) {
    return WComponent(
      ValueKey(
        '''
        ${state.toKey}
        ${child ?? children}
        ${attributes[DBKeys.componentName] as String} 
        ${attributes[DBKeys.paramsToSend] as Map<String, dynamic>}
        ''',
      ),
      state: state,
      child: child,
      componentName: attributes[DBKeys.componentName] as String,
      paramsToSend: attributes[DBKeys.paramsToSend] as Map<String, dynamic>,
    );
  }

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
        componentCodeTemplate(context, this, children ?? [], pageId),
        loop ?? 0,
      );
}
