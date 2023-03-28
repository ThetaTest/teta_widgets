// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:theta_widgets/src/core/teta_widget/index.dart';
import 'package:theta_widgets/src/elements/code/snippets.dart';
// Project imports:
import 'package:theta_widgets/src/elements/code/templates/outlinedbutton.dart';
import 'package:theta_widgets/src/elements/controls/control_model.dart';
import 'package:theta_widgets/src/elements/controls/key_constants.dart';
import 'package:theta_widgets/src/elements/features/action.dart';
import 'package:theta_widgets/src/elements/features/actions/enums/gestures.dart';
import 'package:theta_widgets/src/elements/features/page_transition.dart';
import 'package:theta_widgets/src/elements/features/text_type_input.dart';
import 'package:theta_widgets/src/elements/intrinsic_states/class.dart';
import '../../../../../../teta_open_classes/lib/src/nodes/categories.dart';
import '../../../../../../teta_open_classes/lib/src/nodes/children_enum.dart';
import '../../../../../../teta_open_classes/lib/src/nodes/enum.dart';
import '../../../../../../teta_open_classes/lib/src/nodes/node.dart';
import '../../../../../../teta_open_classes/lib/src/nodes/node_body.dart';
import 'package:theta_widgets/src/elements/widgets/outlinedbutton.dart';

const _globalType = NType.outlinedButton;

/// IS
final outlinedButtonIntrinsicStates = IntrinsicStates(
  nodeIcon: Assets.wIcons.outlinedButton,
  nodeVideo: null,
  nodeDescription: null,
  advicedChildren: [NodeType.name(NType.text), NodeType.name(NType.container)],
  blockedTypes: [],
  synonymous: ['outlinedbutton', 'textbutton', 'text'],
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
);

/// Body
class OutlinedButtonBody extends NodeBody {
  @override
  // ignore: overridden_fields
  Map<String, dynamic> attributes = <String, dynamic>{
    DBKeys.action: NodeGestureActions.empty(),
    DBKeys.actionValue: FTextTypeInput(),
    DBKeys.pageTransition: FPageTransition,
  };

  @override
  List<ControlModel> get controls => [];

  @override
  Widget toWidget({
    required final TetaWidgetState state,
    final CNode? child,
    final List<CNode>? children,
  }) =>
      WOutlinedButton(
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
        OutlinedButtonCodeTemplate.toCode(
          pageId,
          context,
          node,
          child,
          loop ?? 0,
        ),
        loop ?? 0,
      );
}
