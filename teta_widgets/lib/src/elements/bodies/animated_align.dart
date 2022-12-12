// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:teta_core/src/models/variable.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
import 'package:teta_widgets/src/elements/code/snippets.dart';
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
  category: NodeCategories.unclassified,
  maxChildren: 1,
  canHave: ChildrenEnum.child,
  addChildLabels: [],
  gestures: [],
  permissions: [],
  packages: [],
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
          valueType: VariableType.string,
        ),
        ControlObject(
          title: 'Duration',
          type: ControlType.value,
          key: DBKeys.duration,
          value: attributes[DBKeys.duration],
          description:
              'Milliseconds value. Only integers are accepted. E.g. 1000 (= 1s), 2000 (= 2s) etc.',
          valueType: VariableType.int,
        ),
      ];

  @override
  Widget toWidget({
    required final TetaWidgetState state,
    final CNode? child,
    final List<CNode>? children,
  }) =>
      WAnimatedAlign(
        ValueKey(
          '''
          ${state.toKey}
          ${child ?? children}
          ${(attributes[DBKeys.align] as FAlign).align}
          ${(attributes[DBKeys.duration] as FTextTypeInput).toJson()}
        ''',
        ),
        state: state,
        child: child,
        align: attributes[DBKeys.align] as FAlign,
        duration: attributes[DBKeys.duration] as FTextTypeInput,
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
        AnimatedAlignCodeTemplate.toCode(context, this, child, loop),
        loop ?? 0,
      );
}
