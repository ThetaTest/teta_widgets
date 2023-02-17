// Flutter imports:
// ignore_for_file: lines_longer_than_80_chars

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:teta_core/src/models/variable.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
import 'package:teta_widgets/src/elements/code/snippets.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/templates/text.dart';
import 'package:teta_widgets/src/elements/index.dart';
import 'package:teta_widgets/src/elements/intrinsic_states/class.dart';
import 'package:teta_widgets/src/elements/nodes/categories.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';
import 'package:teta_widgets/src/elements/nodes/suggestion.dart';

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
  suggestionsTitle: 'Why use Text in Teta?',
  suggestions: [
    const Suggestion(
      title: 'Why use Text in Teta?',
      description: 'Test',
      linkToOpen: 'https://docs.teta.so/teta-docs/widget/basic-widgets/text',
    )
  ],
);

/// Body for [Text] widget
class TextBody extends NodeBody {
  @override
  // ignore: overridden_fields
  Map<String, dynamic> attributes = <String, dynamic>{
    DBKeys.value: FTextTypeInput(value: 'text'),
    DBKeys.textStyle: FTextStyle(
      textStyleModel: 'Headline',
      fill: FFill(paletteStyle: 'Text / Primary'),
    ),
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
    required final TetaWidgetState state,
    final CNode? child,
    final List<CNode>? children,
  }) =>
      WText(
        ValueKey(
          '''
            ${state.toKey}
            ${child ?? children}
            ${(attributes[DBKeys.value] as FTextTypeInput? ?? FTextTypeInput()).toJson()}
            ${(attributes[DBKeys.textStyle] as FTextStyle? ?? FTextStyle()).toJson()}
            ${(attributes[DBKeys.maxLines] as FTextTypeInput).toJson()}
            ${attributes[DBKeys.isFullWidth] as bool}
            ''',
        ),
        state: state,
        isFullWidth: attributes[DBKeys.isFullWidth] as bool,
        value: attributes[DBKeys.value] as FTextTypeInput? ?? FTextTypeInput(),
        textStyle: attributes[DBKeys.textStyle] as FTextStyle? ?? FTextStyle(),
        maxLines: attributes[DBKeys.maxLines] as FTextTypeInput,
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
    return CS.defaultWidgets(
      context,
      node,
      pageId,
      TextCodeTemplate.toCode(context, this, loop),
      loop ?? 0,
    );
  }
}
