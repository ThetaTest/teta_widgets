// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/code/templates/fractionally_sizedbox.dart';
// Project imports:
import 'package:teta_widgets/src/elements/controls/control_model.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/index.dart';
import 'package:teta_widgets/src/elements/intrinsic_states/class.dart';
import 'package:teta_widgets/src/elements/nodes/categories.dart';
import 'package:teta_widgets/src/elements/nodes/children_enum.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';
import 'package:teta_widgets/src/elements/nodes/suggestion.dart';

/// globalType for SizedBox widget
const _globalType = NType.fractionallySizedBox;

/// IntrinsicStates for FractionallySizedBox widget
final fractionallySizedBoxIntrinsicStates = IntrinsicStates(
  nodeIcon: Assets.wIcons.sizedBox,
  nodeVideo: null,
  nodeDescription: null,
  advicedChildren: [
    NodeType.name(NType.listView),
    NodeType.name(NType.column),
    NodeType.name(NType.center),
  ],
  blockedTypes: [],
  synonymous: [
    NodeType.name(_globalType),
    'sizedbox',
    'container',
    'div',
    'sizes',
    'fraction',
    'responsive',
  ],
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
  suggestionsTitle: 'Why use Fractionally Sized Box in Teta?',
  suggestions: [
    const Suggestion(
      title: 'Why use Fractionally Sized Box in Teta?',
      description: 'Test',
      linkToOpen: 'https://docs.teta.so/teta-docs/widget/basic-widgets/sized-box',
    )
  ],
);

/// Body for FractionallySizedBox widget
class FractionallySizedBoxBody extends NodeBody {
  @override
  // ignore: overridden_fields
  Map<String, dynamic> attributes = <String, dynamic>{
    DBKeys.widthFactor: FSize(size: '1', unit: SizeUnit.pixel),
    DBKeys.heightFactor: FSize(size: '1', unit: SizeUnit.pixel),
  };

  @override
  List<ControlModel> get controls => [
        SizesControlObject(
          keys: const [DBKeys.widthFactor, DBKeys.heightFactor],
          values: <FSize>[
            attributes[DBKeys.widthFactor] as FSize,
            attributes[DBKeys.heightFactor] as FSize,
          ],
        ),
      ];

  @override
  Widget toWidget({
    required final TetaWidgetState state,
    final CNode? child,
    final List<CNode>? children,
  }) =>
      WFractionallySizedBox(
        ValueKey(
          '''
          ${state.node.nid}
          ${state.loop}
          ${child ?? children}
          ${(attributes[DBKeys.widthFactor] as FSize).toJson()}
          ${(attributes[DBKeys.heightFactor] as FSize).toJson()}
          ''',
        ),
        state: state,
        widthFactor: attributes[DBKeys.widthFactor] as FSize,
        heightFactor: attributes[DBKeys.heightFactor] as FSize,
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
      CS.defaultWidgets(
        context,
        node,
        pageId,
        FractionallySizedBoxCodeTemplate.toCode(context, this, child),
        loop ?? 0,
      );
}
