// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:teta_core/src/models/dataset.dart';
import 'package:teta_core/src/models/variable.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/templates/cupertino_switch.dart';
import 'package:teta_widgets/src/elements/controls/control_model.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/controls/type.dart';
import 'package:teta_widgets/src/elements/features/action.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/gestures.dart';
import 'package:teta_widgets/src/elements/intrinsic_states/class.dart';
import 'package:teta_widgets/src/elements/nodes/categories.dart';
import 'package:teta_widgets/src/elements/nodes/children_enum.dart';
import 'package:teta_widgets/src/elements/nodes/enum.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';
import 'package:teta_widgets/src/elements/widgets/cupertino_switch.dart';

const _globalType = NType.cupertinoSwitch;

/// Instrict State of Cupertino Switch
final cupertinoSwitchIntrinsicStates = IntrinsicStates(
  nodeIcon: Assets.wIcons.cupertinoSwitch,
  nodeVideo: null,
  nodeDescription: '''
      A widget that detects gestures. 
      Attempts to recognize gestures that correspond to its non-null callbacks. 
      If this widget has a child, 
      it defers to that child for its sizing behavior. 
      If it does not have a child, it grows to fit the parent instead. 
      By default a GestureDetector with an invisible child ignores touches;''',
  advicedChildren: [
    NodeType.name(NType.container),
    NodeType.name(NType.image),
  ],
  blockedTypes: [],
  synonymous: [
    'cupertinoSwitch',
    'checkbox',
    'radio',
    'ontap',
    'onpressed',
    'click'
  ],
  advicedChildrenCanHaveAtLeastAChild: [],
  displayName: NodeType.name(_globalType),
  type: _globalType,
  category: NodeCategories.input,
  maxChildren: 1,
  canHave: ChildrenEnum.none,
  addChildLabels: [],
  gestures: [
    ActionGesture.onChange,
  ],
  permissions: [],
);

/// Instrict State of Cupertino Switch
class CupertinoSwitchBody extends NodeBody {
  @override
  // ignore: overridden_fields
  Map<String, dynamic> attributes = <String, dynamic>{
    DBKeys.action: FAction(),
  };

  @override
  List<ControlModel> get controls => [
        ControlObject(
          type: ControlType.action,
          key: DBKeys.action,
          value: attributes[DBKeys.action],
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
      WCupertinoSwitch(
        ValueKey(
          '''
      ${node.nid}
      $loop
            ${child ?? children}
      ${(attributes[DBKeys.action] as FAction).toJson()}
      ''',
        ),
        node: node,
        child: child,
        forPlay: forPlay,
        loop: loop,
        action: attributes[DBKeys.action] as FAction,
        params: params,
        states: states,
        dataset: dataset,
      );

  @override
  String toCode(
    final BuildContext context,
    final CNode node,
    final CNode? child,
    final List<CNode>? children,
    final int pageId,
    final int? loop,
  ) =>
      cupertinoSwitchCodeTemplate(
        context,
        this,
        node,
        child,
        loop ?? 0,
      );
}
