// Flutter imports:
// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:teta_core/src/models/dataset.dart';
import 'package:teta_core/src/models/variable.dart';
import 'package:teta_widgets/src/elements/code/advanced/tcard.dart';
import 'package:teta_widgets/src/elements/controls/control_model.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/controls/type.dart';
import 'package:teta_widgets/src/elements/features/action.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/index.dart';
import 'package:teta_widgets/src/elements/features/sizes.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_widgets/src/elements/intrinsic_states/class.dart';
import 'package:teta_widgets/src/elements/nodes/categories.dart';
import 'package:teta_widgets/src/elements/nodes/children_enum.dart';
import 'package:teta_widgets/src/elements/nodes/enum.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';
import 'package:teta_widgets/src/elements/widgets/tcard.dart';

const _globalType = NType.tcard;

/// IS
final tcardIntrinsicStates = IntrinsicStates(
  nodeIcon: Assets.wIcons.tCardBuilder,
  nodeVideo: null,
  nodeDescription: null,
  advicedChildren: [
    NodeType.name(NType.container),
    NodeType.name(NType.column),
    NodeType.name(NType.stack),
  ],
  blockedTypes: [],
  synonymous: ['tcard', 'tinder', 'card', 'online meet', 'swipe', 'pageview'],
  advicedChildrenCanHaveAtLeastAChild: [],
  displayName: NodeType.name(_globalType),
  type: _globalType,
  category: NodeCategories.list,
  maxChildren: null,
  canHave: ChildrenEnum.children,
  addChildLabels: [],
  gestures: [
    ActionGesture.swipeLeft,
    ActionGesture.swipeRight,
    ActionGesture.onEnd,
  ],
);

/// Body
class TCardBody extends NodeBody {
  @override
  // ignore: overridden_fields
  Map<String, dynamic> attributes = <String, dynamic>{
    DBKeys.flag: false,
    DBKeys.action: FAction(),
    DBKeys.width: FSize(size: '400', unit: SizeUnit.pixel),
    DBKeys.height: FSize(size: '600', unit: SizeUnit.pixel),
    DBKeys.value: FTextTypeInput(value: '20'),
    DBKeys.valueOfCondition: FTextTypeInput(value: '500'),
  };

  @override
  List<ControlModel> get controls => [
        ControlObject(
          type: ControlType.action,
          key: DBKeys.action,
          value: attributes[DBKeys.action],
        ),
        FlagControlObject(
          title: 'Lock Y Axis',
          key: DBKeys.flag,
          value: attributes[DBKeys.flag],
          description: 'Lock Y Axis Gesture',
        ),
        ControlObject(
          type: ControlType.value,
          key: DBKeys.value,
          value: attributes[DBKeys.value],
          title: 'Slide Speed',
          description:
              'How quick should it be slided? less is slower. 10 is a bit slow. 20 is a quick enough.',
        ),
        ControlObject(
          type: ControlType.value,
          key: DBKeys.valueOfCondition,
          value: attributes[DBKeys.valueOfCondition],
          title: 'Delay Slide For',
          description:
              'How long does it have to wait until the next slide is sliable? less is quicker. 100 is fast enough. 500 is a bit slow.',
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
      WTCard(
        key: ValueKey(
          '''
            ${node.nid}
            $loop
            ${child ?? children}
            ${(attributes[DBKeys.action] as FAction).toJson()}
            ${(attributes[DBKeys.value] as FTextTypeInput).toJson()}
            ${(attributes[DBKeys.valueOfCondition] as FTextTypeInput).toJson()}
            ${attributes[DBKeys.flag] as bool}
            ''',
        ),
        node: node,
        children: children ?? [],
        lockYAxis: attributes[DBKeys.flag] as bool,
        action: attributes[DBKeys.action] as FAction,
        slideSpeed: attributes[DBKeys.value] as FTextTypeInput,
        delaySlideFor: attributes[DBKeys.valueOfCondition] as FTextTypeInput,
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
      tCardCodeTemplate(context, node, children ?? [], loop);
}
