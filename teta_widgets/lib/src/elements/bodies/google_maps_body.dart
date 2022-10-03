// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/code/templates/google_maps_cubit_template.dart';
import 'package:teta_widgets/src/elements/code/templates/google_maps_template.dart';
import 'package:teta_widgets/src/elements/constants_export.dart';
// Project imports:
import 'package:teta_widgets/src/elements/controls/control_model.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/controls/type.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/permissions.dart';
import 'package:teta_widgets/src/elements/features/dataset.dart';
import 'package:teta_widgets/src/elements/features/features.dart';
import 'package:teta_widgets/src/elements/features/google_maps_map_style.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_widgets/src/elements/intrinsic_states/class.dart';
import 'package:teta_widgets/src/elements/nodes/categories.dart';
import 'package:teta_widgets/src/elements/nodes/children_enum.dart';
import 'package:teta_widgets/src/elements/nodes/enum.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';
import 'package:teta_widgets/src/elements/packages.dart';
import 'package:teta_widgets/src/elements/widgets/google_maps/google_maps_stub_widget.dart'
    if (dart.library.io) 'package:teta_widgets/src/elements/widgets/google_maps/google_maps_web_mobile_widget.dart'
    if (dart.library.html) 'package:teta_widgets/src/elements/widgets/google_maps/google_maps_web_mobile_widget.dart';

import '../nodes/suggestion.dart';

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
  packages: [
    pGoogleMaps,
    pFlutterCacheManager,
    pGeolocator,
    pDartz,
    pPolyLinesPoints,
    pEquatable,
  ],
  constants: [
    kMapStyleStandard,
    kMapStyleSilver,
    kMapStyleRetro,
    kMapStyleDark,
    kMapStyleNight,
    kMapStyleAubergine,
  ],
  suggestionsTitle: 'Why use Google Maps in Teta?',
  suggestions: [
    const Suggestion(
      title: 'Why use Google Maps in Teta?',
      description: 'Test',
      linkToOpen:
          'https://docs.teta.so/teta-docs/widget/map-widgets/google-maps',
    )
  ],
);

/// Body of MapBox
class GoogleMapsBody extends NodeBody {
  @override
  // ignore: overridden_fields
  Map<String, dynamic> attributes = <String, dynamic>{
    DBKeys.googleMapsController: FTextTypeInput(type: FTextTypeEnum.state),
    DBKeys.googleMapsCubitController: FTextTypeInput(type: FTextTypeEnum.state),
    DBKeys.datasetInput: FDataset(),
    DBKeys.markerId: FDataset(),
    DBKeys.markerLatitude: FDataset(),
    DBKeys.markerLongitude: FDataset(),
    DBKeys.markerIconUrl: FDataset(),
    DBKeys.markerIconWidth: FDataset(),
    DBKeys.markerIconHeight: FDataset(),
    DBKeys.mapCustomStyle: FGoogleMapsMapStyle(),
    DBKeys.mapCustomInitialZoomLevel:
        FTextTypeInput(value: '12', resultType: ResultTypeEnum.double),
    DBKeys.mapInitialPositionLat:
        FTextTypeInput(value: '41.889221', resultType: ResultTypeEnum.double),
    DBKeys.mapInitialPositionLng:
        FTextTypeInput(value: '12.493421', resultType: ResultTypeEnum.double),
    DBKeys.markerDrawPathToUserCurrentLocation: FDataset(),
    DBKeys.mapConfigShowMyLocationMarker: false,
    DBKeys.mapConfigTrackMyLocation: false,
    DBKeys.fill: FFill(),
  };

