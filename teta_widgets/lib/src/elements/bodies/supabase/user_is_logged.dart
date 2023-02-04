
import 'package:flutter/material.dart';
import 'package:teta_core/gen/assets.gen.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

import '../../../../teta_widgets.dart';
import '../../../core/teta_widget/index.dart';
import '../../intrinsic_states/class.dart';
import '../../nodes/categories.dart';
import '../../widgets/supabase/user_is_logged.dart';

const _globalType = NType.supabaseUserIsLogged;

final supabaseUserIsLoggedBuilderIntrinsicStates = IntrinsicStates(
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
    'future builder',
    'stream builder',
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

class SupabaseUserIsLoggedBody extends NodeBody{

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
    return WSupabaseUserIsLogged(
      ValueKey(
        '''
        ${state.toKey}
        $child 
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
