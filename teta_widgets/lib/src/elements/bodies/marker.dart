// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:teta_core/src/models/dataset.dart';
import 'package:teta_core/src/models/variable.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/templates/marker.dart';
import 'package:teta_widgets/src/elements/controls/control_model.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/controls/type.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_widgets/src/elements/intrinsic_states/class.dart';
import 'package:teta_widgets/src/elements/nodes/categories.dart';
import 'package:teta_widgets/src/elements/nodes/children_enum.dart';
import 'package:teta_widgets/src/elements/nodes/enum.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';
import 'package:teta_widgets/src/elements/widgets/marker.dart';

const _globalType = NType.marker;

/// Intrinsic States of Marker
final markerIntrinsicStates = IntrinsicStates(
  nodeIcon: Assets.wIcons.marker,
  nodeVideo: null,
  nodeDescription: null,
  advicedChildren: [
    NodeType.name(NType.container),
    NodeType.name(NType.image),
    NodeType.name(NType.icon),
  ],
  blockedTypes: [],
  synonymous: [NodeType.name(_globalType), 'map', 'icon'],
  advicedChildrenCanHaveAtLeastAChild: [],
  displayName: NodeType.name(_globalType),
  type: _globalType,
  category: NodeCategories.map,
  maxChildren: 1,
  canHave: ChildrenEnum.child,
  addChildLabels: [],
  gestures: [],
  permissions: [],
  packages: ['map'],
);

/// Body of Marker
class MarkerBody extends NodeBody {
  @override
  // ignore: overridden_fields
  Map<String, dynamic> attributes = <String, dynamic>{
    DBKeys.latitude: FTextTypeInput(value: '41.90'),
    DBKeys.longitude: FTextTypeInput(value: '12.49'),
  };

  @override
  List<ControlModel> get controls => [
        ControlObject(
          title: 'Latitude',
          type: ControlType.value,
          key: DBKeys.latitude,
          value: attributes[DBKeys.latitude],
        ),
        ControlObject(
          title: 'Longitude',
          type: ControlType.value,
          key: DBKeys.longitude,
          value: attributes[DBKeys.longitude],
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
      WMarker(
        ValueKey(
          '''
      ${node.nid}
      $loop
      ${child ?? children}
      ${(attributes[DBKeys.latitude] as FTextTypeInput).toJson()}
      ${(attributes[DBKeys.longitude] as FTextTypeInput).toJson()}
      ''',
        ),
        node: node,
        child: child,
        latitude: attributes[DBKeys.latitude] as FTextTypeInput,
        longitude: attributes[DBKeys.longitude] as FTextTypeInput,
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
      markerCodeTemplate(context, this, node, child, loop);
}
