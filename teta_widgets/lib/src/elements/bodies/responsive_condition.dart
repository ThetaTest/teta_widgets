// Flutter imports:
import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:teta_core/src/models/dataset.dart';
import 'package:teta_core/src/models/variable.dart';
import 'package:teta_elements/src/elements/controls/control_model.dart';
import 'package:teta_elements/src/elements/controls/key_constants.dart';
import 'package:teta_elements/src/elements/intrinsic_states/class.dart';
import 'package:teta_elements/src/elements/nodes/categories.dart';
import 'package:teta_elements/src/elements/nodes/children_enum.dart';
import 'package:teta_elements/src/elements/nodes/enum.dart';
import 'package:teta_elements/src/elements/nodes/node.dart';
import 'package:teta_elements/src/elements/nodes/node_body.dart';
import 'package:teta_widgets/src/widgets/responsive_condition.dart';

const _globalType = NType.responsiveCondition;

/// IS
final responsiveIntrinsicStates = IntrinsicStates(
  nodeIcon: Assets.wIcons.ifCondition,
  nodeVideo: null,
  nodeDescription: null,
  advicedChildren: [
    NodeType.name(NType.container),
    NodeType.name(NType.column),
    NodeType.name(NType.row),
  ],
  blockedTypes: [],
  synonymous: [
    'responsive condition',
    'mobile',
    'desktop',
    'tablet',
    'only',
    'device'
  ],
  advicedChildrenCanHaveAtLeastAChild: [],
  displayName: NodeType.name(_globalType),
  type: _globalType,
  category: NodeCategories.logic,
  maxChildren: 1,
  canHave: ChildrenEnum.child,
  addChildLabels: [],
  gestures: [],
);

/// Body
class ResponsiveBody extends NodeBody {
  @override
  // ignore: overridden_fields
  Map<String, dynamic> attributes = <String, dynamic>{
    DBKeys.visibleOnDesktop: true,
    DBKeys.visibleOnMobile: true,
    DBKeys.visibleOnTablet: true,
  };

  @override
  List<ControlModel> get controls => [
        FlagControlObject(
          title: 'Mobile',
          key: DBKeys.visibleOnMobile,
          value: attributes[DBKeys.visibleOnMobile],
          description: 'Is the child visible on mobile?',
        ),
        FlagControlObject(
          title: 'Tablet',
          key: DBKeys.visibleOnTablet,
          value: attributes[DBKeys.visibleOnTablet],
          description: 'Is the child visible on tablet?',
        ),
        FlagControlObject(
          title: 'Desktop',
          key: DBKeys.visibleOnDesktop,
          value: attributes[DBKeys.visibleOnDesktop],
          description: 'Is the child visible on desktop?',
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
      WResponsiveCondition(
        key: ValueKey(
          '''
            ${node.nid}
            $loop
            ${child ?? children}
            ${attributes[DBKeys.visibleOnDesktop] as bool}
            ${attributes[DBKeys.visibleOnMobile] as bool}
            ${attributes[DBKeys.visibleOnTablet] as bool}
            ''',
        ),
        node: node,
        child: child,
        visibleOnDesktop: attributes[DBKeys.visibleOnDesktop] as bool,
        visibleOnMobile: attributes[DBKeys.visibleOnMobile] as bool,
        visibleOnTablet: attributes[DBKeys.visibleOnTablet] as bool,
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
  ) {
    return '''
    ''';
  }
}
