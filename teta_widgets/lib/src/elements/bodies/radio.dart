// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:teta_core/src/models/variable.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/code/templates/radio_button_to_code.dart';
// Project imports:
import 'package:teta_widgets/src/elements/controls/control_model.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/controls/type.dart';
import 'package:teta_widgets/src/elements/features/action.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/gestures.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_widgets/src/elements/intrinsic_states/class.dart';
import 'package:teta_widgets/src/elements/nodes/categories.dart';
import 'package:teta_widgets/src/elements/nodes/children_enum.dart';
import 'package:teta_widgets/src/elements/nodes/enum.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';
import 'package:teta_widgets/src/elements/widgets/radio.dart';

const _globalType = NType.radio;

/// IS
final radioIntrinsicStates = IntrinsicStates(
  nodeIcon: Assets.wIcons.radio,
  nodeVideo: null,
  nodeDescription: null,
  advicedChildren: [],
  blockedTypes: [],
  synonymous: [NodeType.name(_globalType), 'radio', 'form', 'input', 'checkbox', 'button'],
  advicedChildrenCanHaveAtLeastAChild: [],
  displayName: NodeType.name(_globalType),
  type: _globalType,
  category: NodeCategories.input,
  maxChildren: null,
  canHave: ChildrenEnum.none,
  addChildLabels: [],
  gestures: [ActionGesture.onChange],
  permissions: [],
  packages: [],
);

/// Set of funcs to use Align widget
/// ```dart
/// Radio({
/// Key? key,
/// required T value,
/// required T? groupValue,
/// required ValueChanged<T?>? onChanged,
/// MouseCursor? mouseCursor,
/// bool toggleable,
/// Color? activeColor,
/// MaterialStateProperty<Color?>? fillColor,
/// Color? focusColor, Color? hoverColor,
/// MaterialStateProperty<Color?>? overlayColor,
/// double? splashRadius,
///  MaterialTapTargetSize? materialTapTargetSize,
/// VisualDensity? visualDensity,
/// FocusNode? focusNode,
/// bool autofocus})
/// })
/// ```

class RadioBody extends NodeBody {
  @override
  // ignore: overridden_fields
  Map<String, dynamic> attributes = <String, dynamic>{
    DBKeys.action: FAction(),
    DBKeys.value: FTextTypeInput(),
    DBKeys.actionValue: FTextTypeInput(),
  };

  @override
  List<ControlModel> get controls => [
        ControlObject(
          type: ControlType.value,
          key: DBKeys.actionValue,
          value: attributes[DBKeys.actionValue],
          title: 'Value',
          description: 'The value represented by this radio button.',
          valueType: VariableType.string,
        ),
        ControlObject(
          type: ControlType.value,
          key: DBKeys.value,
          value: attributes[DBKeys.value],
          title: 'Group Value',
          description: 'The currently selected value for a group of radio buttons.',
          valueType: VariableType.string,
        ),
      ];

  @override
  Widget toWidget({
    required final TetaWidgetState state,
    final CNode? child,
    final List<CNode>? children,
  }) =>
      WRadio(
        ValueKey(
          '''
            ${state.node.nid}
            ${state.loop}
            ${child ?? children}
            ${(attributes[DBKeys.action] as FAction).toJson()}
            ${(attributes[DBKeys.value] as FTextTypeInput).toJson()}
            ${(attributes[DBKeys.actionValue] as FTextTypeInput).toJson()}
            ''',
        ),
        state: state,
        action: attributes[DBKeys.action] as FAction,
        value: attributes[DBKeys.value] as FTextTypeInput,
        groupValue: attributes[DBKeys.actionValue] as FTextTypeInput,
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
        RadioButtonTemplate.toCode(
          pageId,
          context,
          node,
          attributes[DBKeys.value] as FTextTypeInput,
          attributes[DBKeys.actionValue] as FTextTypeInput,
          loop ?? 0,
        ),
        loop ?? 0,
      );
}
