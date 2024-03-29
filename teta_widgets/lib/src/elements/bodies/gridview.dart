// Flutter imports:
// ignore_for_file: lines_longer_than_80_chars

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:teta_models/src/models/variable.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/advanced/gridview.dart';
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/controls/control_model.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/controls/type.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_widgets/src/elements/intrinsic_states/class.dart';
import 'package:teta_widgets/src/elements/nodes/categories.dart';
import 'package:teta_widgets/src/elements/nodes/children_enum.dart';
import 'package:teta_widgets/src/elements/nodes/enum.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';
import 'package:teta_widgets/src/elements/nodes/suggestion.dart';
import 'package:teta_widgets/src/elements/widgets/gridview.dart';

const _globalType = NType.gridView;

/// Instrict State of GridView
final gridIntrinsicStates = IntrinsicStates(
  nodeIcon: Assets.wIcons.grid,
  nodeVideo: null,
  nodeDescription: null,
  advicedChildren: [
    NodeType.name(NType.container),
    NodeType.name(NType.expanded),
    NodeType.name(NType.gestureDetector),
  ],
  blockedTypes: [],
  synonymous: ['gridview', 'builder', 'scroll', 'vertical list'],
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
  suggestionsTitle: 'Why use GridView in Teta?',
  suggestions: [
    const Suggestion(
      title: 'Why use GridView in Teta?',
      description: 'Test',
      linkToOpen: 'https://docs.teta.so/teta-docs/widget/list-widgets/gridview',
    )
  ],
);

/// GridView builder
class GridViewBody extends NodeBody {
  @override
  // ignore: overridden_fields
  Map<String, dynamic> attributes = <String, dynamic>{
    DBKeys.flag: true,
    DBKeys.isVertical: true,
    DBKeys.isPrimary: true,
    DBKeys.mainAxisSpacing: FTextTypeInput(value: '2'),
    DBKeys.crossAxisCount: FTextTypeInput(value: '2'),
    DBKeys.crossAxisSpacing: FTextTypeInput(value: '2'),
    DBKeys.childAspectRatio: FTextTypeInput(value: '1'),
  };

  @override
  List<ControlModel> get controls => [
        FlagControlObject(
          title: 'Is Vertical',
          key: DBKeys.isVertical,
          value: attributes[DBKeys.isVertical],
          description: 'The axis along which the scroll view scrolls.',
        ),
        FlagControlObject(
          title: 'Shrink Wrap',
          key: DBKeys.flag,
          value: attributes[DBKeys.flag],
          description:
              'Whether the extent of the scroll view in the scrollDirection should be determined by the contents being viewed.',
        ),
        FlagControlObject(
          title: 'Is Primary',
          key: DBKeys.isPrimary,
          value: attributes[DBKeys.isPrimary],
          description: 'Whether this is the primary scroll view',
        ),
        ControlObject(
          title: 'Main Axis Spacing',
          type: ControlType.value,
          key: DBKeys.mainAxisSpacing,
          value: attributes[DBKeys.mainAxisSpacing],
          description:
              'The number of logical pixels between each child along the main axis.',
          valueType: VariableType.int,
        ),
        ControlObject(
          title: 'Cross Axis Count',
          type: ControlType.value,
          key: DBKeys.crossAxisCount,
          value: attributes[DBKeys.crossAxisCount],
          description: 'The number of children in the cross axis.',
          valueType: VariableType.int,
        ),
        ControlObject(
          title: 'Cross Axis Spacing',
          type: ControlType.value,
          key: DBKeys.crossAxisSpacing,
          value: attributes[DBKeys.crossAxisSpacing],
          description:
              'The number of logical pixels between each child along the cross axis.',
          valueType: VariableType.int,
        ),
        ControlObject(
          title: 'Child Aspect Ratio',
          type: ControlType.value,
          key: DBKeys.childAspectRatio,
          value: attributes[DBKeys.childAspectRatio],
          description:
              'The ratio of the cross-axis to the main-axis extent of each child.',
          valueType: VariableType.double,
        ),
      ];

  @override
  Widget toWidget({
    required final TetaWidgetState state,
    final CNode? child,
    final List<CNode>? children,
  }) =>
      WGridView(
        ValueKey(
          '''
          ${state.toKey}
          ${child ?? children}
          ${attributes[DBKeys.isPrimary] as bool}
          ${attributes[DBKeys.isVertical] as bool}
          ${attributes[DBKeys.flag] as bool}
          ${(attributes[DBKeys.mainAxisSpacing] as FTextTypeInput).toJson()}
          ${(attributes[DBKeys.childAspectRatio] as FTextTypeInput).toJson()}
          ${(attributes[DBKeys.crossAxisCount] as FTextTypeInput).toJson()}
          ${(attributes[DBKeys.crossAxisSpacing] as FTextTypeInput).toJson()}
          ''',
        ),
        state: state,
        children: children ?? [],
        isPrimary: attributes[DBKeys.isPrimary] as bool,
        isVertical: attributes[DBKeys.isVertical] as bool,
        shrinkWrap: attributes[DBKeys.flag] as bool,
        mainAxisSpacing: attributes[DBKeys.mainAxisSpacing] as FTextTypeInput,
        childAspectRatio: attributes[DBKeys.childAspectRatio] as FTextTypeInput,
        crossAxisCount: attributes[DBKeys.crossAxisCount] as FTextTypeInput,
        crossAxisSpacing: attributes[DBKeys.crossAxisSpacing] as FTextTypeInput,
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
        GridViewCodeTemplate.toCode(context, this, children ?? [], loop),
        loop ?? 0,
      );
}
