// Flutter imports:
// ignore_for_file: lines_longer_than_80_chars

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:teta_core/src/models/dataset.dart';
import 'package:teta_core/src/models/variable.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/templates/text.dart';
import 'package:teta_widgets/src/elements/controls/control_model.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/controls/type.dart';
import 'package:teta_widgets/src/elements/features/text_style.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_widgets/src/elements/intrinsic_states/class.dart';
import 'package:teta_widgets/src/elements/nodes/categories.dart';
import 'package:teta_widgets/src/elements/nodes/children_enum.dart';
import 'package:teta_widgets/src/elements/nodes/enum.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';
import 'package:teta_widgets/src/elements/widgets/text.dart';

/// GlobalType for [Text] widget
const _globalType = NType.text;

/// IntrinsicStates for [Text] widget
final textIntrinsicStates = IntrinsicStates(
  nodeIcon: Assets.wIcons.text,
  nodeVideo: null,
  nodeDescription: null,
  advicedChildren: [],
  blockedTypes: [],
  synonymous: ['text', 'label', 'title'],
  advicedChildrenCanHaveAtLeastAChild: [],
  displayName: NodeType.name(_globalType),
  type: _globalType,
  category: NodeCategories.basic,
  maxChildren: 0,
  canHave: ChildrenEnum.none,
  addChildLabels: [],
  gestures: [],
  permissions: [],
  packages: [],
);

/// Body for [Text] widget
class TextBody extends NodeBody {
  @override
  // ignore: overridden_fields
  Map<String, dynamic> attributes = <String, dynamic>{
    DBKeys.value: FTextTypeInput(value: 'text'),
    DBKeys.textStyle: FTextStyle(),
    DBKeys.isFullWidth: false,
    DBKeys.maxLines: FTextTypeInput(value: '1'),
  };

  @override
  List<ControlModel> get controls => [
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
          valueType: VariableType.string,
        ),
        ControlObject(
          type: ControlType.text,
          key: DBKeys.textStyle,
          value: attributes[DBKeys.textStyle],
          valueType: VariableType.string,
        ),
        ControlObject(
          title: 'Max Lines',
          type: ControlType.value,
          key: DBKeys.maxLines,
          value: attributes[DBKeys.maxLines] as FTextTypeInput,
          description:
              'An optional maximum number of lines for the text to span, wrapping if necessary. If the text exceeds the given number of lines, it will be truncated according to overflow.',
          valueType: VariableType.int,
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
      WText(
        ValueKey(
          '''
            ${node.nid}
            $loop
            ${child ?? children}
            ${(attributes[DBKeys.value] as FTextTypeInput? ?? FTextTypeInput()).toJson()}
            ${(attributes[DBKeys.textStyle] as FTextStyle? ?? FTextStyle()).toJson()}
            ${(attributes[DBKeys.maxLines] as FTextTypeInput).toJson()}
            ${attributes[DBKeys.isFullWidth] as bool}
            ''',
        ),
        node: node,
        isFullWidth: attributes[DBKeys.isFullWidth] as bool,
        value: attributes[DBKeys.value] as FTextTypeInput? ?? FTextTypeInput(),
        textStyle: attributes[DBKeys.textStyle] as FTextStyle? ?? FTextStyle(),
        maxLines: attributes[DBKeys.maxLines] as FTextTypeInput,
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
  ) {
    return TextCodeTemplate.toCode(context, this, loop);
  }
}
