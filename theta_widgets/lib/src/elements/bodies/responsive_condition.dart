// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/code/templates/responsive_condition.dart';
// Project imports:
import 'package:teta_widgets/src/elements/controls/control_model.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/intrinsic_states/class.dart';
import '../../../../../../teta_open_classes/lib/src/nodes/categories.dart';
import '../../../../../../teta_open_classes/lib/src/nodes/children_enum.dart';
import '../../../../../../teta_open_classes/lib/src/nodes/enum.dart';
import '../../../../../../teta_open_classes/lib/src/nodes/node.dart';
import '../../../../../../teta_open_classes/lib/src/nodes/node_body.dart';
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
  category: NodeCategories.visibility,
  maxChildren: 1,
  canHave: ChildrenEnum.child,
  addChildLabels: [],
  gestures: [],
  permissions: [],
  packages: [],
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
    required final TetaWidgetState state,
    final CNode? child,
    final List<CNode>? children,
  }) =>
      WResponsiveCondition(
        ValueKey(
          '''
            ${state.toKey}
            ${child ?? children}
            ${attributes[DBKeys.visibleOnMobile] as bool}
            ${attributes[DBKeys.visibleOnTablet] as bool}
            ${attributes[DBKeys.visibleOnDesktop] as bool}
            ''',
        ),
        state: state,
        child: child,
        visibleOnDesktop: attributes[DBKeys.visibleOnDesktop] as bool,
        visibleOnMobile: attributes[DBKeys.visibleOnMobile] as bool,
        visibleOnTablet: attributes[DBKeys.visibleOnTablet] as bool,
      );

  @override
  Future<String> toCode(
    final BuildContext context,
    final CNode node,
    final CNode? child,
    final List<CNode>? children,
    final int pageId,
    final int? loop,
  ) {
    return CS.defaultWidgets(
      context,
      node,
      pageId,
      ResponsiveConditionCodeTemplate.toCode(context, this, child),
      loop ?? 0,
    );
  }
}
