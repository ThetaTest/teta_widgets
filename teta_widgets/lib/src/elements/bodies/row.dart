// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:teta_core/src/models/variable.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
import 'package:teta_widgets/src/elements/code/snippets.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/templates/row.dart';
import 'package:teta_widgets/src/elements/controls/control_model.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/controls/type.dart';
import 'package:teta_widgets/src/elements/features/cross_axis_alignment.dart';
import 'package:teta_widgets/src/elements/features/main_axis_alignment.dart';
import 'package:teta_widgets/src/elements/features/main_axis_size.dart';
import 'package:teta_widgets/src/elements/intrinsic_states/class.dart';
import 'package:teta_widgets/src/elements/nodes/categories.dart';
import 'package:teta_widgets/src/elements/nodes/children_enum.dart';
import 'package:teta_widgets/src/elements/nodes/enum.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';
import 'package:teta_widgets/src/elements/nodes/suggestion.dart';
import 'package:teta_widgets/src/elements/widgets/row.dart';

const _globalType = NType.row;

/// IS
final rowIntrinsicStates = IntrinsicStates(
  nodeIcon: Assets.wIcons.row,
  nodeVideo: null,
  nodeDescription: 'Layout a list of child widgets in the horizontal direction.',
  advicedChildren: [
    NodeType.name(NType.text),
    NodeType.name(NType.icon),
    NodeType.name(NType.gestureDetector),
  ],
  blockedTypes: [],
  synonymous: ['row', 'horizontal list'],
  advicedChildrenCanHaveAtLeastAChild: [],
  displayName: NodeType.name(_globalType),
  type: _globalType,
  category: NodeCategories.basic,
  maxChildren: null,
  canHave: ChildrenEnum.children,
  addChildLabels: [],
  gestures: [],
  permissions: [],
  packages: [],
  suggestionsTitle: 'Why use Row in Teta?',
  suggestions: [
    const Suggestion(
      title: 'Why use Row in Teta?',
      description: 'Test',
      linkToOpen: 'https://docs.teta.so/teta-docs/widget/basic-widgets/row',
    )
  ],
);

/// Body
class RowBody extends NodeBody {
  @override
  // ignore: overridden_fields
  Map<String, dynamic> attributes = <String, dynamic>{
    DBKeys.mainAxisAlignment: FMainAxisAlignment(),
    DBKeys.crossAxisAlignment: FCrossAxisAlignment(),
    DBKeys.mainAxisSize: FMainAxisSize(),
  };

  @override
  List<ControlModel> get controls => [
        ControlObject(
          type: ControlType.mainAxisAlignment,
          key: DBKeys.mainAxisAlignment,
          value: attributes[DBKeys.mainAxisAlignment],
          valueType: VariableType.string,
        ),
        ControlObject(
          type: ControlType.crossAxisAlignment,
          key: DBKeys.crossAxisAlignment,
          value: attributes[DBKeys.crossAxisAlignment],
          valueType: VariableType.string,
        ),
        ControlObject(
          type: ControlType.mainAxisSize,
          key: DBKeys.mainAxisSize,
          value: attributes[DBKeys.mainAxisSize],
          valueType: VariableType.string,
        ),
      ];

  @override
  Widget toWidget({
    required final TetaWidgetState state,
    final CNode? child,
    final List<CNode>? children,
  }) =>
      WRow(
        ValueKey(
          '''
            ${state.node.nid}
            ${state.loop}
            ${child ?? children}
            ${(attributes[DBKeys.mainAxisAlignment] as FMainAxisAlignment).toJson()}
            ${(attributes[DBKeys.crossAxisAlignment] as FCrossAxisAlignment).toJson()}
            ${(attributes[DBKeys.mainAxisSize] as FMainAxisSize).toJson()}
            ''',
        ),
        state: state,
        children: children ?? [],
        mainAxisAlignment: attributes[DBKeys.mainAxisAlignment] as FMainAxisAlignment,
        crossAxisAlignment: attributes[DBKeys.crossAxisAlignment] as FCrossAxisAlignment,
        mainAxisSize: attributes[DBKeys.mainAxisSize] as FMainAxisSize,
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
        RowCodeTemplate.toCode(context, this, children ?? []),
        loop ?? 0,
      );
}
