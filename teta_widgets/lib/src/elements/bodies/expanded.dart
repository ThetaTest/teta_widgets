// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/templates/expanded.dart';
import 'package:teta_widgets/src/elements/controls/control_model.dart';
import 'package:teta_widgets/src/elements/intrinsic_states/class.dart';
import 'package:teta_widgets/src/elements/nodes/categories.dart';
import 'package:teta_widgets/src/elements/nodes/children_enum.dart';
import 'package:teta_widgets/src/elements/nodes/enum.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';
import 'package:teta_widgets/src/elements/nodes/suggestion.dart';
import 'package:teta_widgets/src/elements/widgets/expanded.dart';

const _globalType = NType.expanded;

/// Instrict State of Expanded
final expandedIntrinsicStates = IntrinsicStates(
  nodeIcon: Assets.wIcons.expanded,
  nodeVideo: '_rnZaagadyo',
  nodeDescription: null,
  advicedChildren: [
    NodeType.name(NType.image),
    NodeType.name(NType.center),
    NodeType.name(NType.column),
  ],
  blockedTypes: [],
  synonymous: ['expanded', 'auto', 'space', 'flex'],
  advicedChildrenCanHaveAtLeastAChild: [],
  displayName: NodeType.name(_globalType),
  type: _globalType,
  category: NodeCategories.advanced,
  maxChildren: 1,
  canHave: ChildrenEnum.child,
  addChildLabels: [],
  gestures: [],
  permissions: [],
  packages: [],
  suggestionsTitle: 'Why use Expanded in Teta?',
  suggestions: [
    const Suggestion(
      title: 'Why use Expanded in Teta?',
      description: 'Test',
      linkToOpen:
          'https://docs.teta.so/teta-docs/widget/advanced-widgets/expanded',
    )
  ],
);

/// Expanded's body
class ExpandedBody extends NodeBody {
  @override
  // ignore: overridden_fields
  Map<String, dynamic> attributes = <String, dynamic>{};

  @override
  List<ControlModel> get controls => [];

  @override
  Widget toWidget({
    required final TetaWidgetState state,
    final CNode? child,
    final List<CNode>? children,
  }) =>
      WExpanded(
        ValueKey(
          '''
          ${state.toKey}
          ${child ?? children}
          ''',
        ),
        state: state,
        child: child,
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
      ExpandedCodeTemplate.toCode(context, this, child, loop);
}
