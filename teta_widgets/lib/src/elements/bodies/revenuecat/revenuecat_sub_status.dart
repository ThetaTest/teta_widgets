// Flutter imports:
// ignore_for_file: lines_longer_than_80_chars

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:teta_front_end/src/pages/assets_constants.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
import 'package:teta_widgets/src/elements/code/templates/revenuecat/revenuecat_status_sub.dart';
// Project imports:
import 'package:teta_widgets/src/elements/features/actions/enums/permissions.dart';
import 'package:teta_widgets/src/elements/index.dart';
import 'package:teta_widgets/src/elements/intrinsic_states/class.dart';
import 'package:teta_widgets/src/elements/nodes/categories.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';
import 'package:teta_widgets/src/elements/widgets/revenuecat/sub_status.dart';
import 'package:teta_models/teta_models.dart';

const _globalType = NType.revenueCatSubStatus;

/// IS
final revenueCatSubStatusIntrinsicStates = IntrinsicStates(
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
  displayName: 'RevenueCat Sub Status',
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
class RevenueCatSubStatusBody extends NodeBody {
  @override
  // ignore: overridden_fields
  Map<String, dynamic> attributes = <String, dynamic>{
    DBKeys.value: FTextTypeInput(),
  };

  @override
  List<ControlModel> get controls => [
        ControlObject(
          type: ControlType.value,
          key: DBKeys.value,
          value: attributes[DBKeys.value],
          valueType: VariableType.string,
        ),
      ];

  @override
  Widget toWidget({
    required final TetaWidgetState state,
    final CNode? child,
    final List<CNode>? children,
  }) {
    return WRevenueCatSingleSubStatus(
      ValueKey('RevenueCat Sub Status $child'),
      state: state,
      entitlementInfo: attributes[DBKeys.value] as FTextTypeInput,
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
      RevenueCatSubsStatusCodeTemplate.toCode(
        context,
        node as NDynamic,
        child,
        loop,
      );
}
