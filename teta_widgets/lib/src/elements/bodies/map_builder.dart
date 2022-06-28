// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:teta_core/src/models/dataset.dart';
import 'package:teta_core/src/models/variable.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/templates/map.dart';
import 'package:teta_widgets/src/elements/controls/control_model.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/controls/type.dart';
import 'package:teta_widgets/src/elements/features/action.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/index.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/permissions.dart';
import 'package:teta_widgets/src/elements/features/dataset.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_widgets/src/elements/intrinsic_states/class.dart';
import 'package:teta_widgets/src/elements/nodes/categories.dart';
import 'package:teta_widgets/src/elements/nodes/children_enum.dart';
import 'package:teta_widgets/src/elements/nodes/enum.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';
import 'package:teta_widgets/src/elements/packages.dart';
import 'package:teta_widgets/src/elements/widgets/map_builder.dart';

const _globalType = NType.mapBuilder;

/// Intrinsic States of Mapbox
final mapBuilderIntrinsicStates = IntrinsicStates(
  nodeIcon: Assets.wIcons.maps,
  nodeVideo: null,
  nodeDescription: null,
  advicedChildren: [],
  blockedTypes: [],
  synonymous: ['map builder'],
  advicedChildrenCanHaveAtLeastAChild: [],
  displayName: NodeType.name(_globalType),
  type: _globalType,
  category: NodeCategories.unclassified,
  maxChildren: null,
  canHave: ChildrenEnum.child,
  addChildLabels: [],
  gestures: [
    ActionGesture.onDoubleTap,
  ],
  permissions: [
    Permissions.location,
  ],
  packages: [pMap, pLatLang],
);

/// Body of MapBox
class MapBuilderBody extends NodeBody {
  @override
  // ignore: overridden_fields
  Map<String, dynamic> attributes = <String, dynamic>{
    DBKeys.datasetInput: FDataset(),
    DBKeys.action: FAction(),
    DBKeys.flag: true,
    DBKeys.valueOfCondition: FTextTypeInput(),
  };

  @override
  List<ControlModel> get controls => [
        ControlObject(
          type: ControlType.mapController,
          key: DBKeys.valueOfCondition,
          value: attributes[DBKeys.valueOfCondition] as FTextTypeInput,
        ),
        ControlObject(
          type: ControlType.datasetType,
          key: DBKeys.datasetInput,
          value: attributes[DBKeys.datasetInput],
        ),
        FlagControlObject(
          title: 'Dark Mode',
          key: DBKeys.flag,
          value: attributes[DBKeys.flag],
          description: null,
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
      WMapBuilder(
        ValueKey(
          '''
      ${node.nid}
      $loop
            ${child ?? children}
      ${(attributes[DBKeys.datasetInput] as FDataset).toJson()}
      ${attributes[DBKeys.flag] as bool}
      ${(attributes[DBKeys.valueOfCondition] as FTextTypeInput).toJson()}
      ${(attributes[DBKeys.action] as FAction).toJson()}
      ''',
        ),
        node: node,
        child: child,
        datasetInput: attributes[DBKeys.datasetInput] as FDataset,
        controller: attributes[DBKeys.valueOfCondition] as FTextTypeInput,
        action: attributes[DBKeys.action] as FAction,
        flag: attributes[DBKeys.flag] as bool? ?? false,
        forPlay: forPlay,
        loop: loop,
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
      mapCodeTemplate(context, this, node, child, children ?? [], loop);
}
