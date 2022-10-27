// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:teta_core/src/models/dataset.dart';
import 'package:teta_core/src/models/variable.dart';
import 'package:teta_widgets/src/elements/code/snippets.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/templates/button.dart';
import 'package:teta_widgets/src/elements/controls/control_model.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/controls/type.dart';
import 'package:teta_widgets/src/elements/features/action.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/gestures.dart';
import 'package:teta_widgets/src/elements/features/align.dart';
import 'package:teta_widgets/src/elements/features/border_radius.dart';
import 'package:teta_widgets/src/elements/features/fill.dart';
import 'package:teta_widgets/src/elements/features/page_transition.dart';
import 'package:teta_widgets/src/elements/features/sizes.dart';
import 'package:teta_widgets/src/elements/features/text_align.dart';
import 'package:teta_widgets/src/elements/features/text_style.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_widgets/src/elements/intrinsic_states/class.dart';
import 'package:teta_widgets/src/elements/nodes/categories.dart';
import 'package:teta_widgets/src/elements/nodes/children_enum.dart';
import 'package:teta_widgets/src/elements/nodes/enum.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';
import 'package:teta_widgets/src/elements/nodes/suggestion.dart';
import 'package:teta_widgets/src/elements/widgets/button.dart';

const _globalType = NType.button;

/// Instrict State of Button
final buttonIntrinsicStates = IntrinsicStates(
  nodeIcon: Assets.wIcons.button,
  nodeVideo: null,
  nodeDescription: '''
      Buttons allow users to take actions, 
      and make choices, with a single tap. 
      Buttons communicate actions that users can take. 
      They are typically placed throughout your website UI, 
      and they should be easily findable 
      and identifiable while clearly indicating 
      the action they allow a user to complete.''',
  advicedChildren: [],
  blockedTypes: [],
  synonymous: ['button', 'send', 'submit', 'form', 'input'],
  advicedChildrenCanHaveAtLeastAChild: [],
  displayName: NodeType.name(_globalType),
  type: _globalType,
  category: NodeCategories.basic,
  maxChildren: 0,
  canHave: ChildrenEnum.none,
  addChildLabels: [],
  gestures: [
    ActionGesture.onTap,
    ActionGesture.onLongPress,
    ActionGesture.onDoubleTap
  ],
  permissions: [],
  packages: [],
  suggestionsTitle: 'Why use Button in Teta?',
  suggestions: [
    const Suggestion(
      title: 'Why use Button in Teta?',
      description: 'Test',
      linkToOpen: 'https://docs.teta.so/teta-docs/widget/input-widgets/button',
    )
  ],
);

/// Set of funcs to use a Button widget
class ButtonBody extends NodeBody {
  @override
  // ignore: overridden_fields
  Map<String, dynamic> attributes = <String, dynamic>{
    DBKeys.value: FTextTypeInput(value: 'Click here'),
    DBKeys.width: FSize(size: 'max'),
    DBKeys.height: FSize(
      size: '48',
    ),
    DBKeys.borderRadius: FBorderRadius(radius: [8, 8, 8, 8]),
    DBKeys.fill: FFill(
      levels: [
        FFillElement(color: '3285FF', stop: 0),
      ],
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
    DBKeys.action: FAction(),
    DBKeys.actionValue: FTextTypeInput(),
    DBKeys.pageTransition: FPageTransition(),
    DBKeys.align: FAlign()
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
    required final List<VariableObject> params,
    required final List<VariableObject> states,
    required final List<DatasetObject> dataset,
    required final bool forPlay,
    required final CNode node,
    final int? loop,
    final CNode? child,
    final List<CNode>? children,
  }) =>
      WButton(
        ValueKey(
          '''
      ${node.nid}
      $loop
            ${child ?? children}
      ${(attributes[DBKeys.width] as FSize).toJson()}
      ${(attributes[DBKeys.height] as FSize).toJson()}
      ${(attributes[DBKeys.value] as FTextTypeInput).toJson()}
      ${(attributes[DBKeys.borderRadius] as FBorderRadius).toJson()}
      ${(attributes[DBKeys.fill] as FFill).toJson()}
      ${(attributes[DBKeys.textStyle] as FTextStyle).toJson()}
      ${(attributes[DBKeys.align] as FAlign).toJson()}
      ${(attributes[DBKeys.action] as FAction).toJson()}
      ${(attributes[DBKeys.actionValue] as FTextTypeInput).toJson()}
      ${(attributes[DBKeys.pageTransition] as FPageTransition).toJson()}
      ''',
        ),
        node: node,
        width: attributes[DBKeys.width] as FSize,
        height: attributes[DBKeys.height] as FSize,
        value: attributes[DBKeys.value] as FTextTypeInput,
        borderRadius: attributes[DBKeys.borderRadius] as FBorderRadius,
        fill: attributes[DBKeys.fill] as FFill,
        textStyle: attributes[DBKeys.textStyle] as FTextStyle,
        forPlay: forPlay,
        textAlignPosition: attributes[DBKeys.align] as FAlign,
        action: attributes[DBKeys.action] as FAction,
        actionValue: attributes[DBKeys.actionValue] as FTextTypeInput,
        pageTransition: attributes[DBKeys.pageTransition] as FPageTransition,
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
        ButtonCodeTemplate.toCode(pageId, context, this, node, loop ?? 0),
        loop ?? 0,
      );
}
