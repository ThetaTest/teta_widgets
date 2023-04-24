import 'package:flutter/material.dart';
import 'package:teta_core/teta_core.dart';

import 'package:teta_widgets/src/core/teta_widget/index.dart';
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/controls/control_model.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/index.dart';
import 'package:teta_widgets/src/elements/intrinsic_states/class.dart';
import 'package:teta_widgets/src/elements/nodes/categories.dart';
import 'package:teta_widgets/src/elements/nodes/children_enum.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';
import 'package:teta_widgets/src/elements/nodes/suggestion.dart';

import 'package:teta_widgets/src/elements/code/elevated_button.dart';

import '../controls/type.dart';
import '../widgets/elevated_button.dart';

/// GlobalType for [ElevatedButton] widget
const _globalType = NType.elevatedButton;

/// IntrinsicStates for [ElevatedButton] widget
final elevatedButtonIntrinsicStates = IntrinsicStates(
  nodeIcon: Assets.wIcons.textButton,
  nodeVideo: null,
  nodeDescription: null,
  advicedChildren: [
    NodeType.name(NType.text, ),
     NodeType.name(NType.container, ),
  ],
  blockedTypes: [],
  synonymous: ['textbutton', 'outlinedbutton','geturedetector'],
  advicedChildrenCanHaveAtLeastAChild: [],
  displayName: NodeType.name(_globalType),
  type: _globalType,
  category: NodeCategories.input,
  maxChildren: 1,
  canHave: ChildrenEnum.child,
  addChildLabels: [],
  gestures: [ActionGesture.onTap, ActionGesture.onLongPress, ActionGesture.onHover,],
  permissions: [],
  packages: [],
  suggestionsTitle: 'Why use ElevatedButton in Teta?',
  suggestions: [
    const Suggestion(
      title: 'Why use ElevatedButton in Teta?',
      description: 'Test',
      // linkToOpen:
      //     'https://docs.teta.so/teta-docs/widget/input-widgets/textbutton',
    )
  ],
);

/// Body for [ElevatedButton] widget
/// ```dart
/// ElevatedButton({
///   required void Function()? onPressed,
 /// void Function()? onLongPress,
  ///void Function(bool)? onHover,
 /// void Function(bool)? onFocusChange,
 /// ButtonStyle? style,
 /// FocusNode? focusNode,
 /// bool autofocus = false,
 /// Clip clipBehavior = Clip.none,
 /// MaterialStatesController? statesController,
/// required Widget? child,
/// })
/// ```
class ElevatedButtonBody extends NodeBody {
  @override
  // ignore: overridden_fields
  Map<String, dynamic> attributes = <String, dynamic>{
    DBKeys.action: FAction(),
    DBKeys.borderRadius: FBorderRadius(radius: [5,5, 5, 5]),
    DBKeys.pageTransition: FPageTransition(),
    DBKeys.value: FTextTypeInput(value: 'Click here'),
    DBKeys.width: FSize(size: 'max'),
    DBKeys.fill: FFill(
      levels: [
        FFillElement(color: '3285FF', stop: 0),
      ],
    ),
    DBKeys.height: FSize(
      size: '48',
    ),
    DBKeys.textStyle: FTextStyle(
      textAlign: FTextAlign(
        align: TextAlign.center,
      ),
      fill: FFill(
        levels: [
          FFillElement(color: 'FFFFFF', stop: 0),
        ],
      ),
    ),
    DBKeys.actionValue: FTextTypeInput(),
  };

  @override
  List<ControlModel> get controls => [
     ControlObject(
          type: ControlType.value,
          key: DBKeys.value,
          value: attributes[DBKeys.value],
          valueType: VariableType.string,
        ),
        SizesControlObject(
          keys: const [DBKeys.width, DBKeys.height],
          values: <FSize>[
            attributes[DBKeys.width] as FSize,
            attributes[DBKeys.height] as FSize,
          ],
        ),
        FillControlObject(
          title: '',
          key: DBKeys.fill,
          value: attributes[DBKeys.fill] as FFill,
          isImageEnabled: false,
          isNoneEnabled: false,
          isOnlySolid: false,
          isStyled: false,
        ),
        ControlObject(
          type: ControlType.borderRadius,
          key: DBKeys.borderRadius,
          value: attributes[DBKeys.borderRadius],
          valueType: VariableType.double,
        ),
        ControlObject(
          type: ControlType.text,
          key: DBKeys.textStyle,
          value: attributes[DBKeys.textStyle],
          valueType: VariableType.string,
        ),
  ];

  @override
  Widget toWidget({
    required final TetaWidgetState state,
    final CNode? child,
    final List<CNode>? children,
  }) =>
      WElevatedButton(
        ValueKey(
          '''
            ${state.toKey}
            ${child ?? children}
            ${(attributes[DBKeys.action] as FAction).toJson()}
            ${(attributes[DBKeys.actionValue] as FTextTypeInput).toJson()}
            ${(attributes[DBKeys.fill] as FFill).toJson()}
            ${(attributes[DBKeys.width] as FSize).toJson()}
            ${(attributes[DBKeys.height] as FSize).toJson()}
            ${(attributes[DBKeys.value] as FTextTypeInput).toJson()}
            ${(attributes[DBKeys.borderRadius] as FBorderRadius).toJson()}


            
            ''',
        ),
        state: state,
        child: child,
        action: attributes[DBKeys.action] as FAction,
        actionValue: attributes[DBKeys.actionValue] as FTextTypeInput,
        width: attributes[DBKeys.width] as FSize,
        height: attributes[DBKeys.height] as FSize,
        fill: attributes[DBKeys.fill] as FFill,
        value: attributes[DBKeys.value] as FTextTypeInput,
        borderRadius: attributes[DBKeys.borderRadius] as FBorderRadius,



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
        ElevatedButtonCodeTemplate.toCode(
          pageId,
          context,
          node,
          child,
          loop ?? 0,
        ),
        loop ?? 0,
      );
  }
