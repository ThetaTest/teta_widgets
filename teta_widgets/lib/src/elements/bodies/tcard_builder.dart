// Flutter imports:
// ignore_for_file: lines_longer_than_80_chars

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:teta_core/src/models/variable.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/advanced/tcard_builder.dart';
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/controls/control_model.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/controls/type.dart';
import 'package:teta_widgets/src/elements/features/action.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/index.dart';
import 'package:teta_widgets/src/elements/features/dataset.dart';
import 'package:teta_widgets/src/elements/features/sizes.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_widgets/src/elements/intrinsic_states/class.dart';
import 'package:teta_widgets/src/elements/nodes/categories.dart';
import 'package:teta_widgets/src/elements/nodes/children_enum.dart';
import 'package:teta_widgets/src/elements/nodes/enum.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';
import 'package:teta_widgets/src/elements/nodes/suggestion.dart';
import 'package:teta_widgets/src/elements/packages.dart';
import 'package:teta_widgets/src/elements/widgets/tcard_builder.dart';

const _globalType = NType.tcardBuilder;

/// IS
final tcardBuilderIntrinsicStates = IntrinsicStates(
  nodeIcon: Assets.wIcons.tcardBuilder,
  nodeVideo: null,
  nodeDescription: null,
  advicedChildren: [
    NodeType.name(NType.container),
    NodeType.name(NType.column),
    NodeType.name(NType.stack),
  ],
  blockedTypes: [],
  synonymous: [
    'tcard builder',
    'tinder',
    'card',
    'online meet',
    'swipe',
    'pageview'
  ],
  advicedChildrenCanHaveAtLeastAChild: [],
  displayName: NodeType.name(_globalType),
  type: _globalType,
  category: NodeCategories.layout,
  maxChildren: null,
  canHave: ChildrenEnum.child,
  addChildLabels: [],
  gestures: [
    ActionGesture.swipeLeft,
    ActionGesture.swipeRight,
    ActionGesture.onEnd,
  ],
  permissions: [],
  packages: [pTCard],
  suggestionsTitle: 'Why use Tcard Builder in Teta?',
  suggestions: [
    const Suggestion(
      title: 'Why use Tcard Builder in Teta?',
      description: 'Test',
      linkToOpen:
          'https://docs.teta.so/teta-docs/widget/list-widgets/tcard-builder',
    )
  ],
);

/// Body
class TCardBuilderBody extends NodeBody {
  @override
  // ignore: overridden_fields
  Map<String, dynamic> attributes = <String, dynamic>{
    DBKeys.datasetInput: FDataset(),
    DBKeys.flag: false,
    DBKeys.action: FAction(),
    DBKeys.width: FSize(size: '400', unit: SizeUnit.pixel),
    DBKeys.height: FSize(size: '600', unit: SizeUnit.pixel),
    DBKeys.value: FTextTypeInput(value: '20'),
    DBKeys.valueOfCondition: FTextTypeInput(value: '500'),
  };

  @override
  List<ControlModel> get controls => [
        ControlObject(
          type: ControlType.datasetType,
          key: DBKeys.datasetInput,
          value: attributes[DBKeys.datasetInput],
          valueType: VariableType.string,
        ),
        FlagControlObject(
          title: 'Lock Y Axis',
          key: DBKeys.flag,
          value: attributes[DBKeys.flag],
          description: 'Lock Y Axis Gesture',
        ),
        ControlObject(
          type: ControlType.value,
          key: DBKeys.value,
          value: attributes[DBKeys.value],
          title: 'Slide Speed',
          description:
              'How quick should it be slided? less is slower. 10 is a bit slow. 20 is a quick enough.',
          valueType: VariableType.int,
        ),
        ControlObject(
          type: ControlType.value,
          key: DBKeys.valueOfCondition,
          value: attributes[DBKeys.valueOfCondition],
          title: 'Delay Slide For',
          description:
              'How long does it have to wait until the next slide is sliable? less is quicker. 100 is fast enough. 500 is a bit slow.',
          valueType: VariableType.int,
        ),
      ];

  @override
  Widget toWidget({
    required final TetaWidgetState state,
    final CNode? child,
    final List<CNode>? children,
  }) =>
      WTCardBuilder(
        ValueKey(
          '''
            ${state.toKey}
            ${child ?? children}
            ${(attributes[DBKeys.datasetInput] as FDataset).toJson()}
            ${(attributes[DBKeys.action] as FAction).toJson()}
            ${(attributes[DBKeys.value] as FTextTypeInput).toJson()}
            ${(attributes[DBKeys.valueOfCondition] as FTextTypeInput).toJson()}
            ${attributes[DBKeys.flag] as bool}
            ''',
        ),
        state: state,
        child: child,
        value: attributes[DBKeys.datasetInput] as FDataset,
        lockYAxis: attributes[DBKeys.flag] as bool,
        action: attributes[DBKeys.action] as FAction,
        slideSpeed: attributes[DBKeys.value] as FTextTypeInput,
        delaySlideFor: attributes[DBKeys.valueOfCondition] as FTextTypeInput,
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
        TCardBuilderCodeTemplate.toCode(context, pageId, node, child, loop),
        loop ?? 0,
      );
}
