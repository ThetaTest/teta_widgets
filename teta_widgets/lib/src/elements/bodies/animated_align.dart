// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:teta_core/src/models/dataset.dart';
import 'package:teta_core/src/models/variable.dart';

// Project imports:
import 'package:teta_widgets/src/elements/code/templates/animated_align.dart';
import 'package:teta_widgets/src/elements/controls/control_model.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/controls/type.dart';
import 'package:teta_widgets/src/elements/features/align.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_widgets/src/elements/intrinsic_states/class.dart';
import 'package:teta_widgets/src/elements/nodes/categories.dart';
import 'package:teta_widgets/src/elements/nodes/children_enum.dart';
import 'package:teta_widgets/src/elements/nodes/enum.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';
import 'package:teta_widgets/src/elements/widgets/animated_align.dart';

const _globalType = NType.animatedAlign;

/// Instrict State of AnimatedAlign
final animatedAlignIntrinsicStates = IntrinsicStates(
  nodeIcon: Assets.wIcons.animatedAlign,
  nodeVideo: null,
  nodeDescription: null,
  advicedChildren: [],
  blockedTypes: [],
  synonymous: [
    NodeType.name(_globalType),
    'animatedAlign',
    'baseline',
    'bottom'
  ],
  advicedChildrenCanHaveAtLeastAChild: [],
  displayName: NodeType.name(_globalType),
  type: _globalType,
  category: NodeCategories.animated,
  maxChildren: 1,
  canHave: ChildrenEnum.child,
  addChildLabels: [],
  gestures: [],
);

/// Set of funcs to use Align widget
/// ```dart
/// Align({
///   Key? key,
///   AlignmentGeometry alignment,
///   double? widthFactor,
///   double? heightFactor,
///   Widget? child
/// })
/// ```
class AnimatedAlignBody extends NodeBody {
  @override
  // ignore: overridden_fields
  Map<String, dynamic> attributes = <String, dynamic>{
    DBKeys.align: FAlign(),
    DBKeys.duration: FTextTypeInput(value: '1000'),
  };

  @override
  List<ControlModel> get controls => [
        ControlObject(
          title: 'Align',
          type: ControlType.align,
          key: DBKeys.align,
          value: attributes[DBKeys.align],
        ),
        ControlObject(
          title: 'Duration',
          type: ControlType.value,
          key: DBKeys.duration,
          value: attributes[DBKeys.duration],
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
      WAnimatedAlign(
        ValueKey(
          '''
          ${node.nid}
          $loop
            ${child ?? children}
          ${(attributes[DBKeys.align] as FAlign).align}
          ${(attributes[DBKeys.duration] as FTextTypeInput).get(params, states, dataset, forPlay, loop)}
        ''',
        ),
        node: node,
        child: child,
        align: attributes[DBKeys.align] as FAlign,
        duration: attributes[DBKeys.duration] as FTextTypeInput,
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
      animatedAlignCodeTemplate(context, this, child, loop);
}
