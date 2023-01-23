import 'package:flutter/material.dart';
import 'package:teta_core/teta_core.dart';

import 'package:teta_widgets/src/core/teta_widget/index.dart';
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/controls/control_model.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/index.dart';
import 'package:teta_widgets/src/elements/intrinsic_states/class.dart';
import 'package:teta_widgets/src/elements/nodes/categories.dart';
import 'package:teta_widgets/src/elements/nodes/children_enum.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';
import 'package:teta_widgets/src/elements/nodes/suggestion.dart';

import 'package:teta_widgets/src/elements/code/elevated_button.dart';

import '../widgets/elevated_button.dart';

/// GlobalType for [ElevatedButton] widget
const _globalType = NType.elevatedButton;

/// IntrinsicStates for [ElevatedButton] widget
final elevatedButtonIntrinsicStates = IntrinsicStates(
  nodeIcon: Assets.wIcons.textButton,
  nodeVideo: null,
  nodeDescription: null,
  advicedChildren: [
    NodeType.name(NType.text),
    NodeType.name(NType.gestureDetector),
  ],
  blockedTypes: [],
  synonymous: ['textbutton', 'outlinedbutton','geturedetector'],
  advicedChildrenCanHaveAtLeastAChild: [],
  displayName: NodeType.name(_globalType),
  type: _globalType,
  category: NodeCategories.input,
  maxChildren: 1,
  canHave: ChildrenEnum.child,
  addChildLabels: [],
  gestures: [ActionGesture.onTap, ActionGesture.onLongPress, ActionGesture.onHover,],
  permissions: [],
  packages: [],
  suggestionsTitle: 'Why use ElevatedButton in Teta?',
  suggestions: [
    const Suggestion(
      title: 'Why use ElevatedButton in Teta?',
      description: 'Test',
      // linkToOpen:
      //     'https://docs.teta.so/teta-docs/widget/input-widgets/textbutton',
    )
  ],
);

/// Body for [ElevatedButton] widget
/// ```dart
/// ElevatedButton({
///   required void Function()? onPressed,
 /// void Function()? onLongPress,
  ///void Function(bool)? onHover,
 /// void Function(bool)? onFocusChange,
 /// ButtonStyle? style,
 /// FocusNode? focusNode,
 /// bool autofocus = false,
 /// Clip clipBehavior = Clip.none,
 /// MaterialStatesController? statesController,
/// required Widget? child,
/// })
/// ```
class ElevatedButtonBody extends NodeBody {
  @override
  // ignore: overridden_fields
  Map<String, dynamic> attributes = <String, dynamic>{
    DBKeys.action: FAction(),
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
      WElevatedButton(
        ValueKey(
          '''
            ${state.toKey}
            ${child ?? children}
            ${(attributes[DBKeys.action] as FAction).toJson()}
            ''',
        ),
        state: state,
        child: child,
        action: attributes[DBKeys.action] as FAction,
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
        ElevatedButtonCodeTemplate.toCode(
          pageId,
          context,
          node,
          child,
          loop ?? 0,
        ),
        loop ?? 0,
      );
  }
