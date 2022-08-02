// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:teta_core/src/models/dataset.dart';
import 'package:teta_core/src/models/variable.dart';
import 'package:teta_widgets/src/elements/code/templates/google_maps_template.dart';

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
import 'package:teta_widgets/src/elements/widgets/google_maps_widget.dart';
import 'package:teta_widgets/src/elements/widgets/map_builder.dart';

const _globalType = NType.googleMaps;

/// Intrinsic States of Mapbox
final googleMapsIntrinsicStates = IntrinsicStates(
  nodeIcon: Assets.wIcons.maps,
  nodeVideo: null,
  nodeDescription: null,
  advicedChildren: [],
  blockedTypes: [],
  synonymous: ['map', 'google maps', 'maps', 'google'],
  advicedChildrenCanHaveAtLeastAChild: [],
  displayName: NodeType.name(_globalType),
  type: _globalType,
  category: NodeCategories.advanced,
  maxChildren: 0,
  canHave: ChildrenEnum.none,
  addChildLabels: [],
  gestures: [],
  permissions: [
    Permissions.location,
  ],
  packages: [pGoogleMaps, pFlutterCacheManager],
);

/// Body of MapBox
class GoogleMapsBody extends NodeBody {
  @override
  // ignore: overridden_fields
  Map<String, dynamic> attributes = <String, dynamic>{
    DBKeys.googleMapsController: FTextTypeInput(type: FTextTypeEnum.state),
    DBKeys.mapConfig: FDataset(),
    DBKeys.datasetInput: FDataset(),
    DBKeys.markerId: FDataset(),
    DBKeys.markerLatitude: FDataset(),
    DBKeys.markerLongitude: FDataset(),
    DBKeys.markerIconUrl: FDataset(),
    DBKeys.markerIconWidth: FDataset(),
    DBKeys.mapCustomStyle: FDataset(),
    DBKeys.mapInitialPositionLat: FDataset(),
    DBKeys.mapInitialPositionLng: FDataset(),
  };

  @override
  List<ControlModel> get controls => [
        ControlObject(
          title: 'Map Controller',
          type: ControlType.googleMapsController,
          key: DBKeys.googleMapsController,
          value: attributes[DBKeys.googleMapsController] as FTextTypeInput,
        ),
        ControlObject(
          title: 'Map Config Dataset',
          type: ControlType.datasetType,
          key: DBKeys.mapConfig,
          value: attributes[DBKeys.mapConfig] as FDataset,
        ),
        ControlObject(
          title: 'Map style Field Name',
          type: ControlType.datasetType,
          key: DBKeys.mapCustomStyle,
          value: attributes[DBKeys.mapCustomStyle] as FDataset,
          flag: true,
        ),
        ControlObject(
          title: 'Initial Position Latitude Field Name',
          type: ControlType.datasetType,
          key: DBKeys.mapInitialPositionLat,
          value: attributes[DBKeys.mapInitialPositionLat] as FDataset,
          flag: true,
        ),
        ControlObject(
          title: 'Initial Position Longitude Field Name',
          type: ControlType.datasetType,
          key: DBKeys.mapInitialPositionLng,
          value: attributes[DBKeys.mapInitialPositionLng] as FDataset,
          flag: true,
        ),
        ControlObject(
          title: 'Markers Dataset',
          type: ControlType.datasetType,
          key: DBKeys.datasetInput,
          value: attributes[DBKeys.datasetInput] as FDataset,
        ),
        ControlObject(
          title: 'Marker id Field Name',
          type: ControlType.datasetType,
          key: DBKeys.markerId,
          value: attributes[DBKeys.markerId] as FDataset,
          flag: true,
        ),
        ControlObject(
          title: 'Marker Latitude Field Name',
          type: ControlType.datasetType,
          key: DBKeys.markerLatitude,
          value: attributes[DBKeys.markerLatitude] as FDataset,
          flag: true,
        ),
        ControlObject(
          title: 'Marker Longitude Field Name',
          type: ControlType.datasetType,
          key: DBKeys.markerLongitude,
          value: attributes[DBKeys.markerLongitude] as FDataset,
          flag: true,
        ),
        ControlObject(
          title: 'Marker Icon Url Field Name',
          type: ControlType.datasetType,
          key: DBKeys.markerIconUrl,
          value: attributes[DBKeys.markerIconUrl] as FDataset,
          flag: true,
        ),
        ControlObject(
          title: 'Marker Icon Width Field Name',
          type: ControlType.datasetType,
          key: DBKeys.markerIconWidth,
          value: attributes[DBKeys.markerIconWidth] as FDataset,
          flag: true,
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
      WGoogleMaps(
        ValueKey(
          '''
      ${node.nid}
      ''',
        ),
        node: node,
        child: child,
        mapControllerName:
            (attributes[DBKeys.googleMapsController] as FTextTypeInput)
                    .stateName ??
                '',
        mapConfigDatasetName:
            (attributes[DBKeys.mapConfig] as FDataset).datasetName ?? '',
        markersDatasetName:
            (attributes[DBKeys.datasetInput] as FDataset).datasetName ?? '',
        markerId:
            (attributes[DBKeys.markerId] as FDataset).datasetAttrName ?? '',
        markerLatitude:
            (attributes[DBKeys.markerLatitude] as FDataset).datasetAttrName ??
                '',
        markerLongitude:
            (attributes[DBKeys.markerLongitude] as FDataset).datasetAttrName ??
                '',
        markerIconUrl:
            (attributes[DBKeys.markerIconUrl] as FDataset).datasetAttrName ??
                '',
        markerIconWidth:
            (attributes[DBKeys.markerIconWidth] as FDataset).datasetAttrName ??
                '',
        customMapStyle:
            (attributes[DBKeys.mapCustomStyle] as FDataset).datasetAttrName ??
                '',
        initialPositionLat:
            (attributes[DBKeys.mapInitialPositionLat] as FDataset)
                    .datasetAttrName ??
                '',
        initialPositionLng:
            (attributes[DBKeys.mapInitialPositionLng] as FDataset)
                    .datasetAttrName ??
                '',
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
      GoogleMapsTemplate.toCode(
        mapControllerName:
            (attributes[DBKeys.googleMapsController] as FTextTypeInput)
                    .stateName ??
                '',
        mapConfigDatasetName:
            (attributes[DBKeys.mapConfig] as FDataset).datasetName ?? '',
        markersDatasetName:
            (attributes[DBKeys.datasetInput] as FDataset).datasetName ?? '',
        markerId:
            (attributes[DBKeys.markerId] as FDataset).datasetAttrName ?? '',
        markerLatitude:
            (attributes[DBKeys.markerLatitude] as FDataset).datasetAttrName ??
                '',
        markerLongitude:
            (attributes[DBKeys.markerLongitude] as FDataset).datasetAttrName ??
                '',
        markerIconUrl:
            (attributes[DBKeys.markerIconUrl] as FDataset).datasetAttrName ??
                '',
        markerIconWidth:
            (attributes[DBKeys.markerIconWidth] as FDataset).datasetAttrName ??
                '',
        customMapStyle:
            (attributes[DBKeys.mapCustomStyle] as FDataset).datasetAttrName ??
                '',
        initialPositionLat:
            (attributes[DBKeys.mapInitialPositionLat] as FDataset)
                    .datasetAttrName ??
                '',
        initialPositionLng:
            (attributes[DBKeys.mapInitialPositionLng] as FDataset)
                    .datasetAttrName ??
                '',
      );
}
