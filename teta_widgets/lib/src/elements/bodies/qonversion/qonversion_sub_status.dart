// Flutter imports:
// ignore_for_file: lines_longer_than_80_chars

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:teta_core/src/models/dataset.dart';
import 'package:teta_core/src/models/variable.dart';
import 'package:teta_core/src/pages/assets_constants.dart';
import 'package:teta_widgets/src/elements/code/templates/qonversion/qonversion_sub_status.dart';
// Project imports:
import 'package:teta_widgets/src/elements/controls/control_model.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/controls/type.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/permissions.dart';
import 'package:teta_widgets/src/elements/index.dart';
import 'package:teta_widgets/src/elements/intrinsic_states/class.dart';
import 'package:teta_widgets/src/elements/nodes/categories.dart';
import 'package:teta_widgets/src/elements/nodes/children_enum.dart';
import 'package:teta_widgets/src/elements/nodes/dynamic.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';
import 'package:teta_widgets/src/elements/widgets/qonversion/sub_status.dart';

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
        ),
      ];

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
    return WQonversionSingleSubStatus(
      ValueKey('Qonversion Sub Status $child'),
      node: node,
      forPlay: forPlay,
      params: params,
      states: states,
      dataset: dataset,
      entitlementInfo: attributes[DBKeys.value] as FTextTypeInput,
      loop: loop,
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
