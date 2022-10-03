// Flutter imports:
// ignore_for_file: lines_longer_than_80_chars

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:teta_core/src/models/dataset.dart';
import 'package:teta_core/src/models/variable.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/advanced/listview.dart';
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

import '../nodes/suggestion.dart';

const _globalType = NType.listView;

/// Intrinsic State of ListView
final listIntrinsicStates = IntrinsicStates(
  nodeIcon: Assets.wIcons.list,
  nodeVideo: null,
  nodeDescription: null,
  advicedChildren: [
    NodeType.name(NType.container),
    NodeType.name(NType.text),
    NodeType.name(NType.gestureDetector),
  ],
  blockedTypes: [],
  synonymous: ['scroll', 'vertical list', 'listview'],
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
  suggestionsTitle: 'Why use ListView in Teta?',
  suggestions: [
    const Suggestion(
      title: 'Why use ListView in Teta?',
      description: 'Test',
      linkToOpen: 'https://docs.teta.so/teta-docs/widget/list-widgets/listview',
    )
  ],
);

/// Body of ListView
class ListViewBody extends NodeBody {
  @override
  // ignore: overridden_fields
  Map<String, dynamic> attributes = <String, dynamic>{
    DBKeys.isVertical: true,
    DBKeys.flag: true,
    DBKeys.isPrimary: true,
    DBKeys.isFullWidth: false,
    DBKeys.physic: FPhysic(),
    DBKeys.action: FAction(),
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
      WListView(
        ValueKey(
          '''
      ${node.nid}
      $loop
            ${child ?? children}
      ${attributes[DBKeys.isPrimary] as bool}
      ${attributes[DBKeys.isVertical] as bool}
      ${attributes[DBKeys.flag] as bool}
      ${attributes[DBKeys.isFullWidth] as bool}
      ${(attributes[DBKeys.physic] as FPhysic).toJson()}
      ${(attributes[DBKeys.action] as FAction).toJson()}
      ''',
        ),
        node: node,
        children: children ?? [],
        flagValue: false, //Check
        value: FTextTypeInput(),
        physic: attributes[DBKeys.physic] as FPhysic,
        isPrimary: attributes[DBKeys.isPrimary] as bool, //Check
        isVertical: attributes[DBKeys.isVertical] as bool,
        shrinkWrap: attributes[DBKeys.flag] as bool,
        isReverse: attributes[DBKeys.isFullWidth] as bool,
        action: attributes[DBKeys.action] as FAction,
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
        ListViewCodeTemplate.toCode(
          context,
          node as NDynamic,
          pageId,
          children ?? [],
          loop,
        ),
        loop ?? 0,
      );
}
