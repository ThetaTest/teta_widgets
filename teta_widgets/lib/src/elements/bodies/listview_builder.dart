// Flutter imports:
// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:teta_core/src/models/dataset.dart';
import 'package:teta_core/src/models/variable.dart';
import 'package:teta_widgets/src/elements/code/advanced/listview_builder.dart';
import 'package:teta_widgets/src/elements/controls/control_model.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/controls/type.dart';
import 'package:teta_widgets/src/elements/features/dataset.dart';
import 'package:teta_widgets/src/elements/intrinsic_states/class.dart';
import 'package:teta_widgets/src/elements/nodes/categories.dart';
import 'package:teta_widgets/src/elements/nodes/children_enum.dart';
import 'package:teta_widgets/src/elements/nodes/enum.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';
import 'package:teta_widgets/src/elements/widgets/listview_builder.dart';

const _globalType = NType.listViewBuilder;

/// Intrinsic States of ListView Builder
final listViewBuilderIntrinsicStates = IntrinsicStates(
  nodeIcon: Assets.wIcons.list,
  nodeVideo: null,
  nodeDescription: null,
  advicedChildren: [
    NodeType.name(NType.container),
    NodeType.name(NType.text),
    NodeType.name(NType.gestureDetector),
  ],
  blockedTypes: [],
  synonymous: ['listview builder', 'scroll', 'vertical list'],
  advicedChildrenCanHaveAtLeastAChild: [],
  displayName: NodeType.name(_globalType),
  type: _globalType,
  category: NodeCategories.list,
  maxChildren: 1,
  canHave: ChildrenEnum.child,
  addChildLabels: [],
  gestures: [],
);

/// ListView Builder's body
class ListViewBuilderBody extends NodeBody {
  @override
  // ignore: overridden_fields
  Map<String, dynamic> attributes = <String, dynamic>{
    DBKeys.datasetInput: FDataset(),
    DBKeys.isVertical: true,
    DBKeys.flag: true,
    DBKeys.isPrimary: true,
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
        ControlObject(
          type: ControlType.datasetType,
          key: DBKeys.datasetInput,
          value: attributes[DBKeys.datasetInput],
        ),
      ];

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
      WListViewBuilder(
        key: ValueKey(
          '''
      ${node.nid}
      $loop
            ${child ?? children}
      ${(attributes[DBKeys.datasetInput] as FDataset).toJson()}
      ${attributes[DBKeys.isVertical] as bool}
      ${attributes[DBKeys.flag] as bool}
      ''',
        ),
        node: node,
        child: child,
        value: attributes[DBKeys.datasetInput] as FDataset,
        isVertical: attributes[DBKeys.isVertical] as bool,
        shrinkWrap: attributes[DBKeys.flag] as bool,
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
      listViewBuilderCodeTemplate(context, this, child);
}
