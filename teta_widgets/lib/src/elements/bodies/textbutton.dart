// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:teta_core/src/models/dataset.dart';
import 'package:teta_core/src/models/variable.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/templates/textbutton.dart';
import 'package:teta_widgets/src/elements/controls/control_model.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/controls/type.dart';
import 'package:teta_widgets/src/elements/features/action.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/gestures.dart';
import 'package:teta_widgets/src/elements/features/page_transition.dart';
import 'package:teta_widgets/src/elements/intrinsic_states/class.dart';
import 'package:teta_widgets/src/elements/nodes/categories.dart';
import 'package:teta_widgets/src/elements/nodes/children_enum.dart';
import 'package:teta_widgets/src/elements/nodes/enum.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';
import 'package:teta_widgets/src/elements/widgets/textbutton.dart';

/// GlobalType for [TextButton] widget
const _globalType = NType.textButton;

/// IntrinsicStates for [TextButton] widget
final textButtonIntrinsicStates = IntrinsicStates(
  nodeIcon: Assets.wIcons.textbutton,
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
  category: NodeCategories.input,
  maxChildren: 1,
  canHave: ChildrenEnum.child,
  addChildLabels: [],
  gestures: [ActionGesture.onTap],
  permissions: [],
  packages: [],
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
    DBKeys.action: FAction(),
    DBKeys.pageTransition: FPageTransition(),
  };

  @override
  List<ControlModel> get controls => [
        ControlObject(
          type: ControlType.action,
          key: DBKeys.action,
          value: attributes[DBKeys.action],
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
      WTextButton(
        ValueKey(
          '''
            ${node.nid}
            $loop
            ${child ?? children}
            ${(attributes[DBKeys.action] as FAction).toJson()}
            ''',
        ),
        node: node,
        child: child,
        forPlay: forPlay,
        action: attributes[DBKeys.action] as FAction,
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
      TextButtonCodeTemplate.toCode(
        pageId,
        context,
        node,
        child,
        loop ?? 0,
      );
}
