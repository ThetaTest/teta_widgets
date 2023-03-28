// Flutter imports:
// ignore_for_file: lines_longer_than_80_chars

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:teta_front_end/src/pages/assets_constants.dart';
import 'package:theta_widgets/src/core/teta_widget/index.dart';
import 'package:theta_widgets/src/elements/code/templates/qonversion/qonversion_sub_status.dart';
// Project imports:
import 'package:theta_widgets/src/elements/features/actions/enums/permissions.dart';
import 'package:theta_widgets/src/elements/index.dart';
import 'package:theta_widgets/src/elements/intrinsic_states/class.dart';
import 'package:theta_widgets/src/elements/nodes/categories.dart';
import 'package:theta_widgets/src/elements/nodes/node_body.dart';
import 'package:theta_widgets/src/elements/widgets/qonversion/sub_status.dart';
import 'package:theta_models/theta_models.dart';

const _globalType = NType.qonversionSubStatus;

/// IS
final qonversionSubStatusIntrinsicStates = IntrinsicStates(
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
  displayName: 'Qonversion Sub Status',
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
class QonversionSubStatusBody extends NodeBody {
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
    return WQonversionSingleSubStatus(
      ValueKey('Qonversion Sub Status $child'),
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
      QonversionSubsStatusCodeTemplate.toCode(
        context,
        node as NDynamic,
        child,
        loop,
      );
}
