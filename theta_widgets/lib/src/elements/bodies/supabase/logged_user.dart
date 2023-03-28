// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:teta_widgets/src/elements/controls/control_model.dart';
import 'package:teta_widgets/src/elements/intrinsic_states/class.dart';
import 'package:teta_widgets/teta_open_classes/lib/src/nodes/categories.dart';
import 'package:teta_widgets/teta_open_classes/lib/src/nodes/children_enum.dart';
import 'package:teta_widgets/teta_open_classes/lib/src/nodes/enum.dart';
import 'package:teta_widgets/teta_open_classes/lib/src/nodes/node.dart';
import 'package:teta_widgets/teta_open_classes/lib/src/nodes/node_body.dart';
import 'package:teta_widgets/src/elements/widgets/supabase/logged_user.dart';

const _globalType = NType.supabaseLoggedUser;

/// IS
final supabaseLoggedUserIntrinsicStates = IntrinsicStates(
  nodeIcon: Assets.wIcons.supabaseLogoIcon,
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
    'firestore',
    'firebase',
    'login',
    'user',
    'profile',
  ],
  advicedChildrenCanHaveAtLeastAChild: [],
  displayName: NodeType.name(_globalType),
  type: _globalType,
  category: NodeCategories.dynamicCollection,
  maxChildren: 1,
  canHave: ChildrenEnum.child,
  addChildLabels: [],
  gestures: [],
  permissions: [],
  packages: [],
);

/// Body
class SupabaseLoggedUserBody extends NodeBody {
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
    return WSupabaseLoggedUser(
      ValueKey(
        '''
        ${state.toKey}
        ${child ?? children}
      ''',
      ),
      state: state,
      child: child,
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
      Future.value('');
}
