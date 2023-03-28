// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:theta_models/src/models/variable.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
import 'package:teta_widgets/src/elements/code/snippets.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/templates/map.dart';
import 'package:teta_widgets/src/elements/controls/control_model.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/controls/type.dart';
import 'package:teta_widgets/src/elements/features/action.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/index.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/permissions.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_widgets/src/elements/intrinsic_states/class.dart';
import '../../../../../../teta_open_classes/lib/src/nodes/categories.dart';
import '../../../../../../teta_open_classes/lib/src/nodes/children_enum.dart';
import '../../../../../../teta_open_classes/lib/src/nodes/enum.dart';
import '../../../../../../teta_open_classes/lib/src/nodes/node.dart';
import '../../../../../../teta_open_classes/lib/src/nodes/node_body.dart';
import 'package:teta_widgets/src/elements/packages.dart';
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
  displayName: 'Mapbox',
  type: _globalType,
  category: NodeCategories.advanced,
  maxChildren: null,
  canHave: ChildrenEnum.children,
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
class MapBody extends NodeBody {
  @override
  // ignore: overridden_fields
  Map<String, dynamic> attributes = <String, dynamic>{
    DBKeys.action: NodeGestureActions.empty(),
    DBKeys.flag: true,
    DBKeys.valueOfCondition: FTextTypeInput(),
  };

  @override
  List<ControlModel> get controls => [
        ControlObject(
          type: ControlType.mapController,
          key: DBKeys.valueOfCondition,
          value: attributes[DBKeys.valueOfCondition] as FTextTypeInput,
          valueType: VariableType.string,
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
    required final TetaWidgetState state,
    final CNode? child,
    final List<CNode>? children,
  }) =>
      WMap(
        ValueKey(
          '''
          ${state.toKey}
          ${child ?? children}
          ${attributes[DBKeys.flag] as bool}
          ${(attributes[DBKeys.valueOfCondition] as FTextTypeInput).toJson()}
          ${(attributes[DBKeys.action] as NodeGestureActions).toJson()}
          ''',
        ),
        state: state,
        children: children ?? [],
        controller: attributes[DBKeys.valueOfCondition] as FTextTypeInput,
        action: attributes[DBKeys.action] as NodeGestureActions,
        flag: attributes[DBKeys.flag] as bool? ?? false,
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
      CS.defaultWidgets(
        context,
        node,
        pageId,
        MapCodeTemplate.toCode(
          context,
          this,
          node,
          child,
          children ?? [],
          loop,
        ),
        loop ?? 0,
      );
}
