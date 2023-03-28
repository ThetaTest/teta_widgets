// Flutter imports:

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:theta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:theta_widgets/src/elements/code/templates/animations/fade_in.dart';
import 'package:theta_widgets/src/elements/controls/control_model.dart';
import 'package:theta_widgets/src/elements/index.dart';
import 'package:theta_widgets/src/elements/intrinsic_states/class.dart';
import 'package:theta_widgets/src/elements/nodes/categories.dart';
import 'package:theta_widgets/src/elements/nodes/children_enum.dart';
import 'package:theta_widgets/src/elements/nodes/node_body.dart';
import 'package:theta_widgets/src/elements/packages.dart';
import 'package:theta_widgets/src/elements/widgets/animations/fade_in.dart.dart';

const _globalType = NType.fadeInAnimation;

/// Instrict State of Align
final fadeInAnimationIntrinsicStates = IntrinsicStates(
  nodeIcon: Assets.wIcons.fadeIn,
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
class FadeInAnimationBody extends NodeBody {
  @override
  // ignore: overridden_fields
  Map<String, dynamic> attributes = <String, dynamic>{};

  @override
  List<ControlModel> get controls => [];

  @override
  Widget toWidget({
    required final TetaWidgetState state,
    final CNode? child,
    final List<CNode>? children,
  }) =>
      WFadeInAnimation(
        ValueKey(
          '''
          ${state.toKey}
          ${child ?? children}
        ''',
        ),
        state: state,
        child: child,
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
      FadeInCodeTemplate.toCode(context, this, child);
}
