// Flutter imports:
// ignore_for_file: lines_longer_than_80_chars

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:teta_core/gen/assets.gen.dart';
// Package imports:
import 'package:teta_core/src/pages/assets_constants.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
import 'package:teta_widgets/src/elements/code/templates/qonversion/qonversion_products.dart';
// Project imports:
import 'package:teta_widgets/src/elements/features/actions/enums/permissions.dart';
import 'package:teta_widgets/src/elements/intrinsic_states/class.dart';
import 'package:teta_widgets/src/elements/nodes/categories.dart';
import 'package:teta_widgets/src/elements/nodes/children_enum.dart';
import 'package:teta_widgets/src/elements/nodes/dynamic.dart';
import 'package:teta_widgets/src/elements/nodes/enum.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';
import 'package:teta_widgets/src/elements/widgets/qonversion/product_list.dart';

const _globalType = NType.qonversionProducts;

/// IS
final qonversionProductsListIntrinsicStates = IntrinsicStates(
  nodeIcon: const AssetGenImage(KImages.qonversionLogo),
  nodeVideo: null,
  nodeDescription: null,
  advicedChildren: [
    NodeType.name(NType.listViewBuilder),
    NodeType.name(NType.listView),
    NodeType.name(NType.column),
    NodeType.name(NType.row),
  ],
  blockedTypes: [],
  synonymous: [
    NodeType.name(_globalType),
    'monetizations',
    'monetization',
    'stripe',
    'revenue cat',
    'revenuecat',
    'payments',
    'payment'
  ],
  advicedChildrenCanHaveAtLeastAChild: [],
  displayName: 'Qonversion Products',
  type: _globalType,
  category: NodeCategories.subscriptions,
  maxChildren: 1,
  canHave: ChildrenEnum.child,
  addChildLabels: [],
  gestures: [],
  permissions: [
    Permissions.billing,
  ],
  packages: [],
);

/// Body
class QonversionProductListBody extends NodeBody {
  @override
  Widget toWidget({
    required final TetaWidgetState state,
    final CNode? child,
    final List<CNode>? children,
  }) {
    return WQonversionProductsList(
      ValueKey('Qonversion ProductList $child'),
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
      QonversionProductsListCodeTemplate.toCode(
        context,
        node as NDynamic,
        child,
        loop,
      );
}
