// Flutter imports:

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:teta_core/src/models/dataset.dart';
import 'package:teta_core/src/models/variable.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/templates/animations/anim_config_grid.dart';
import 'package:teta_widgets/src/elements/controls/control_model.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/controls/type.dart';
import 'package:teta_widgets/src/elements/index.dart';
import 'package:teta_widgets/src/elements/intrinsic_states/class.dart';
import 'package:teta_widgets/src/elements/nodes/categories.dart';
import 'package:teta_widgets/src/elements/nodes/children_enum.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';
import 'package:teta_widgets/src/elements/packages.dart';
import 'package:teta_widgets/src/elements/widgets/animations/anim_config_grid.dart';

const _globalType = NType.animationConfigGrid;

/// Instrict State of Align
final animationConfigGridIntrinsicStates = IntrinsicStates(
  nodeIcon: Assets.wIcons.anim_config_grid,
  nodeVideo: null,
  nodeDescription: null,
  advicedChildren: [],
  blockedTypes: [],
  synonymous: [NodeType.name(_globalType), 'animation', 'entry'],
  advicedChildrenCanHaveAtLeastAChild: [],
  displayName: NodeType.name(_globalType),
  type: _globalType,
  category: NodeCategories.animated,
  maxChildren: 1,
  canHave: ChildrenEnum.child,
  addChildLabels: [],
  gestures: [],
  permissions: [],
  packages: [pFlutterStaggeredAnimations],
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
class AnimationConfigGridBody extends NodeBody {
  @override
  // ignore: overridden_fields
  Map<String, dynamic> attributes = <String, dynamic>{
    DBKeys.value: FTextTypeInput(),
    DBKeys.duration: FTextTypeInput(),
    DBKeys.valueOfCondition: FTextTypeInput(),
  };

  @override
  List<ControlModel> get controls => [
        ControlObject(
          type: ControlType.value,
          key: DBKeys.value,
          value: attributes[DBKeys.value],
          title: 'Index',
          valueType: VariableType.int,
        ),
        ControlObject(
          type: ControlType.value,
          key: DBKeys.duration,
          value: attributes[DBKeys.duration],
          title: 'Duration',
          description:
              'Milliseconds value. Only integers are accepted. E.g. 1000 (= 1s), 2000 (= 2s) etc.',
          valueType: VariableType.int,
        ),
        ControlObject(
          type: ControlType.value,
          key: DBKeys.valueOfCondition,
          value: attributes[DBKeys.valueOfCondition],
          title: 'Number of columns',
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
      WAnimationConfigGridView(
        ValueKey(
          '''
          ${node.nid}
          $loop
          ${child ?? children}
          ${(attributes[DBKeys.value] as FTextTypeInput).toJson()}
          ${(attributes[DBKeys.duration] as FTextTypeInput).toJson()}
        ''',
        ),
        node: node,
        child: child,
        index: attributes[DBKeys.value] as FTextTypeInput,
        duration: attributes[DBKeys.duration] as FTextTypeInput,
        numberColumns: attributes[DBKeys.valueOfCondition] as FTextTypeInput,
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
  ) =>
      AnimConfigGridCodeTemplate.toCode(context, this, child, loop ?? 0);
}
