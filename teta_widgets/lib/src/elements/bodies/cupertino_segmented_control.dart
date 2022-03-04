// Flutter imports:
import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:teta_core/src/models/dataset.dart';
import 'package:teta_core/src/models/variable.dart';
import 'package:teta_widgets/src/elements/code/templates/cupertino_segmented_control.dart';
import 'package:teta_widgets/src/elements/controls/control_model.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/controls/type.dart';
import 'package:teta_widgets/src/elements/features/action.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/gestures.dart';
import 'package:teta_widgets/src/elements/features/fill.dart';
import 'package:teta_widgets/src/elements/intrinsic_states/class.dart';
import 'package:teta_widgets/src/elements/nodes/categories.dart';
import 'package:teta_widgets/src/elements/nodes/children_enum.dart';
import 'package:teta_widgets/src/elements/nodes/enum.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';
import 'package:teta_widgets/src/elements/widgets/cupertino_segmented_control.dart';

const _globalType = NType.cupertinoSegmentedControl;

/// Instrict State of Cupertino Segmented Control
final cupertinoSegmentedControlIntrinsicStates = IntrinsicStates(
  nodeIcon: Assets.wIcons.cupertinoSegmentedControl,
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
  maxChildren: 4,
  canHave: ChildrenEnum.children,
  addChildLabels: [],
  gestures: [
    ActionGesture.onTap,
  ],
);

/// Cupertino Segmented Control's body
class CupertinoSegmentedControlBody extends NodeBody {
  @override
  // ignore: overridden_fields
  Map<String, dynamic> attributes = <String, dynamic>{
    DBKeys.action: FAction(),
    DBKeys.fill: FFill(
      levels: [
        FFillElement(color: '3285FF', stop: 0),
      ],
    ), //selected
    DBKeys.bgFill: FFill(
      levels: [
        FFillElement(color: '222222', stop: 0),
      ],
    ), //unselected
    DBKeys.textFill: FFill(
      levels: [
        FFillElement(color: '444444', stop: 0),
      ],
    ), //pressed
    DBKeys.activeFill: FFill(
      levels: [
        FFillElement(color: '000000', stop: 0),
      ],
    ), //border
  };

  @override
  List<ControlModel> get controls => [
        ControlObject(
          type: ControlType.action,
          key: DBKeys.action,
          value: attributes[DBKeys.action],
        ),
        FillControlObject(
          title: 'Selected Color',
          key: DBKeys.fill,
          value: attributes[DBKeys.fill] as FFill,
          isStyled: true,
          isImageEnabled: false,
          isNoneEnabled: false,
          isOnlySolid: true,
        ),
        FillControlObject(
          title: 'Unselected Color',
          key: DBKeys.bgFill,
          value: attributes[DBKeys.bgFill] as FFill,
          isStyled: true,
          isImageEnabled: false,
          isNoneEnabled: false,
          isOnlySolid: true,
        ),
        FillControlObject(
          title: 'Pressed Color',
          key: DBKeys.textFill,
          value: attributes[DBKeys.textFill] as FFill,
          isStyled: true,
          isImageEnabled: false,
          isNoneEnabled: false,
          isOnlySolid: true,
        ),
        FillControlObject(
          title: 'Border Color',
          key: DBKeys.activeFill,
          value: attributes[DBKeys.activeFill] as FFill,
          isStyled: true,
          isImageEnabled: false,
          isNoneEnabled: false,
          isOnlySolid: true,
        ),
      ];

  @override
  Widget toWidget({
    required List<VariableObject> params,
    required List<VariableObject> states,
    required List<DatasetObject> dataset,
    required bool forPlay,
    required CNode node,
    int? loop,
    CNode? child,
    List<CNode>? children,
  }) =>
      WCupertinoSegmentedControl(
        ValueKey(
          '''
      ${node.nid}
      $loop
            ${child ?? children}
      ${(attributes[DBKeys.textFill] as FFill).toJson()}
      ${(attributes[DBKeys.action] as FAction).toJson()}
      ${(attributes[DBKeys.activeFill] as FFill).toJson()}
      ${(attributes[DBKeys.fill] as FFill).toJson()}
      ${(attributes[DBKeys.bgFill] as FFill).toJson()}
      ''',
        ),
        node: node,
        children: children ?? <CNode>[],
        pressedColor: attributes[DBKeys.textFill] as FFill,
        borderColor: attributes[DBKeys.activeFill] as FFill,
        selectedColor: attributes[DBKeys.fill] as FFill,
        unselectedColor: attributes[DBKeys.bgFill] as FFill,
        forPlay: forPlay,
        loop: loop,
        action: attributes[DBKeys.action] as FAction,
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
      cupertinoSegmentedControlCodeTemplate(
        context,
        this,
        node,
        children ?? <CNode>[],
      );
}
