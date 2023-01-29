// Flutter imports:
import 'package:flutter/material.dart';
import 'package:teta_core/teta_core.dart';
// Package imports:
import 'package:teta_repositories/src/node_repository.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/templates/navigation/appbar.dart';
import 'package:teta_widgets/src/elements/controls/control_model.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/intrinsic_states/class.dart';
import 'package:teta_widgets/src/elements/nodes/categories.dart';
import 'package:teta_widgets/src/elements/nodes/children_enum.dart';
import 'package:teta_widgets/src/elements/nodes/dynamic.dart';
import 'package:teta_widgets/src/elements/nodes/enum.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';
import 'package:teta_widgets/src/elements/tips/schema.dart';
import 'package:teta_widgets/src/elements/widgets/navigation/appbar.dart';

const _globalType = NType.appBar;

/// IS
final appBarIntrinsicStates = IntrinsicStates(
  nodeIcon: Assets.wIcons.appBar,
  nodeVideo: null,
  nodeDescription: null,
  advicedChildren: [],
  blockedTypes: [],
  synonymous: [],
  advicedChildrenCanHaveAtLeastAChild: [],
  displayName: NodeType.name(_globalType),
  type: _globalType,
  category: NodeCategories.unclassified,
  maxChildren: 1,
  canHave: ChildrenEnum.child,
  addChildLabels: ['Add AppBar Widget'],
  gestures: [],
  permissions: [],
  packages: [],
);

/// Body
class AppBarBody extends NodeBody {
  @override
  // ignore: overridden_fields
  Map<String, dynamic> attributes = <String, dynamic>{};

  @override
  List<ControlModel> get controls => [];

  List<TipObject> tips(
    final BuildContext context,
    final PageObject page,
    final CNode node,
  ) =>
      [
        TipObject(
          isVisible: node.child == null,
          title: 'Add Automatic AppBar',
          description: 'Automatic AppBar is the default AppBar',
          networkImage: '',
          onTap: () {
            sl.get<NodeRepository>().changeNode(
                  node: page.scaffold as NDynamic,
                );
            page.scaffold.body.attributes[DBKeys.showAppBar] = true;
          },
        )
      ];

  @override
  Widget toWidget({
    required final TetaWidgetState state,
    final CNode? child,
    final List<CNode>? children,
  }) =>
      WAppBar(
        const ValueKey('AppBar'),
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
      AppBarCodeTemplate.toCode(context, this, child);
}
