// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
import 'package:teta_widgets/src/elements/code/templates/cms_logged_user.dart';
// Project imports:
import 'package:teta_widgets/src/elements/controls/control_model.dart';
import 'package:teta_widgets/src/elements/intrinsic_states/class.dart';
import 'package:teta_widgets/src/elements/nodes/categories.dart';
import 'package:teta_widgets/src/elements/nodes/children_enum.dart';
import 'package:teta_widgets/src/elements/nodes/dynamic.dart';
import 'package:teta_widgets/src/elements/nodes/enum.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';
import 'package:teta_widgets/src/elements/widgets/teta_cms/logged_user.dart';

const _globalType = NType.cmsLoggedUser;

/// IS
final cmsLoggedUserIntrinsicStates = IntrinsicStates(
  nodeIcon: const AssetGenImage('assets/icons/left/auth.png'),
  nodeVideo: null,
  nodeDescription: null,
  advicedChildren: [
    NodeType.name(NType.container),
    NodeType.name(NType.column),
    NodeType.name(NType.row)
  ],
  blockedTypes: [],
  synonymous: [
    NodeType.name(_globalType),
    'cms',
    'login',
    'user',
    'profile',
  ],
  advicedChildrenCanHaveAtLeastAChild: [],
  displayName: NodeType.name(_globalType),
  type: _globalType,
  category: NodeCategories.dynamicCollection,
  maxChildren: 2,
  canHave: ChildrenEnum.children,
  addChildLabels: [],
  gestures: [],
  permissions: [],
  packages: [],
);

/// Body
class CMSLoggedUserBody extends NodeBody {
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
  }) {
    return WCMSLoggedUser(
      ValueKey(
        '''
        ${state.toKey}
        ${child ?? children}
        $state.forPlay
      ''',
      ),
      state: state,
      children: children ?? [],
    );
  }

  @override
  Future<String> toCode(
    final BuildContext context,
    final CNode node,
    final CNode? child,
    final List<CNode>? children,
    final int pageId,
    final int? loop,
  ) =>
      CmsLoggedUserCodeTemplate.toCode(
        context,
        node as NDynamic,
        children ?? [],
        loop,
      );
}
