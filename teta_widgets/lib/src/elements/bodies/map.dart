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
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_widgets/src/elements/intrinsic_states/class.dart';
import 'package:teta_widgets/src/elements/nodes/categories.dart';
import 'package:teta_widgets/src/elements/nodes/children_enum.dart';
import 'package:teta_widgets/src/elements/nodes/enum.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';
import 'package:teta_widgets/src/elements/widgets/map.dart';

const _globalType = NType.map;

/// Intrinsic States of Mapbox
final mapIntrinsicStates = IntrinsicStates(
  nodeIcon: Assets.wIcons.maps,
  nodeVideo: null,
  nodeDescription: null,
  advicedChildren: [],
  blockedTypes: [],
  synonymous: ['map'],
  advicedChildrenCanHaveAtLeastAChild: [],
  displayName: NodeType.name(_globalType),
  type: _globalType,
  category: NodeCategories.map,
  maxChildren: null,
  canHave: ChildrenEnum.children,
  addChildLabels: [],
  gestures: [
    ActionGesture.onDoubleTap,
  ],
);

/// Body of MapBox
class MapBody extends NodeBody {
  @override
  // ignore: overridden_fields
  Map<String, dynamic> attributes = <String, dynamic>{
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
        FlagControlObject(
          title: 'Dark Mode',
          key: DBKeys.flag,
          value: attributes[DBKeys.flag],
          description: null,
        ),
        /*ControlObject(
            title: 'Latitude',
            type: ControlType.value,
            key: DBKeys.latitude,
            value: attributes[DBKeys.latitude]),
        ControlObject(
            title: 'Longitude',
            type: ControlType.value,
            key: DBKeys.longitude,
            value: attributes[DBKeys.longitude]),*/
      ];

  @override
  Widget toWidget({
    required List<VariableObject> params,
    required List<VariableObject> states,
    required List<DatasetObject> dataset,
    required bool forPlay,
    required CNode node,
    int? loop,
    CNode? child,
    List<CNode>? children,
  }) =>
      WMap(
        ValueKey(
          '''
      ${node.nid}
      $loop
            ${child ?? children}
      ${attributes[DBKeys.flag] as bool}
      ${(attributes[DBKeys.valueOfCondition] as FTextTypeInput).toJson()}
      ${(attributes[DBKeys.action] as FAction).toJson()}
      ''',
        ),
        node: node,
        children: children ?? [],
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
    BuildContext context,
    CNode node,
    CNode? child,
    List<CNode>? children,
    int pageId,
    int? loop,
  ) =>
      mapCodeTemplate(context, this, node, child, children ?? [], loop);
}
