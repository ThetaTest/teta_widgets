// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
import 'package:teta_widgets/src/elements/code/snippets.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/templates/wrap.dart';
import 'package:teta_widgets/src/elements/intrinsic_states/class.dart';
import '../../../../../../teta_open_classes/lib/src/nodes/categories.dart';
import '../../../../../../teta_open_classes/lib/src/nodes/children_enum.dart';
import '../../../../../../teta_open_classes/lib/src/nodes/enum.dart';
import '../../../../../../teta_open_classes/lib/src/nodes/node.dart';
import '../../../../../../teta_open_classes/lib/src/nodes/node_body.dart';
import '../../../../../../teta_open_classes/lib/src/nodes/suggestion.dart';
import 'package:teta_widgets/src/elements/widgets/wrap.dart';

/// GlobalType for Wrap widget
const _globalType = NType.wrap;

/// IntrinsicStates for Wrap widget
final wrapIntrinsicStates = IntrinsicStates(
  nodeIcon: Assets.wIcons.wrap,
  nodeVideo: null,
  nodeDescription: null,
  advicedChildren: [
    NodeType.name(NType.container),
    NodeType.name(NType.image),
    NodeType.name(NType.text),
  ],
  blockedTypes: [],
  synonymous: ['wrap', 'column', 'list', 'vertical list'],
  advicedChildrenCanHaveAtLeastAChild: [],
  displayName: NodeType.name(_globalType),
  type: _globalType,
  category: NodeCategories.layout,
  maxChildren: null,
  canHave: ChildrenEnum.children,
  addChildLabels: [],
  gestures: [],
  permissions: [],
  packages: [],
  suggestionsTitle: 'Why use Wrap in Teta?',
  suggestions: [
    const Suggestion(
      title: 'Why use Wrap in Teta?',
      description: 'Test',
      linkToOpen: 'https://docs.teta.so/teta-docs/widget/list-widgets/wrap',
    )
  ],
);

/// Body for Wrap widget
/// ```dart
/// Wrap({
///   Key? key,
///   Axis direction,
///   WrapAlignment alignment,
///   double spacing,
///   WrapAlignment runAlignment,
///   double runSpacing,
///   WrapCrossAlignment crossAxisAlignment,
///   TextDirection? textDirection,
///   VerticalDirection verticalDirection,
///   Clip clipBehavior,
///   List<Widget>
///   children = const <Widget>[]
/// })
/// ```
class WrapBody extends NodeBody {
  /// Constructor
  WrapBody();

  @override
  Widget toWidget({
    required final TetaWidgetState state,
    final CNode? child,
    final List<CNode>? children,
  }) =>
      WWrap(
        ValueKey(
          '''
            ${state.toKey}
            ${child ?? children}
            ${state.params}
            ${state.states}
            ${state.dataset}
            ''',
        ),
        state: state,
        children: children ?? [],
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
        WrapCodeTemplate.toCode(context, this, children ?? []),
        loop ?? 0,
      );
}
