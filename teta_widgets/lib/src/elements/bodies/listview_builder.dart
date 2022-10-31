// Flutter imports:
// ignore_for_file: lines_longer_than_80_chars

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:teta_core/src/models/dataset.dart';
import 'package:teta_core/src/models/variable.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/advanced/listview_builder.dart';
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/controls/control_model.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/controls/type.dart';
import 'package:teta_widgets/src/elements/features/physic.dart';
import 'package:teta_widgets/src/elements/index.dart';
import 'package:teta_widgets/src/elements/intrinsic_states/class.dart';
import 'package:teta_widgets/src/elements/nodes/categories.dart';
import 'package:teta_widgets/src/elements/nodes/children_enum.dart';
import 'package:teta_widgets/src/elements/nodes/dynamic.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';
import 'package:teta_widgets/src/elements/nodes/suggestion.dart';

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
  gestures: <ActionGesture>[
    ActionGesture.scrollToTop,
    ActionGesture.scrollToBottom,
  ],
  permissions: [],
  packages: [],
  suggestionsTitle: 'Why use ListView Builder in Teta?',
  suggestions: [
    const Suggestion(
      title: 'Why use ListView Builder in Teta?',
      description: 'Test',
      linkToOpen:
          'https://docs.teta.so/teta-docs/widget/list-widgets/listview-builder',
    )
  ],
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
    DBKeys.isFullWidth: false,
    DBKeys.physic: FPhysic(),
    DBKeys.action: FAction(),
    DBKeys.value: FTextTypeInput(value: '0'),
    DBKeys.valueOfCondition: FTextTypeInput(),
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
          valueType: VariableType.string,
        ),
        ControlObject(
          title: 'Start from',
          type: ControlType.value,
          key: DBKeys.value,
          value: attributes[DBKeys.value],
          description:
              'Int value. The first valid index to start to fetch. E.g. to exclude the first element, set index = 0',
          valueType: VariableType.string,
        ),
        ControlObject(
          title: 'Limit',
          type: ControlType.value,
          key: DBKeys.valueOfCondition,
          value: attributes[DBKeys.valueOfCondition],
          description: 'How many elements should be fetched inside the list.',
          valueType: VariableType.string,
        ),
        FlagControlObject(
          title: 'Reverse',
          key: DBKeys.isFullWidth,
          value: attributes[DBKeys.isFullWidth],
          description: 'Inverse children order',
        ),
        ControlObject(
          type: ControlType.physics,
          key: DBKeys.physic,
          value: attributes[DBKeys.physic],
          description:
              'Use the physics in order to have different scrolling behaviours',
          valueType: VariableType.string,
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
      WListViewBuilder(
        ValueKey(
          '''
      ${node.nid}
      $loop
            ${child ?? children}
      ${(attributes[DBKeys.datasetInput] as FDataset).toJson()}
      ${attributes[DBKeys.isVertical] as bool}
      ${attributes[DBKeys.flag] as bool}
      ${attributes[DBKeys.isFullWidth] as bool}
      ${(attributes[DBKeys.physic] as FPhysic).toJson()}
      ${(attributes[DBKeys.action] as FAction).toJson()}
      ${(attributes[DBKeys.value] as FTextTypeInput).toJson()}
      ${(attributes[DBKeys.valueOfCondition] as FTextTypeInput).toJson()}
      ''',
        ),
        node: node,
        child: child,
        value: attributes[DBKeys.datasetInput] as FDataset,
        isVertical: attributes[DBKeys.isVertical] as bool,
        shrinkWrap: attributes[DBKeys.flag] as bool,
        isReverse: attributes[DBKeys.isFullWidth] as bool,
        physic: attributes[DBKeys.physic] as FPhysic,
        action: attributes[DBKeys.action] as FAction,
        startFromIndex: attributes[DBKeys.value] as FTextTypeInput,
        limit: attributes[DBKeys.valueOfCondition] as FTextTypeInput,
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
        ListViewBuilderCodeTemplate.toCode(
          context,
          node as NDynamic,
          pageId,
          child,
          loop,
        ),
        loop ?? 0,
      );
}
