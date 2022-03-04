// Flutter imports:
import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:teta_core/src/models/dataset.dart';
import 'package:teta_core/src/models/variable.dart';
import 'package:teta_widgets/src/elements/code/templates/wrap.dart';
import 'package:teta_widgets/src/elements/intrinsic_states/class.dart';
import 'package:teta_widgets/src/elements/nodes/categories.dart';
import 'package:teta_widgets/src/elements/nodes/children_enum.dart';
import 'package:teta_widgets/src/elements/nodes/enum.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';
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
    required List<VariableObject> params,
    required List<VariableObject> states,
    required List<DatasetObject> dataset,
    int? loop,
    required bool forPlay,
    required CNode node,
    CNode? child,
    List<CNode>? children,
  }) =>
      WWrap(
        key: ValueKey(
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
  String toCode(
    BuildContext context,
    CNode node,
    CNode? child,
    List<CNode>? children,
    int pageId,
    int? loop,
  ) =>
      wrapCodeTemplate(context, this, children ?? []);
}
