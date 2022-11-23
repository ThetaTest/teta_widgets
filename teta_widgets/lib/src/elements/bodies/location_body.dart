// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:teta_core/src/models/dataset.dart';
import 'package:teta_core/src/models/variable.dart';
import 'package:teta_widgets/src/elements/code/snippets.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/templates/container.dart';
import 'package:teta_widgets/src/elements/code/templates/location_template.dart';
import 'package:teta_widgets/src/elements/controls/control_model.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/controls/type.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/permissions.dart';
import 'package:teta_widgets/src/elements/index.dart';
import 'package:teta_widgets/src/elements/intrinsic_states/class.dart';
import 'package:teta_widgets/src/elements/nodes/categories.dart';
import 'package:teta_widgets/src/elements/nodes/children_enum.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';
import 'package:teta_widgets/src/elements/packages.dart';

const _globalType = NType.location;

/// Instrinsic States of Container
final locationIntrinsicStates = IntrinsicStates(
  nodeIcon: Assets.wIcons.marker,
  nodeVideo: '',
  nodeDescription: '',
  advicedChildren: [],
  blockedTypes: [],
  synonymous: ['location'],
  advicedChildrenCanHaveAtLeastAChild: [],
  displayName: NodeType.name(_globalType),
  type: _globalType,
  category: NodeCategories.advanced,
  maxChildren: 0,
  canHave: ChildrenEnum.none,
  addChildLabels: [],
  gestures: [
    ActionGesture.onStreamNewValue,
  ],
  permissions: [
    Permissions.location,
  ],
  packages: [
    pGeolocator,
  ],
);

class LocationBody extends NodeBody {
  @override
  // ignore: overridden_fields
  Map<String, dynamic> attributes = <String, dynamic>{
    DBKeys.googleMapsController: FTextTypeInput(type: FTextTypeEnum.state),
    DBKeys.googleMapsCubitController: FTextTypeInput(type: FTextTypeEnum.state),
    DBKeys.width: FSize(size: 'max', unit: SizeUnit.pixel),
    DBKeys.height: FSize(size: 'null', unit: SizeUnit.pixel),
    DBKeys.margins: FMargins(),
    DBKeys.padding: FMargins(),
    DBKeys.borderRadius: FBorderRadius(),
    DBKeys.shadows: FShadow(),
    DBKeys.fill: FFill(),
    DBKeys.borders: FBorder(),
  };

  @override
  List<ControlModel> get controls => [
        ControlObject(
          title: 'Latitude',
          type: ControlType.value,
          key: DBKeys.googleMapsController,
          value: attributes[DBKeys.googleMapsController],
          valueType: VariableType.double,
        ),
        ControlObject(
          title: 'Longitude',
          type: ControlType.value,
          key: DBKeys.googleMapsCubitController,
          value: attributes[DBKeys.googleMapsCubitController],
          valueType: VariableType.double,
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
    return WContainer(
      ValueKey(
        '''
      ${node.nid}
      $loop
            ${child ?? children}
      ${(attributes[DBKeys.width] as FSize).toJson()}
      ${(attributes[DBKeys.height] as FSize).toJson()}
      ${(attributes[DBKeys.margins] as FMargins).toJson()}
      ${(attributes[DBKeys.padding] as FMargins).toJson()}
      ${(attributes[DBKeys.borderRadius] as FBorderRadius).toJson()}
      ${(attributes[DBKeys.shadows] as FShadow).toJson()}
      ${(attributes[DBKeys.fill] as FFill).toJson()}
      ${(attributes[DBKeys.borders] as FBorder).toJson()}
      ''',
      ),
      node: node,
      child: child,
      width: attributes[DBKeys.width] as FSize,
      height: attributes[DBKeys.height] as FSize,
      margins: attributes[DBKeys.margins] as FMargins,
      paddings: attributes[DBKeys.padding] as FMargins,
      borderRadius: attributes[DBKeys.borderRadius] as FBorderRadius,
      shadows: attributes[DBKeys.shadows] as FShadow,
      fill: attributes[DBKeys.fill] as FFill,
      borders: attributes[DBKeys.borders] as FBorder,
      forPlay: forPlay,
      loop: loop,
      params: params,
      states: states,
      dataset: dataset,
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
      CS.defaultWidgets(
        context,
        node,
        pageId,
        ContainerCodeTemplate.toCode(context, this, child),
        loop ?? 0,
      );

  @override
  String toCodeOnInit(
    final BuildContext context,
    final CNode node,
    final CNode? child,
    final List<CNode>? children,
    final int pageId,
    final int? loop,
    final List<NType> existingNodeTypes,
  ) =>
      LocationTemplate.toCode(
        pageId,
        context,
        //lat
        (attributes[DBKeys.googleMapsController] as FTextTypeInput).stateName ?? '',
        //lng
        (attributes[DBKeys.googleMapsCubitController] as FTextTypeInput).stateName ?? '',
        loop,
        node,
      );
}