  @override
  List<ControlModel> get controls => [
        ControlObject(
          title: 'Map Controller',
          type: ControlType.googleMapsController,
          key: DBKeys.googleMapsController,
          value: attributes[DBKeys.googleMapsController],
          valueType: VariableType.mapController,
        ),
        ControlObject(
          title: 'Map cubit',
          type: ControlType.googleMapsCubitController,
          key: DBKeys.googleMapsCubitController,
          value: attributes[DBKeys.googleMapsCubitController],
          valueType: VariableType.string,
        ),
        ControlObject(
          title: 'Map style Field Name',
          type: ControlType.googleMapsMapStyle,
          key: DBKeys.mapCustomStyle,
          value: attributes[DBKeys.mapCustomStyle],
          description:
              'JSON String. See more at https://mapstyle.withgoogle.com/ .',
          flag: true,
          valueType: VariableType.string,
        ),
        ControlObject(
          title: 'Initial Position Latitude',
          type: ControlType.value,
          key: DBKeys.mapInitialPositionLat,
          value: attributes[DBKeys.mapInitialPositionLat],
          description: 'Double. Ex: 41.889221',
          valueType: VariableType.double,
        ),
        ControlObject(
          title: 'Initial Position Longitude',
          type: ControlType.value,
          key: DBKeys.mapInitialPositionLng,
          value: attributes[DBKeys.mapInitialPositionLng],
          description: 'Double. Ex: 12.493421',
          valueType: VariableType.double,
        ),
        ControlObject(
          title: 'Initial map zoom',
          type: ControlType.value,
          key: DBKeys.mapCustomInitialZoomLevel,
          value: attributes[DBKeys.mapCustomInitialZoomLevel],
          flag: true,
          description: 'Double. Ex: 10',
          valueType: VariableType.double,
        ),
        FlagControlObject(
          title: 'Show my location marker',
          key: DBKeys.mapConfigShowMyLocationMarker,
          value: attributes[DBKeys.mapConfigShowMyLocationMarker],
          description: 'Show my location marker.',
        ),
        FlagControlObject(
          title: 'Track my location',
          key: DBKeys.mapConfigTrackMyLocation,
          value: attributes[DBKeys.mapConfigTrackMyLocation],
          description: 'Track my location.',
        ),
        ControlObject(
          title: 'Markers Dataset',
          type: ControlType.datasetType,
          key: DBKeys.datasetInput,
          value: attributes[DBKeys.datasetInput] as FDataset,
          valueType: VariableType.string,
        ),
        ControlObject(
          title: 'Marker id Field Name',
          type: ControlType.datasetType,
          key: DBKeys.markerId,
          value: attributes[DBKeys.markerId] as FDataset,
          flag: true,
          description:
              'String UUID. Generate https://www.uuidgenerator.net/version4',
          valueType: VariableType.string,
        ),
        ControlObject(
          title: 'Marker Latitude Field Name',
          type: ControlType.datasetType,
          key: DBKeys.markerLatitude,
          value: attributes[DBKeys.markerLatitude],
          flag: true,
          description: 'Double. Ex: 41.889221',
          valueType: VariableType.double,
        ),
        ControlObject(
          title: 'Marker Longitude Field Name',
          type: ControlType.datasetType,
          key: DBKeys.markerLongitude,
          value: attributes[DBKeys.markerLongitude],
          flag: true,
          description: 'Double. Ex: 12.493421',
          valueType: VariableType.double,
        ),
        ControlObject(
          title: 'Marker Icon Url Field Name',
          type: ControlType.datasetType,
          key: DBKeys.markerIconUrl,
          value: attributes[DBKeys.markerIconUrl],
          flag: true,
          description: 'String. Ex: https://yourwebsite/image.png',
          valueType: VariableType.string,
        ),
        ControlObject(
          title: 'Marker Icon Width Field Name',
          type: ControlType.datasetType,
          key: DBKeys.markerIconWidth,
          value: attributes[DBKeys.markerIconWidth],
          flag: true,
          description: 'Must respect original aspect ratio. Integer. Ex: 512',
          valueType: VariableType.int,
        ),
        ControlObject(
          title: 'Marker Icon Height Field Name',
          type: ControlType.datasetType,
          key: DBKeys.markerIconHeight,
          value: attributes[DBKeys.markerIconHeight],
          flag: true,
          description: 'Must respect original aspect ratio. Integer. Ex: 512',
          valueType: VariableType.int,
        ),
        ControlObject(
          title: 'Marker draw Path field name',
          type: ControlType.datasetType,
          key: DBKeys.markerDrawPathToUserCurrentLocation,
          value: attributes[DBKeys.markerDrawPathToUserCurrentLocation],
          flag: true,
          valueType: VariableType.string,
        ),
        FillControlObject(
          title: 'Path color',
          key: DBKeys.fill,
          value: attributes[DBKeys.fill] as FFill,
          isImageEnabled: false,
          isNoneEnabled: true,
          isOnlySolid: false,
          isStyled: false,
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
        markerIconHeight:
            (attributes[DBKeys.markerIconHeight] as FDataset).datasetAttrName ??
                '',
        drawPathFromUserGeolocationToMarker:
            (attributes[DBKeys.markerDrawPathToUserCurrentLocation] as FDataset)
                    .datasetAttrName ??
                '',
        mapStyle: attributes[DBKeys.mapCustomStyle] as FGoogleMapsMapStyle,
        initialPositionLat:
            (attributes[DBKeys.mapInitialPositionLat] as FTextTypeInput)
                .toCode(loop, resultType: ResultTypeEnum.double),
        initialPositionLng:
            (attributes[DBKeys.mapInitialPositionLng] as FTextTypeInput)
                .toCode(loop, resultType: ResultTypeEnum.double),
        forPlay: forPlay,
        loop: loop,
        params: params,
        states: states,
        dataset: dataset,
        showMyLocationMarker:
            attributes[DBKeys.mapConfigShowMyLocationMarker] as bool,
        initialZoomLevel:
            (attributes[DBKeys.mapCustomInitialZoomLevel] as FTextTypeInput)
                .toCode(loop, resultType: ResultTypeEnum.double),
        trackMyLocation: attributes[DBKeys.mapConfigTrackMyLocation] as bool,
        pathColor: attributes[DBKeys.fill] as FFill,
        cubitName:
            (attributes[DBKeys.googleMapsCubitController] as FTextTypeInput)
                    .stateName ??
                '',
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
      GoogleMapsTemplate.toCodeOnInit(
        mapControllerName:
            (attributes[DBKeys.googleMapsController] as FTextTypeInput)
                    .stateName ??
                '',
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
        markerDrawPath:
            (attributes[DBKeys.markerDrawPathToUserCurrentLocation] as FDataset)
                    .datasetAttrName ??
                '',
        customMapStyle:
            (attributes[DBKeys.mapCustomStyle] as FGoogleMapsMapStyle).get,
        initialPositionLat:
            (attributes[DBKeys.mapInitialPositionLat] as FTextTypeInput)
                .toCode(loop, resultType: ResultTypeEnum.double),
        initialPositionLng:
            (attributes[DBKeys.mapInitialPositionLng] as FTextTypeInput).toCode(
          loop,
          resultType: ResultTypeEnum.double,
        ),
        showMyLocationMarker:
            attributes[DBKeys.mapConfigShowMyLocationMarker] as bool,
        initialZoomLevel:
            (attributes[DBKeys.mapCustomInitialZoomLevel] as FTextTypeInput)
                .toCode(
          loop,
          resultType: ResultTypeEnum.double,
        ),
        trackMyLocation: attributes[DBKeys.mapConfigTrackMyLocation] as bool,
        googleMapsBlocName:
            (attributes[DBKeys.googleMapsCubitController] as FTextTypeInput)
                    .stateName ??
                '',
        pathColor: (attributes[DBKeys.fill] as FFill).getHexColor(context),
      );

  @override
  String toCodeAdditionalClasses(
    final BuildContext context,
    final CNode node,
    final CNode? child,
    final List<CNode>? children,
    final int pageId,
    final int? loop,
    final List<NType> existingNodeTypes,
  ) =>
      GoogleMapsCubitTemplate.toCode(
        mapControllerName:
            (attributes[DBKeys.googleMapsController] as FTextTypeInput)
                    .stateName ??
                '',
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
        markerDrawPath:
            (attributes[DBKeys.markerDrawPathToUserCurrentLocation] as FDataset)
                    .datasetAttrName ??
                '',
        customMapStyle:
            (attributes[DBKeys.mapCustomStyle] as FGoogleMapsMapStyle).get,
        initialPositionLat:
            (attributes[DBKeys.mapInitialPositionLat] as FTextTypeInput)
                .toCode(loop, resultType: ResultTypeEnum.double),
        initialPositionLng:
            (attributes[DBKeys.mapInitialPositionLng] as FTextTypeInput)
                .toCode(loop, resultType: ResultTypeEnum.double),
        showMyLocationMarker:
            attributes[DBKeys.mapConfigShowMyLocationMarker] as bool,
        initialZoomLevel:
            (attributes[DBKeys.mapCustomInitialZoomLevel] as FTextTypeInput)
                .toCode(loop, resultType: ResultTypeEnum.double),
        trackMyLocation: attributes[DBKeys.mapConfigTrackMyLocation] as bool,
        googleMapsKey:
            (BlocProvider.of<FocusProjectBloc>(context).state as ProjectLoaded)
                    .prj
                    .config
                    ?.googleMapsKey ??
                '',
        googleMapsCubitName:
            (attributes[DBKeys.googleMapsCubitController] as FTextTypeInput)
                    .stateName ??
                '',
        pathColor: (attributes[DBKeys.fill] as FFill).getHexColor(context),
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
        GoogleMapsTemplate.toCode(
          context: context,
          mapControllerName:
              (attributes[DBKeys.googleMapsController] as FTextTypeInput)
                      .stateName ??
                  '',
          markersDatasetName:
              (attributes[DBKeys.datasetInput] as FDataset).datasetName ?? '',
          markerId:
              (attributes[DBKeys.markerId] as FDataset).datasetAttrName ?? '',
          markerLatitude:
              (attributes[DBKeys.markerLatitude] as FDataset).datasetAttrName ??
                  '',
          markerLongitude: (attributes[DBKeys.markerLongitude] as FDataset)
                  .datasetAttrName ??
              '',
          markerIconUrl:
              (attributes[DBKeys.markerIconUrl] as FDataset).datasetAttrName ??
                  '',
          markerIconWidth: (attributes[DBKeys.markerIconWidth] as FDataset)
                  .datasetAttrName ??
              '',
          markerDrawPath:
              (attributes[DBKeys.markerDrawPathToUserCurrentLocation]
                          as FDataset)
                      .datasetAttrName ??
                  '',
          customMapStyle:
              (attributes[DBKeys.mapCustomStyle] as FGoogleMapsMapStyle).get,
          initialPositionLat:
              (attributes[DBKeys.mapInitialPositionLat] as FTextTypeInput)
                  .toCode(loop, resultType: ResultTypeEnum.double),
          initialPositionLng:
              (attributes[DBKeys.mapInitialPositionLng] as FTextTypeInput)
                  .toCode(loop, resultType: ResultTypeEnum.double),
          showMyLocationMarker:
              attributes[DBKeys.mapConfigShowMyLocationMarker] as bool,
          initialZoomLevel:
              (attributes[DBKeys.mapCustomInitialZoomLevel] as FTextTypeInput)
                  .toCode(
            loop,
            resultType: ResultTypeEnum.double,
          ),
          trackMyLocation: attributes[DBKeys.mapConfigTrackMyLocation] as bool,
          googleMapsCubitName:
              (attributes[DBKeys.googleMapsCubitController] as FTextTypeInput)
                      .stateName ??
                  '',
          pathColor: (attributes[DBKeys.fill] as FFill).getHexColor(context),
        ),
        loop ?? 0,
      );
}
