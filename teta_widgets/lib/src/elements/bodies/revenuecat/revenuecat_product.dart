// Flutter imports:
// ignore_for_file: lines_longer_than_80_chars

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:teta_core/gen/assets.gen.dart';
// Package imports:
import 'package:teta_core/src/models/dataset.dart';
import 'package:teta_core/src/models/variable.dart';
import 'package:teta_core/src/pages/assets_constants.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/templates/revenuecat/revenuecat_products.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/permissions.dart';
import 'package:teta_widgets/src/elements/intrinsic_states/class.dart';
import 'package:teta_widgets/src/elements/nodes/categories.dart';
import 'package:teta_widgets/src/elements/nodes/children_enum.dart';
import 'package:teta_widgets/src/elements/nodes/dynamic.dart';
import 'package:teta_widgets/src/elements/nodes/enum.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';
import 'package:teta_widgets/src/elements/widgets/revenuecat/product_list.dart';

const _globalType = NType.revenueCatProducts;

/// IS
final revenueCatProductsListIntrinsicStates = IntrinsicStates(
  nodeIcon: const AssetGenImage(KImages.revenueCatLogo),
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
  displayName: 'RevenueCat Products',
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
class RevenueCatProductListBody extends NodeBody {
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
  }) {
    return WRevenueCatProductsList(
      ValueKey('RevenueCat ProductList $child'),
      node: node,
      forPlay: forPlay,
      params: params,
      states: states,
      dataset: dataset,
      loop: loop,
      child: child,
    );
  }

  @override
  String toCode(
    final BuildContext context,
    final CNode node,
    final CNode? child,
    final List<CNode>? children,
    final int pageId,
    final int? loop,
  ) =>
      revenueCatProductsListCodeTemplate(
        context,
        node as NDynamic,
        child,
        loop,
      );
}
