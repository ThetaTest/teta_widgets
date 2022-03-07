// Flutter imports:
// ignore_for_file: lines_longer_than_80_chars

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:teta_core/src/models/dataset.dart';
import 'package:teta_core/src/models/variable.dart';

// Project imports:
import 'package:teta_widgets/src/elements/code/templates/textfield.dart';
import 'package:teta_widgets/src/elements/controls/control_model.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/controls/type.dart';
import 'package:teta_widgets/src/elements/features/action.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/gestures.dart';
import 'package:teta_widgets/src/elements/features/border_radius.dart';
import 'package:teta_widgets/src/elements/features/fill.dart';
import 'package:teta_widgets/src/elements/features/keyboard_type.dart';
import 'package:teta_widgets/src/elements/features/margins.dart';
import 'package:teta_widgets/src/elements/features/sizes.dart';
import 'package:teta_widgets/src/elements/features/text_style.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_widgets/src/elements/intrinsic_states/class.dart';
import 'package:teta_widgets/src/elements/nodes/categories.dart';
import 'package:teta_widgets/src/elements/nodes/children_enum.dart';
import 'package:teta_widgets/src/elements/nodes/enum.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';
import 'package:teta_widgets/src/elements/widgets/textfield.dart';

/// GlobalType for TextField widget
const _globalType = NType.textField;

/// IntrinsicStates for TextField widget
final textFieldIntrinsicStates = IntrinsicStates(
  nodeIcon: Assets.wIcons.textfield,
  nodeVideo: null,
  nodeDescription: null,
  advicedChildren: [],
  blockedTypes: [],
  synonymous: ['textfield', 'form', 'input'],
  advicedChildrenCanHaveAtLeastAChild: [],
  displayName: NodeType.name(_globalType),
  type: _globalType,
  category: NodeCategories.input,
  maxChildren: 0,
  canHave: ChildrenEnum.none,
  addChildLabels: [],
  gestures: [ActionGesture.onChange, ActionGesture.onSubmitted],
);

/// Body for TextField widget
/// Original widget for Flutter:
/// ```dart
/// TextField({
///   Key? key,
///   TextEditingController? controller,
///   FocusNode? focusNode,
///   InputDecoration? decoration,
///   TextInputType? keyboardType,
///   TextInputAction? textInputAction,
///   TextCapitalization textCapitalization,
///   TextStyle? style,
///   StrutStyle? strutStyle,
///   TextAlign textAlign,
///   TextAlignVertical? textAlignVertical,
///   TextDirection? textDirection,
///   bool readOnly,
///   ToolbarOptions? toolbarOptions,
///   bool? showCursor,
///   bool autofocus,
///   String obscuringCharacter,
///   bool obscureText,
///   bool autocorrect,
///   SmartDashesType? smartDashesType,
///   SmartQuotesType? smartQuotesType,
///   bool enableSuggestions,
///   int? maxLines,
///   int? minLines,
///   bool expands,
///   int? maxLength,
///   MaxLengthEnforcement? maxLengthEnforcement,
///   ValueChanged<String>? onChanged,
///   VoidCallback? onEditingComplete,
///   ValueChanged<String>? onSubmitted,
///   AppPrivateCommandCallback? onAppPrivateCommand,
///   List<TextInputFormatter>? inputFormatters,
///   bool? enabled,
///   double cursorWidth,
///   double? cursorHeight,
///   Radius? cursorRadius,
///   Color? cursorColor,
///   BoxHeightStyle selectionHeightStyle,
///   BoxWidthStyle selectionWidthStyle,
///   Brightness? keyboardAppearance,
///   EdgeInsets scrollPadding,
///   DragStartBehavior dragStartBehavior,
///   bool enableInteractiveSelection,
///   TextSelectionControls? selectionControls,
///   GestureTapCallback? onTap,
///   MouseCursor? mouseCursor,
///   InputCounterWidgetBuilder? buildCounter,
///   ScrollController? scrollController,
///   ScrollPhysics? scrollPhysics,
///   Iterable<String>? autofillHints,
///   String? restorationId
/// })
/// ```
class TextFieldBody extends NodeBody {
  @override
  // ignore: overridden_fields
  Map<String, dynamic> attributes = <String, dynamic>{
    DBKeys.value: FTextTypeInput(),
    DBKeys.labelText: FTextTypeInput(value: 'Placeholder'),
    DBKeys.textStyle: FTextStyle(),
    DBKeys.margins: FMargins(margins: ['16', '8', '16', '8']),
    DBKeys.padding: FMargins(margins: ['16', '0', '0', '0']),
    DBKeys.fill: FFill(),
    DBKeys.width: FSize(size: 'max'),
    DBKeys.maxLines: FTextTypeInput(value: '1'),
    DBKeys.minLines: FTextTypeInput(value: '1'),
    DBKeys.maxLenght: FTextTypeInput(),
    DBKeys.borderRadius: FBorderRadius(),
    DBKeys.showCursor: true,
    DBKeys.autoCorrect: false,
    DBKeys.obscureText: false,
    DBKeys.action: FAction(),
  };

