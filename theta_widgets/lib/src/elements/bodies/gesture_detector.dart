// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:theta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:theta_widgets/src/elements/code/templates/gesture_detector.dart';
import 'package:theta_widgets/src/elements/controls/control_model.dart';
import 'package:theta_widgets/src/elements/controls/key_constants.dart';
import 'package:theta_widgets/src/elements/features/action.dart';
import 'package:theta_widgets/src/elements/features/actions/enums/gestures.dart';
import 'package:theta_widgets/src/elements/features/page_transition.dart';
import 'package:theta_widgets/src/elements/intrinsic_states/class.dart';
import '../../../../../../teta_open_classes/lib/src/nodes/categories.dart';
import '../../../../../../teta_open_classes/lib/src/nodes/children_enum.dart';
import '../../../../../../teta_open_classes/lib/src/nodes/enum.dart';
import '../../../../../../teta_open_classes/lib/src/nodes/node.dart';
import '../../../../../../teta_open_classes/lib/src/nodes/node_body.dart';
import '../../../../../../teta_open_classes/lib/src/nodes/suggestion.dart';
import 'package:theta_widgets/src/elements/widgets/gesture_detector.dart';

const _globalType = NType.gestureDetector;

/// Instrict State of GestureDetector
final gestureDetectorIntrinsicStates = IntrinsicStates(
  nodeIcon: Assets.wIcons.gestureDetector,
  nodeVideo: null,
  nodeDescription: '''
      A widget that detects gestures. 
      Attempts to recognize gestures that correspond to its non-null callbacks. 
      If this widget has a child, 
      it defers to that child for its sizing behavior. 
      If it does not have a child, it grows to fit the parent instead. 
      By default a GestureDetector with an invisible child ignores touches
''',
  advicedChildren: [
    NodeType.name(NType.container),
    NodeType.name(NType.image),
  ],
  blockedTypes: [],
  synonymous: ['gesture', 'ontap', 'onpressed', 'click'],
  advicedChildrenCanHaveAtLeastAChild: [],
  displayName: NodeType.name(_globalType),
  type: _globalType,
  category: NodeCategories.unclassified,
  maxChildren: 1,
  canHave: ChildrenEnum.child,
  addChildLabels: [],
  gestures: [
    ActionGesture.onTap,
    ActionGesture.onLongPress,
    ActionGesture.onDoubleTap
  ],
  permissions: [],
  packages: [],
  suggestionsTitle: 'Why use Gesture Detector in Teta?',
  suggestions: [
    const Suggestion(
      title: 'Why use Gesture Detector in Teta?',
      description: 'Test',
      linkToOpen:
          'https://docs.teta.so/teta-docs/widget/input-widgets/gesture-detector',
    )
  ],
);

/// GestureDetector's body
class GestureDetectorBody extends NodeBody {
  @override
  // ignore: overridden_fields
  Map<String, dynamic> attributes = <String, dynamic>{
    DBKeys.action: NodeGestureActions.empty(),
    DBKeys.pageTransition: FPageTransition(),
  };

  @override
  List<ControlModel> get controls => [];

  @override
  Widget toWidget({
    required final TetaWidgetState state,
    final CNode? child,
    final List<CNode>? children,
  }) =>
      WGestureDetector(
        ValueKey(
          '''
          ${state.toKey}
          ${child ?? children}
          ${(attributes[DBKeys.action] as NodeGestureActions).toJson()}
          ''',
        ),
        state: state,
        child: child,
        action: attributes[DBKeys.action] as NodeGestureActions,
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
      GestureDetectorCodeTemplate.toCode(
        pageId,
        context,
        node,
        child,
        loop ?? 0,
      );
}
