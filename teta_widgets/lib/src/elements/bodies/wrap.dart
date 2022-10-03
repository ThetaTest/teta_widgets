// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:teta_core/src/models/dataset.dart';
import 'package:teta_core/src/models/variable.dart';
import 'package:teta_widgets/src/elements/code/snippets.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/templates/wrap.dart';
import 'package:teta_widgets/src/elements/intrinsic_states/class.dart';
import 'package:teta_widgets/src/elements/nodes/categories.dart';
import 'package:teta_widgets/src/elements/nodes/children_enum.dart';
import 'package:teta_widgets/src/elements/nodes/enum.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';
import 'package:teta_widgets/src/elements/nodes/suggestion.dart';
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
  category: NodeCategories.list,
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
    required final List<VariableObject> params,
    required final List<VariableObject> states,
    required final List<DatasetObject> dataset,
    required final bool forPlay,
    required final CNode node,
    final int? loop,
    final CNode? child,
    final List<CNode>? children,
  }) =>
      WWrap(
        ValueKey(
          '''
            ${node.nid}
            $loop
            ${child ?? children}
            ''',
        ),
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
      CS.defaultWidgets(
        context,
        node,
        pageId,
        WrapCodeTemplate.toCode(context, this, children ?? []),
        loop ?? 0,
      );
}
