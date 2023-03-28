// Flutter imports:

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:theta_models/theta_models.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/templates/animations/anim_config_list.dart';
import 'package:teta_widgets/src/elements/controls/control_model.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/controls/type.dart';
import 'package:teta_widgets/src/elements/index.dart';
import 'package:teta_widgets/src/elements/intrinsic_states/class.dart';
import '../../../../../../../teta_open_classes/lib/src/nodes/categories.dart';
import '../../../../../../../teta_open_classes/lib/src/nodes/children_enum.dart';
import '../../../../../../../teta_open_classes/lib/src/nodes/node_body.dart';
import 'package:teta_widgets/src/elements/packages.dart';
import 'package:teta_widgets/src/elements/widgets/animations/anim_config_list.dart';

const _globalType = NType.animationConfigList;

/// Instrict State of Align
final animationConfigListIntrinsicStates = IntrinsicStates(
  nodeIcon: Assets.wIcons.animConfigList,
  nodeVideo: null,
  nodeDescription: null,
  advicedChildren: [],
  blockedTypes: [],
  synonymous: [NodeType.name(_globalType), 'animation', 'entry'],
  advicedChildrenCanHaveAtLeastAChild: [],
  displayName: NodeType.name(_globalType),
  type: _globalType,
  category: NodeCategories.animations,
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
class AnimationConfigListBody extends NodeBody {
  @override
  // ignore: overridden_fields
  Map<String, dynamic> attributes = <String, dynamic>{
    DBKeys.value: FTextTypeInput(),
    DBKeys.duration: FTextTypeInput(),
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
      ];

  @override
  Widget toWidget({
    required final TetaWidgetState state,
    final CNode? child,
    final List<CNode>? children,
  }) =>
      WAnimationConfigurationListView(
        ValueKey(
          '''
          ${state.toKey}
          ${child ?? children}
          ${(attributes[DBKeys.value] as FTextTypeInput).toJson()}
          ${(attributes[DBKeys.duration] as FTextTypeInput).toJson()}
        ''',
        ),
        state: state,
        child: child,
        index: attributes[DBKeys.value] as FTextTypeInput,
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
      AnimConfigListCodeTemplate.toCode(context, this, child, loop ?? 0);
}