  @override
  List<ControlModel> get controls => [
        ControlObject(
          type: ControlType.action,
          key: DBKeys.action,
          value: attributes[DBKeys.action],
        ),
        ControlObject(
          type: ControlType.margins,
          key: DBKeys.margins,
          value: attributes[DBKeys.margins],
        ),
        ControlObject(
          type: ControlType.padding,
          key: DBKeys.padding,
          value: attributes[DBKeys.padding],
        ),
        ControlObject(
          type: ControlType.value,
          key: DBKeys.value,
          value: attributes[DBKeys.value],
        ),
        ControlObject(
          title: 'Hint text',
          type: ControlType.value,
          key: DBKeys.labelText,
          value: attributes[DBKeys.labelText],
          description:
              'Text that suggests what sort of input the field accepts.',
        ),
        ControlObject(
          type: ControlType.text,
          key: DBKeys.textStyle,
          value: attributes[DBKeys.textStyle],
        ),
        SizeControlObject(
          type: ControlType.size,
          key: DBKeys.width,
          title: 'Size',
          isWidth: true,
          value: attributes[DBKeys.width] as FSize,
        ),
        FillControlObject(
          title: 'Background',
          key: DBKeys.fill,
          value: attributes[DBKeys.fill] as FFill,
          isStyled: false,
          isImageEnabled: false,
          isNoneEnabled: false,
          isOnlySolid: true,
        ),
        ControlObject(
          type: ControlType.borderRadius,
          key: DBKeys.borderRadius,
          value: attributes[DBKeys.borderRadius],
        ),
        FlagControlObject(
          title: 'Obscure Text',
          key: DBKeys.obscureText,
          value: attributes[DBKeys.obscureText] as bool,
          description:
              'Whether to hide the text being edited (e.g., for passwords).',
        ),
        FlagControlObject(
          title: 'Auto Correct',
          key: DBKeys.autoCorrect,
          value: attributes[DBKeys.autoCorrect] as bool,
          description: 'Whether to enable autocorrection.',
        ),
        FlagControlObject(
          title: 'Show Cursor',
          key: DBKeys.showCursor,
          value: attributes[DBKeys.showCursor] as bool,
          description: 'Whether to show cursor.',
        ),
        ControlObject(
          type: ControlType.value,
          title: 'Max Lines',
          key: DBKeys.maxLines,
          value: attributes[DBKeys.maxLines],
          description:
              'The maximum number of lines to show at one time, wrapping if necessary.',
        ),
        ControlObject(
          type: ControlType.value,
          title: 'Min Lines',
          key: DBKeys.minLines,
          value: attributes[DBKeys.minLines],
          description:
              'The minimum number of lines to occupy when the content spans fewer lines.',
        ),
        ControlObject(
          type: ControlType.value,
          title: 'Max Length',
          key: DBKeys.maxLenght,
          value: attributes[DBKeys.maxLenght],
          description:
              'The maximum number of characters to allow in the text field.',
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
      WTextField(
        ValueKey(
          '''
            ${node.nid}
            $loop
            ${child ?? children}
            ${(attributes[DBKeys.value] as FTextTypeInput? ?? FTextTypeInput()).toJson()}
            ${(attributes[DBKeys.textStyle] as FTextStyle? ?? FTextStyle()).toJson()}
            ${(attributes[DBKeys.labelText] as FTextTypeInput? ?? FTextTypeInput()).toJson()}
            ${(attributes[DBKeys.fill] as FFill).toJson()}
            ${(attributes[DBKeys.width] as FSize).toJson()}
            ${(attributes[DBKeys.margins] as FMargins).toJson()}
            ${(attributes[DBKeys.padding] as FMargins).toJson()}
            ${(attributes[DBKeys.action] as FAction).toJson()}
            ${(attributes[DBKeys.keyboardType] as FKeyboardType? ?? FKeyboardType()).toJson()}
            ${(attributes[DBKeys.borderRadius] as FBorderRadius).toJson()}
            ${(attributes[DBKeys.maxLenght] as FTextTypeInput?)?.toJson()}
            ${(attributes[DBKeys.maxLines] as FTextTypeInput?)?.toJson()}
            ${(attributes[DBKeys.minLines] as FTextTypeInput?)?.toJson()}
            ${(attributes[DBKeys.cursorColor] as FFill?)?.toJson()}
            ${(attributes[DBKeys.hintTextColor] as FFill?)?.toJson()}
            ${attributes[DBKeys.showCursor] as bool? ?? false}
            ${attributes[DBKeys.autoCorrect] as bool? ?? false}
            ${attributes[DBKeys.obscureText] as bool? ?? false}
            ''',
        ),
        node: node,
        value: attributes[DBKeys.value] as FTextTypeInput? ?? FTextTypeInput(),
        textStyle: attributes[DBKeys.textStyle] as FTextStyle? ?? FTextStyle(),
        labelText:
            attributes[DBKeys.labelText] as FTextTypeInput? ?? FTextTypeInput(),
        fill: attributes[DBKeys.fill] as FFill,
        width: attributes[DBKeys.width] as FSize,
        margins: attributes[DBKeys.margins] as FMargins,
        paddings: attributes[DBKeys.padding] as FMargins,
        action: attributes[DBKeys.action] as FAction,
        keyboardType: attributes[DBKeys.keyboardType] as FKeyboardType,
        borderRadius: attributes[DBKeys.borderRadius] as FBorderRadius,
        maxLenght: attributes[DBKeys.maxLenght] as FTextTypeInput,
        maxLines: attributes[DBKeys.maxLines] as FTextTypeInput,
        minLines: attributes[DBKeys.minLines] as FTextTypeInput,
        showCursor: attributes[DBKeys.showCursor] as bool? ?? false,
        autoCorrect: attributes[DBKeys.autoCorrect] as bool? ?? false,
        obscureText: attributes[DBKeys.obscureText] as bool? ?? false,
        cursorColor: attributes[DBKeys.cursorColor] as FFill,
        hintTextColor: attributes[DBKeys.hintTextColor] as FFill,
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
      textFieldCodeTemplate(context, this, node, child, loop);
}