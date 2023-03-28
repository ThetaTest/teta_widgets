// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:theta_widgets/src/core/teta_widget/index.dart';
import 'package:theta_widgets/src/elements/code/snippets.dart';
// Project imports:
import 'package:theta_widgets/src/elements/code/templates/textbutton.dart';
import 'package:theta_widgets/src/elements/controls/control_model.dart';
import 'package:theta_widgets/src/elements/controls/key_constants.dart';
import 'package:theta_widgets/src/elements/features/action.dart';
import 'package:theta_widgets/src/elements/features/actions/enums/gestures.dart';
import 'package:theta_widgets/src/elements/features/page_transition.dart';
import 'package:theta_widgets/src/elements/intrinsic_states/class.dart';
import 'package:theta_widgets/src/elements/nodes/categories.dart';
import 'package:theta_widgets/src/elements/nodes/children_enum.dart';
import 'package:theta_widgets/src/elements/nodes/enum.dart';
import 'package:theta_widgets/src/elements/nodes/node.dart';
import 'package:theta_widgets/src/elements/nodes/node_body.dart';
import 'package:theta_widgets/src/elements/nodes/suggestion.dart';
import 'package:theta_widgets/src/elements/widgets/textbutton.dart';

/// GlobalType for [TextButton] widget
const _globalType = NType.textButton;

/// IntrinsicStates for [TextButton] widget
final textButtonIntrinsicStates = IntrinsicStates(
  nodeIcon: Assets.wIcons.textButton,
  nodeVideo: null,
  nodeDescription: null,
  advicedChildren: [
    NodeType.name(NType.text),
    NodeType.name(NType.gestureDetector),
  ],
  blockedTypes: [],
  synonymous: ['textbutton', 'outlinedbutton', 'text'],
  advicedChildrenCanHaveAtLeastAChild: [],
  displayName: NodeType.name(_globalType),
  type: _globalType,
  category: NodeCategories.unclassified,
  maxChildren: 1,
  canHave: ChildrenEnum.child,
  addChildLabels: [],
  gestures: [ActionGesture.onTap],
  permissions: [],
  packages: [],
  suggestionsTitle: 'Why use Textbutton in Teta?',
  suggestions: [
    const Suggestion(
      title: 'Why use Textbutton in Teta?',
      description: 'Test',
      linkToOpen:
          'https://docs.teta.so/teta-docs/widget/input-widgets/textbutton',
    )
  ],
);

/// Body for [TextButton] widget
/// ```dart
/// TextButton({
///   Key? key,
///   required VoidCallback? onPressed,
///   VoidCallback? onLongPress,
///   ButtonStyle? style,
///   FocusNode? focusNode,
///   bool autofocus = false,
///   Clip clipBehavior = Clip.none,
///   required Widget child
/// })
/// ```
class TextButtonBody extends NodeBody {
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
      WTextButton(
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
      CS.defaultWidgets(
        context,
        node,
        pageId,
        TextButtonCodeTemplate.toCode(
          pageId,
          context,
          node,
          child,
          loop ?? 0,
        ),
        loop ?? 0,
      );
}
