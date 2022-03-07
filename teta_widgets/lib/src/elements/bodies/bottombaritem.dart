// Flutter imports:
// ignore_for_file: lines_longer_than_80_chars

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:teta_core/src/models/dataset.dart';
import 'package:teta_core/src/models/variable.dart';

// Project imports:
import 'package:teta_widgets/src/elements/code/templates/bottombaritem.dart';
import 'package:teta_widgets/src/elements/controls/control_model.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/controls/type.dart';
import 'package:teta_widgets/src/elements/features/action.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/gestures.dart';
import 'package:teta_widgets/src/elements/features/fill.dart';
import 'package:teta_widgets/src/elements/features/sizes.dart';
import 'package:teta_widgets/src/elements/features/text_style.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_widgets/src/elements/intrinsic_states/class.dart';
import 'package:teta_widgets/src/elements/nodes/categories.dart';
import 'package:teta_widgets/src/elements/nodes/children_enum.dart';
import 'package:teta_widgets/src/elements/nodes/enum.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';
import 'package:teta_widgets/src/elements/widgets/bottombaritem.dart';

const _globalType = NType.bottombaritem;

/// Instrict State of BottomBarItem
final bottombaritemIntrinsicStates = IntrinsicStates(
  nodeIcon: Assets.wIcons.icon,
  nodeVideo: '7oIAs-0G4mw', //Check
  nodeDescription: null,
  advicedChildren: [
    NodeType.name(NType.container),
    NodeType.name(NType.column),
    NodeType.name(NType.image),
  ],
  blockedTypes: [],
  synonymous: ['icon', 'menu', 'text', 'bottom'],
  advicedChildrenCanHaveAtLeastAChild: [],
  displayName: NodeType.name(_globalType),
  type: _globalType,
  category: NodeCategories.navigation,
  maxChildren: 0,
  canHave: ChildrenEnum.none,
  addChildLabels: [],
  gestures: [ActionGesture.onTap, ActionGesture.onLongPress],
);

/// BottomBarItem's body
class BottomBarItemBody extends NodeBody {
  @override
  // ignore: overridden_fields
  Map<String, dynamic> attributes = <String, dynamic>{
    DBKeys.action: FAction(),
    DBKeys.icon: 'plus',
    DBKeys.width: FSize(size: '24'),
    DBKeys.fill: FFill(
      type: FFillType.solid,
      levels: [
        FFillElement(
          color: 'ffffff',
          stop: 0,
        ),
      ],
    ),
    DBKeys.value: FTextTypeInput(value: 'Label'),
    DBKeys.textStyle: FTextStyle(),
    DBKeys.isFullWidth: false,
  };

  @override
  List<ControlModel> get controls => [
        ControlObject(
          type: ControlType.action,
          key: DBKeys.action,
          value: attributes[DBKeys.action],
        ),
        ControlObject(
          type: ControlType.icon,
          key: DBKeys.icon,
          value: attributes[DBKeys.icon],
        ),
        SizeControlObject(
          type: ControlType.size,
          key: DBKeys.width,
          title: 'Size',
          isWidth: true,
          value: attributes[DBKeys.width] as FSize,
        ),
        FillControlObject(
          title: '',
          key: DBKeys.fill,
          value: attributes[DBKeys.fill] as FFill,
          isImageEnabled: false,
          isNoneEnabled: false,
          isOnlySolid: true,
          isStyled: false,
        ),
        FlagControlObject(
          title: 'Full Width',
          key: DBKeys.isFullWidth,
          value: attributes[DBKeys.isFullWidth],
          description:
              'The Text gets its full width from the screen or that satisfies the constraints.',
        ),
        ControlObject(
          type: ControlType.value,
          key: DBKeys.value,
          value: attributes[DBKeys.value],
        ),
        ControlObject(
          type: ControlType.text,
          key: DBKeys.textStyle,
          value: attributes[DBKeys.textStyle],
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
      WBottomBarItem(
        ValueKey(
          '''
          ${node.nid}
          $loop
            ${child ?? children}
          ${(attributes[DBKeys.action] as FAction).toJson()}
          ${(attributes[DBKeys.width] as FSize).toJson()}
          ${attributes[DBKeys.icon] as String? ?? 'plus'}
          ${(attributes[DBKeys.fill] as FFill).toJson()}
          ${attributes[DBKeys.isFullWidth] as bool}
          ${(attributes[DBKeys.value] as FTextTypeInput? ?? FTextTypeInput()).toJson()}
          ${(attributes[DBKeys.textStyle] as FTextStyle? ?? FTextStyle()).toJson()}
        ''',
        ),
        node: node,
        action: attributes[DBKeys.action] as FAction,
        width: attributes[DBKeys.width] as FSize,
        icon: attributes[DBKeys.icon] as String? ?? 'plus',
        fill: attributes[DBKeys.fill] as FFill,
        isFullWidth: attributes[DBKeys.isFullWidth] as bool,
        value: attributes[DBKeys.value] as FTextTypeInput? ?? FTextTypeInput(),
        textStyle: attributes[DBKeys.textStyle] as FTextStyle? ?? FTextStyle(),
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
      bottomBarItemCodeTemplate(context, this, node, child, loop);
}
