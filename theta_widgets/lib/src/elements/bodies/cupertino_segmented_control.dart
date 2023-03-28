// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:theta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:theta_widgets/src/elements/code/templates/cupertino_segmented_control.dart';
import 'package:theta_widgets/src/elements/controls/control_model.dart';
import 'package:theta_widgets/src/elements/controls/key_constants.dart';
import 'package:theta_widgets/src/elements/features/actions/enums/gestures.dart';
import 'package:theta_widgets/src/elements/features/fill.dart';
import 'package:theta_widgets/src/elements/intrinsic_states/class.dart';
import '../../../../../../teta_open_classes/lib/src/nodes/categories.dart';
import '../../../../../../teta_open_classes/lib/src/nodes/children_enum.dart';
import '../../../../../../teta_open_classes/lib/src/nodes/enum.dart';
import '../../../../../../teta_open_classes/lib/src/nodes/node.dart';
import '../../../../../../teta_open_classes/lib/src/nodes/node_body.dart';
import '../../../../../../teta_open_classes/lib/src/nodes/suggestion.dart';
import 'package:theta_widgets/src/elements/widgets/cupertino_segmented_control.dart';

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
      By default a GestureDetector with an invisible child ignores touches,
''',
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
  category: NodeCategories.form,
  maxChildren: 4,
  canHave: ChildrenEnum.children,
  addChildLabels: [],
  gestures: [
    ActionGesture.onTap,
  ],
  permissions: [],
  packages: [],
  suggestionsTitle: 'Why use Cupertino Segmented Control in Teta?',
  suggestions: [
    const Suggestion(
      title: 'Why use Cupertino Segmented Control in Teta?',
      description: 'Test',
      linkToOpen:
          'https://docs.teta.so/teta-docs/widget/input-widgets/cupertino-segmented-control',
    )
  ],
);

/// Cupertino Segmented Control's body
class CupertinoSegmentedControlBody extends NodeBody {
  @override
  // ignore: overridden_fields
  Map<String, dynamic> attributes = <String, dynamic>{
    //DBKeys.action: NodeGestureActions.empty(),
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
        // ControlObject(
        //   type: ControlType.action,
        //   key: DBKeys.action,
        //   value: attributes[DBKeys.action],
        // ),
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
    required final TetaWidgetState state,
    final CNode? child,
    final List<CNode>? children,
  }) =>
      WCupertinoSegmentedControl(
        ValueKey(
          '''
          ${state.toKey}
          ${child ?? children}
          ${(attributes[DBKeys.textFill] as FFill).toJson()}
          ${(attributes[DBKeys.activeFill] as FFill).toJson()}
          ${(attributes[DBKeys.fill] as FFill).toJson()}
          ${(attributes[DBKeys.bgFill] as FFill).toJson()}
          ''',
        ),
        state: state,
        children: children ?? <CNode>[],
        pressedColor: attributes[DBKeys.textFill] as FFill,
        borderColor: attributes[DBKeys.activeFill] as FFill,
        selectedColor: attributes[DBKeys.fill] as FFill,
        unselectedColor: attributes[DBKeys.bgFill] as FFill,
        //action: attributes[DBKeys.action] as NodeGestureActions,
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
      CupertinoSegmentedControlCodeTemplate.toCode(
        pageId,
        context,
        this,
        node,
        children ?? <CNode>[],
        loop ?? 0,
      );
}
