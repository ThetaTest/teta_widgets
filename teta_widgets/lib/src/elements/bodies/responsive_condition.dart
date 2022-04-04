// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:teta_core/src/models/dataset.dart';
import 'package:teta_core/src/models/variable.dart';
// Project imports:
import 'package:teta_widgets/src/elements/controls/control_model.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/intrinsic_states/class.dart';
import 'package:teta_widgets/src/elements/nodes/categories.dart';
import 'package:teta_widgets/src/elements/nodes/children_enum.dart';
import 'package:teta_widgets/src/elements/nodes/enum.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';
import 'package:teta_widgets/src/elements/widgets/responsive_condition.dart';

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
  category: NodeCategories.responsive,
  maxChildren: 1,
  canHave: ChildrenEnum.child,
  addChildLabels: [],
  gestures: [],
  permissions:[],
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
    required final List<VariableObject> params,
    required final List<VariableObject> states,
    required final List<DatasetObject> dataset,
    required final bool forPlay,
    required final CNode node,
    final int? loop,
    final CNode? child,
    final List<CNode>? children,
  }) =>
      WResponsiveCondition(
        ValueKey(
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
    final BuildContext context,
    final CNode node,
    final CNode? child,
    final List<CNode>? children,
    final int pageId,
    final int? loop,
  ) {
    return '''
    ''';
  }
}
