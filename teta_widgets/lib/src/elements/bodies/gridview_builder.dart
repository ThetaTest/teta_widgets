// Flutter imports:
// ignore_for_file: lines_longer_than_80_chars

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:teta_core/src/models/dataset.dart';
import 'package:teta_core/src/models/variable.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/advanced/gridview_builder.dart';
import 'package:teta_widgets/src/elements/controls/control_model.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/controls/type.dart';
import 'package:teta_widgets/src/elements/features/dataset.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_widgets/src/elements/intrinsic_states/class.dart';
import 'package:teta_widgets/src/elements/nodes/categories.dart';
import 'package:teta_widgets/src/elements/nodes/children_enum.dart';
import 'package:teta_widgets/src/elements/nodes/enum.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';
import 'package:teta_widgets/src/elements/widgets/gridview_builder.dart';

const _globalType = NType.gridViewBuilder;

/// Instrict State of GridView Builder
final gridViewBuilderIntrinsicStates = IntrinsicStates(
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
  category: NodeCategories.list,
  maxChildren: null,
  canHave: ChildrenEnum.child,
  addChildLabels: [],
  gestures: [],
  permissions: [],
  packages: [],
);

/// GridView Builder's body
class GridViewBuilderBody extends NodeBody {
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
    DBKeys.datasetInput: FDataset(),
  };

  @override
  List<ControlModel> get controls => [
        FlagControlObject(
          title: 'Is Vertical',
          description: 'The axis along which the scroll view scrolls.',
          key: DBKeys.isVertical,
          value: attributes[DBKeys.isVertical],
        ),
        FlagControlObject(
          title: 'Shrink Wrap',
          description:
              'Whether the extent of the scroll view in the scrollDirection should be determined by the contents being viewed.',
          key: DBKeys.flag,
          value: attributes[DBKeys.flag],
        ),
        FlagControlObject(
          title: 'Is Primary',
          description: 'Whether this is the primary scroll view',
          key: DBKeys.isPrimary,
          value: attributes[DBKeys.isPrimary],
        ),
        ControlObject(
          title: 'Main Axis Spacing',
          type: ControlType.value,
          key: DBKeys.mainAxisSpacing,
          value: attributes[DBKeys.mainAxisSpacing],
          description:
              'The number of logical pixels between each child along the main axis.',
        ),
        ControlObject(
          title: 'Cross Axis Count',
          type: ControlType.value,
          key: DBKeys.crossAxisCount,
          value: attributes[DBKeys.crossAxisCount],
          description: 'The number of children in the cross axis.',
        ),
        ControlObject(
          title: 'Cross Axis Spacing',
          type: ControlType.value,
          key: DBKeys.crossAxisSpacing,
          value: attributes[DBKeys.crossAxisSpacing],
          description:
              'The number of logical pixels between each child along the cross axis.',
        ),
        ControlObject(
          title: 'Child Aspect Ratio',
          type: ControlType.value,
          key: DBKeys.childAspectRatio,
          value: attributes[DBKeys.childAspectRatio],
          description:
              'The ratio of the cross-axis to the main-axis extent of each child.',
        ),
        ControlObject(
          type: ControlType.datasetType,
          key: DBKeys.datasetInput,
          value: attributes[DBKeys.datasetInput],
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
      WGridViewBuilder(
        ValueKey(
          '''
      ${node.nid}
      $loop
            ${child ?? children}
      ${(attributes[DBKeys.datasetInput] as FDataset).toJson()}
      ${attributes[DBKeys.isPrimary] as bool}
      ${attributes[DBKeys.isVertical] as bool}
      ${attributes[DBKeys.flag] as bool}
      ${(attributes[DBKeys.mainAxisSpacing] as FTextTypeInput).toJson()}
      ${(attributes[DBKeys.childAspectRatio] as FTextTypeInput).toJson()}
      ${(attributes[DBKeys.crossAxisCount] as FTextTypeInput).toJson()}
      ${(attributes[DBKeys.crossAxisSpacing] as FTextTypeInput).toJson()}
      ''',
        ),
        node: node,
        child: child,
        value: attributes[DBKeys.datasetInput] as FDataset,
        primary: attributes[DBKeys.isPrimary] as bool,
        isVertical: attributes[DBKeys.isVertical] as bool,
        shrinkWrap: attributes[DBKeys.flag] as bool,
        mainAxisSpacing: attributes[DBKeys.mainAxisSpacing] as FTextTypeInput,
        childAspectRatio: attributes[DBKeys.childAspectRatio] as FTextTypeInput,
        crossAxisCount: attributes[DBKeys.crossAxisCount] as FTextTypeInput,
        crossAxisSpacing: attributes[DBKeys.crossAxisSpacing] as FTextTypeInput,
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
      GridViewBuilderCodeTemplate.toCode(context, this, child, loop);
}
