// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
import 'package:teta_widgets/src/elements/code/snippets.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/templates/microsoft.dart';
import 'package:teta_widgets/src/elements/controls/control_model.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/features/action.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/gestures.dart';
import 'package:teta_widgets/src/elements/features/page_transition.dart';
import 'package:teta_widgets/src/elements/features/sizes.dart';
import 'package:teta_widgets/src/elements/intrinsic_states/class.dart';
import 'package:teta_widgets/src/elements/nodes/categories.dart';
import 'package:teta_widgets/src/elements/nodes/children_enum.dart';
import 'package:teta_widgets/src/elements/nodes/enum.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';
import 'package:teta_widgets/src/elements/packages.dart';
import 'package:teta_widgets/src/elements/widgets/cta/microsoft.dart';

const _globalType = NType.loginWithMicrosoft;

/// Instrict State of Facebook Login
final loginMicrosoftIntrinsicStates = IntrinsicStates(
  nodeIcon: Assets.wIcons.loginFacebook,
  nodeVideo: null,
  nodeDescription: null,
  advicedChildren: [
    NodeType.name(NType.container),
    NodeType.name(NType.column),
    NodeType.name(NType.row),
  ],
  blockedTypes: [],
  synonymous: ['microsoft', 'login', 'cta', 'button'],
  advicedChildrenCanHaveAtLeastAChild: [],
  displayName: 'Login with Microsoft',
  type: _globalType,
  category: NodeCategories.form,
  maxChildren: 0,
  canHave: ChildrenEnum.none,
  addChildLabels: [],
  gestures: <ActionGesture>[ActionGesture.onTap, ActionGesture.onLongPress],
  permissions: [],
  packages: [pAuthButton],
);

/// Facebook Login's body
class LoginWithMicrosoftBody extends NodeBody {
  @override
  // ignore: overridden_fields
  Map<String, dynamic> attributes = <String, dynamic>{
    DBKeys.pageTransition: FPageTransition(),
    DBKeys.action: NodeGestureActions.empty(),
    DBKeys.width: FSize(size: 'max', unit: SizeUnit.pixel),
    DBKeys.height: FSize(size: '42', unit: SizeUnit.pixel),
  };

  @override
  List<ControlModel> get controls => [
        SizesControlObject(
          keys: const [DBKeys.width, DBKeys.height],
          values: <FSize>[
            attributes[DBKeys.width] as FSize,
            attributes[DBKeys.height] as FSize,
          ],
        ),
      ];

  @override
  Widget toWidget({
    required final TetaWidgetState state,
    final CNode? child,
    final List<CNode>? children,
  }) =>
      WLoginWithMicrosoft(
        ValueKey(state.toKey),
        state: state,
        child: child,
        action: attributes[DBKeys.action] as NodeGestureActions,
        width: attributes[DBKeys.width] as FSize,
        height: attributes[DBKeys.height] as FSize,
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
        LoginMicrosoftCodeTemplate.toCode(
          pageId,
          context,
          node,
          child,
          loop ?? 0,
        ),
        loop ?? 0,
      );
}
