// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:theta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:theta_widgets/src/elements/code/templates/page_view.dart';
import 'package:theta_widgets/src/elements/controls/control_model.dart';
import 'package:theta_widgets/src/elements/controls/key_constants.dart';
import 'package:theta_widgets/src/elements/features/action.dart';
import 'package:theta_widgets/src/elements/features/actions/enums/index.dart';
import 'package:theta_widgets/src/elements/intrinsic_states/class.dart';
import '../../../../../../teta_open_classes/lib/src/nodes/categories.dart';
import '../../../../../../teta_open_classes/lib/src/nodes/children_enum.dart';
import '../../../../../../teta_open_classes/lib/src/nodes/enum.dart';
import '../../../../../../teta_open_classes/lib/src/nodes/node.dart';
import '../../../../../../teta_open_classes/lib/src/nodes/node_body.dart';
import '../../../../../../teta_open_classes/lib/src/nodes/suggestion.dart';
import 'package:theta_widgets/src/elements/widgets/page_view.dart';

const _globalType = NType.pageView;

/// Intrinsic States of PageView
final pageViewIntrinsicStates = IntrinsicStates(
  nodeIcon: Assets.wIcons.pageView,
  nodeVideo: null,
  nodeDescription: null,
  advicedChildren: [
    NodeType.name(NType.container),
    NodeType.name(NType.column),
    NodeType.name(NType.stack),
  ],
  blockedTypes: [],
  synonymous: ['pageview', 'slider', 'carousel'],
  advicedChildrenCanHaveAtLeastAChild: [],
  displayName: NodeType.name(_globalType),
  type: _globalType,
  category: NodeCategories.layout,
  maxChildren: null,
  canHave: ChildrenEnum.children,
  addChildLabels: [],
  gestures: [
    ActionGesture.onChange,
  ],
  permissions: [],
  packages: [],
  suggestionsTitle: 'Why use PageView in Teta?',
  suggestions: [
    const Suggestion(
      title: 'Why use PageView in Teta?',
      description: 'Test',
      linkToOpen: 'https://docs.teta.so/teta-docs/widget/list-widgets/pageview',
    )
  ],
);

/// PageView's body
class PageViewBody extends NodeBody {
  @override
  // ignore: overridden_fields
  Map<String, dynamic> attributes = <String, dynamic>{
    DBKeys.isVertical: true,
    DBKeys.action: NodeGestureActions.empty(),
  };

  @override
  List<ControlModel> get controls => [
        FlagControlObject(
          title: 'Is Vertical',
          key: DBKeys.isVertical,
          value: attributes[DBKeys.isVertical],
          description: '',
        ),
      ];

  @override
  Widget toWidget({
    required final TetaWidgetState state,
    final CNode? child,
    final List<CNode>? children,
  }) =>
      WPageView(
        ValueKey(
          '''
          ${state.toKey}
          ${child ?? children}
          ${attributes[DBKeys.isVertical] as bool}
          ${(attributes[DBKeys.action] as NodeGestureActions).toJson()}
          ''',
        ),
        state: state,
        children: children ?? [],
        flagValue: false,
        isVertical: attributes[DBKeys.isVertical] as bool,
        action: attributes[DBKeys.action] as NodeGestureActions,
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
      PageViewCodeTemplate.toCode(
        context,
        pageId,
        this,
        node,
        children ?? [],
        loop,
      );
}
