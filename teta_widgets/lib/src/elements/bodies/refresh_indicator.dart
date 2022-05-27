// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:teta_core/src/models/dataset.dart';
import 'package:teta_core/src/models/variable.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/templates/refresh_indicator.dart';
import 'package:teta_widgets/src/elements/controls/control_model.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/controls/type.dart';
import 'package:teta_widgets/src/elements/features/action.dart';
import 'package:teta_widgets/src/elements/features/sizes.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_widgets/src/elements/intrinsic_states/class.dart';
import 'package:teta_widgets/src/elements/nodes/categories.dart';
import 'package:teta_widgets/src/elements/nodes/children_enum.dart';
import 'package:teta_widgets/src/elements/nodes/enum.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';
import 'package:teta_widgets/src/elements/widgets/refresh_indicator.dart';

const _globalType = NType.refreshIndicator;

/// Intrinsic States of Center node type
final refreshIndicatorIntrinsicStates = IntrinsicStates(
  nodeIcon: Assets.wIcons.refreshIndicator,
  nodeVideo: null,
  nodeDescription: 'A widget that centers its child within itself.',
  advicedChildren: [
    NodeType.name(NType.column),
    NodeType.name(NType.row),
    NodeType.name(NType.image),
  ],
  blockedTypes: [],
  synonymous: [
    'refresh indicator',
    'linearProgressIndicator',
    'circularProgressIndicator'
  ],
  advicedChildrenCanHaveAtLeastAChild: [],
  displayName: NodeType.name(_globalType),
  type: _globalType,
  category: NodeCategories.unclassified,
  maxChildren: 2,
  canHave: ChildrenEnum.children,
  addChildLabels: [],
  gestures: [],
  permissions: [],
);

/// Set of funcs of Center node
class RefreshIndicatorBody extends NodeBody {
  @override
  // ignore: overridden_fields
  Map<String, dynamic> attributes = <String, dynamic>{
    DBKeys.height: FSize(size: '150', unit: SizeUnit.pixel),
    DBKeys.action: FAction(),
    DBKeys.duration: FTextTypeInput(value: '1000'),
    DBKeys.actionValue: FTextTypeInput(),
  };

  @override
  List<ControlModel> get controls => [
        ControlObject(
          type: ControlType.action,
          key: DBKeys.action,
          value: attributes[DBKeys.action],
        ),
        ControlObject(
          title: 'Duration',
          type: ControlType.value,
          key: DBKeys.duration,
          value: attributes[DBKeys.duration],
        ),
        SizeControlObject(
          key: DBKeys.height,
          value: attributes[DBKeys.height] as FSize,
          type: ControlType.size,
          isWidth: false,
          title: 'Height',
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
  }) =>
      WRefreshIndicator(
        ValueKey(
          '''
            ${node.nid}
            $loop
            ${child ?? children}
            ${(attributes[DBKeys.action] as FAction).toJson()}
            ${(attributes[DBKeys.actionValue] as FTextTypeInput).toJson()}
            ${(attributes[DBKeys.height] as FSize).toJson()}
            ${(attributes[DBKeys.duration] as FTextTypeInput).toJson()}
            ''',
        ),
        action: attributes[DBKeys.action] as FAction,
        actionValue: attributes[DBKeys.actionValue] as FTextTypeInput,
        height: attributes[DBKeys.height] as FSize,
        duration: attributes[DBKeys.duration] as FTextTypeInput,
        node: node,
        children: children ?? [],
        loop: loop,
        forPlay: forPlay,
        params: params,
        states: states,
        dataset: dataset,
      );

  @override
  String toCode(
    final BuildContext context,
    final CNode node,
    final CNode? child,
    final List<CNode>? children,
    final int pageId,
    final int? loop,
  ) =>
      refreshIndicatorCodeTemplate(
        context,
        this,
        node,
        children ?? [],
        loop ?? 0,
      );
}
