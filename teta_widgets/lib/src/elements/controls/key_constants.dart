// Project imports:
// ignore_for_file: public_member_api_docs, avoid_dynamic_calls

// Flutter imports:
import 'package:flutter/foundation.dart';
// Package imports:
import 'package:teta_core/src/models/variable.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/features/font_weight.dart';
import 'package:teta_widgets/src/elements/features/google_maps_map_style.dart';
import 'package:teta_widgets/src/elements/features/physic.dart';
import 'package:teta_widgets/src/elements/index.dart';

class DBKeys {
  // DB param keys
  static const String id = 'id';
  static const String prjId = 'prj_id';
  static const String pageId = 'page_id';
  static const String nodeId = 'node_id';
  static const String attributes = 'attributes';
  static const String name = 'name';
  static const String type = 'type';

  // Attribute keys
  static const String fontSize = 'fSz';
  static const String fontFamily = 'fFml';
  static const String fontWeight = 'fWgh';
  static const String fontStyle = 'fStl';
  static const String textDecoration = 'txtDc';
  static const String textDirection = 'txtDir';
  static const String textStyle = 'txtStl';
  static const String textStyle2 = 'txtStl2';
  static const String margins = 'm';
  static const String padding = 'p';
  static const String childrenIds = 'ids';
  static const String width = 'wdh';
  static const String widthFactor = 'wdhFct';
  static const String minWidth = 'miwdh';
  static const String maxWidth = 'mawdh';
  static const String height = 'hgh';
  static const String heightFactor = 'hghFct';
  static const String minHeight = 'mihgh';
  static const String maxHeight = 'mahgh';
  static const String textAlign = 'txtAlg';
  static const String borderRadius = 'bR';
  static const String crossAxisAlignment = 'cAA';
  static const String mainAxisAlignment = 'mAA';
  static const String mainAxisSize = 'mAS';
  static const String firestorePath = 'path';
  static const String fill = 'fill';
  static const String textFill = 'txtF';
  static const String activeFill = 'actF';
  static const String bgFill = 'bgFl';
  static const String startAt = 'stAt';
  static const String shadows = 'shd';
  static const String borders = 'brd';
  static const String activeBorders = 'abrd';
  static const String flag = 'f';
  static const String action = 'a';
  static const String actionValue = 'aVl';
  static const String image = 'img';
  static const String value = 'v';
  static const String align = 'al';
  static const String physic = 'ph';
  static const String textStyleModel = 'txtSM';
  static const String pageTransition = 'pgTrn';
  static const String componentName = 'cmp';
  static const String paramsToSend = 'prm';
  static const String condition = 'cndt';
  static const String valueOfCondition = 'vCndt';
  static const String conditionType = 'cndT';
  static const String isVertical = 'isV';
  static const String icon = 'icn';
  static const String featherIcon = 'fiicn';
  static const String faIcon = 'faicn';
  static const String lineIcon = 'lnicn';
  static const String boxFit = 'bxF';
  static const String xRotation = 'xR';
  static const String yRotation = 'yR';
  static const String zRotation = 'zR';
  static const String xOffset = 'xO';
  static const String yOffset = 'yO';
  static const String xTranslation = 'xTrans';
  static const String yTranslation = 'yTrans';
  static const String rotation = 'rotation';
  static const String xPerspective = 'xPer';
  static const String yPerspective = 'yPer';
  static const String zPerspective = 'zPer';
  static const String left = 'dl';
  static const String top = 'tp';
  static const String right = 'dr';
  static const String bottom = 'db';
  static const String isFullWidth = 'sFW';
  static const String visibleOnMobile = 'vOM';
  static const String visibleOnTablet = 'vOT';
  static const String visibleOnDesktop = 'vOD';
  static const String fadeAnimationEnabled = 'animF';
  static const String scaleAnimationEnabled = 'animScale';
  static const String slideAnimationEnabled = 'animSlide';
  static const String showControls = 'sCnt';
  static const String loopVideo = 'looV';
  static const String showAppBar = 'shAB';
  static const String showBottomBar = 'shBB';
  static const String showDrawer = 'shDW';
  static const String keyboardType = 'kTp';
  static const String borderStyle = 'b';
  static const String semanticLabel = 'sL';
  static const String excludeFromSemantics = 'eFS';
  static const String scale = 'scl';
  static const String repeat = 'rpt';
  static const String centerSlice = 'cSl';
  static const String blendMode = 'blM';
  static const String activeColor = 'acC';
  static const String checkColor = 'chC';
  static const String focusColor = 'fcC';
  static const String hoverColor = 'hvC';
  static const String shape = 'shp';
  static const String wrapAlignment = 'wpa';
  static const String datasetInput = 'dI';
  static const String duration = 'dur';
  static const String isPrimary = 'isPrmr';
  static const String maxLines = 'mxLns';
  static const String minLines = 'mnLns';
  static const String maxLenght = 'mxLng';
  static const String showCursor = 'shCrs';
  static const String autoCorrect = 'autoC';
  static const String obscureText = 'obT';

  //
  static const String showBorders = 'bEnb';
  static const String enabledBorderColor = 'ebc';
  static const String focusedBorderColor = 'fbc';
  static const String bordersSize = 'bs';

  //
  static const String hintTextColor = 'hintTC';
  static const String cursorColor = 'cursorC';

  static const String mainAxisSpacing = 'mAxSpc';
  static const String crossAxisCount = 'cAxCn';
  static const String crossAxisSpacing = 'cAxSpc';
  static const String childAspectRatio = 'cARt';
  static const String latitude = 'lat';
  static const String longitude = 'lng';
  static const String labelText = 'lt';
  static const String visibility = 'vs';
  static const String borderFill = 'bF';

  static const String rotateX = 'rttX';
  static const String rotateY = 'rttY';
  static const String rotateZ = 'rttZ';

  static const String tranX = 'tranX';
  static const String tranY = 'tranY';

  // Supabase ---------------------------------------------
  /// Use for from's value in Supabase operation
  static const String supabaseFrom = 'spF';

  /// Use for select's value in Supabase operation
  static const String supabaseSelect = 'spSl';

  /// Use for select's value in Supabase operation
  static const String supabaseStream = 'spS';

  /// Use for match's value in Supabase operation
  static const String supabaseMatch = 'spMt';

  /// Use for range's value in Supabase operation
  static const String supabaseFromRange = 'spFr';

  /// Use for range's value in Supabase operation
  static const String supabaseNumberPage = 'spNp';

  /// Use for range's value in Supabase operation
  static const String supabaseToRange = 'spTr';

  /// Use for order's value in Supabase operation
  static const String supabaseOrder = 'spOr';

  /// Use for search's value in Supabase operation
  static const String supabaseSearchName = 'spSeN';
  static const String supabaseSearchValue = 'spSeV';
  static const String supabaseEqName = 'spEqN';
  static const String supabaseEqValue = 'spEqV';

  // Use for custom http request
  static const String customHttpRequestURL = 'customHttpRequestURL';
  static const String customHttpRequestList = 'customHttpRequestList';
  static const String customHttpRequestHeader = 'customHttpRequestHeader';

//Api Calls
  static const String requestName = 'apiCallRN';

  static const String cmsCollection = 'cmsColl';
  static const String cmsLimit = 'cmsLmt';
  static const String cmsPage = 'cmsPage';
  static const String cmsLikeKey = 'cmsKey';
  static const String cmsLikeValue = 'cmsValue';

  static const String adMobAdAndroidUnitId = 'adMobAndroidUnitId';
  static const String adMobAdIosUnitId = 'adMobIosUnitId';

  static const audioPlayerUrl = 'aopurl';

  static const String audioPlayerCurrentDataset = 'apcd';

  static const String markerLatitude = 'googleMapsMarkerLatitudeKey';

  static const String markerLongitude = 'googleMapsMarkerLongitudeKey';

  static const String markerIconUrl = 'googleMapsMarkerIconUrlKey';

  static const String markerIconWidth = 'googleMapsMarkerIconWidthKey';

  static const String markerIconHeight = 'googleMapsMarkerIconHeightKey';

  static const String markerId = 'googleMapsMarkerIdKey';

  static const String markerDrawPathToUserCurrentLocation = 'markerDrawPathToUserCurrentLocation';

  static const String mapConfig = 'googleMapsDatasetConfigNameKey';

  static const String googleMapsController = 'googleMapsControllerName';

  static const String googleMapsCubitController = 'googleMapsCubitController';

  static const String mapCustomStyle = 'googleMapsCustomStyle';
  static const String mapCustomInitialZoomLevel = 'googleMapsInitialZoomLevel';
  static const String mapInitialPositionLat = 'googleMapsInitialPositionLat';
  static const String mapInitialPositionLng = 'googleMapsInitialPositionLng';
  static const String mapConfigShowMyLocationMarker =
      'mapDrawPathToBetweenMarkersAndUserCurrentLocation';
  static const String mapConfigTrackMyLocation = 'mapConfigShowTrackMyLocation';

  static const String stringDropdown = 'StringDropdownValue';
}

class DynamicAttributes {
  ///[value] == [doc[key]]
  static dynamic fromJson(final String key, final dynamic value) {
    try {
      switch (key) {
        case DBKeys.action:
          return FAction.fromJson(value as Map<String, dynamic>);
        case DBKeys.actionValue:
          return FTextTypeInput.fromJson(value as Map<String, dynamic>);
        case DBKeys.align:
          return FAlign.fromJson(value as dynamic);
        case DBKeys.physic:
          return FPhysic.fromJson(value as String);
        case DBKeys.bgFill:
          return FFill().fromJson(value as Map<String, dynamic>);
        case DBKeys.borderRadius:
          return FBorderRadius.fromJson(value as dynamic);
        case DBKeys.borders:
          return FBorder.fromJson(value as Map<String, dynamic>);
        case DBKeys.activeBorders:
          return FBorder.fromJson(value as Map<String, dynamic>);
        case DBKeys.bottom:
          return value;
        case DBKeys.boxFit:
          return FBoxFit.fromJson(value as String);
        case DBKeys.componentName:
          return value;
        case DBKeys.conditionType:
          {
            ConditionType? condType;
            if (value == 'e') condType = ConditionType.equal;
            if (value == 'mi') condType = ConditionType.minor;
            if (value == 'ma') condType = ConditionType.major;
            if (value == 'miE') condType = ConditionType.minorEqual;
            if (value == 'maE') condType = ConditionType.majorEqual;
            return condType;
          }
        case DBKeys.crossAxisAlignment:
          return FCrossAxisAlignment().fromJson(value as String);
        case DBKeys.fill:
          return FFill().fromJson(value as Map<String, dynamic>);
        case DBKeys.firestorePath:
          return FFirestorePath.fromJson(value as List<Map<String, dynamic>>);
        case DBKeys.flag:
          return value;
        case DBKeys.markerDrawPathToUserCurrentLocation:
          return FDataset.fromJson(value as Map<String, dynamic>);
        case DBKeys.mapConfigShowMyLocationMarker:
          return value;
        case DBKeys.mapConfigTrackMyLocation:
          return value;
        case DBKeys.stringDropdown:
          return value;
        case DBKeys.fontFamily:
          return value;
        case DBKeys.fontSize:
          return FFontSize().fromJson(value);
        case DBKeys.adMobAdAndroidUnitId:
          return FTextTypeInput.fromJson(value as Map<String, dynamic>);
        case DBKeys.adMobAdIosUnitId:
          return FTextTypeInput.fromJson(value as Map<String, dynamic>);
        case DBKeys.fontStyle:
          return FFontStyle().fromJson(value as String);
        case DBKeys.fontWeight:
          return FFontWeight().fromJson(value as String);
        case DBKeys.height:
          return FSize.fromJson(value as Map<String, dynamic>);
        case DBKeys.heightFactor:
          return FSize.fromJson(value as Map<String, dynamic>);
        case DBKeys.minHeight:
          return FSize.fromJson(value as Map<String, dynamic>);
        case DBKeys.maxHeight:
          return FSize.fromJson(value as Map<String, dynamic>);
        case DBKeys.icon:
          return value;
        case DBKeys.faIcon:
          return value;
        case DBKeys.featherIcon:
          return value;
        case DBKeys.lineIcon:
          return value;
        case DBKeys.image:
          return FTextTypeInput.fromJson(value as Map<String, dynamic>);
        case DBKeys.isFullWidth:
          return value;
        case DBKeys.isVertical:
          return value;
        case DBKeys.left:
          return value;
        case DBKeys.loopVideo:
          return value;
        case DBKeys.mainAxisAlignment:
          return FMainAxisAlignment().fromJson(value as String);
        case DBKeys.mainAxisSize:
          return FMainAxisSize.fromJson(value as String);
        case DBKeys.margins:
          return FMargins.fromJson(value as dynamic);
        case DBKeys.padding:
          return FMargins.fromJson(value as dynamic);
        case DBKeys.pageTransition:
          return FPageTransition.fromJson(value as String);
        case DBKeys.paramsToSend:
          return value as Map<String, dynamic>;
        case DBKeys.right:
          return value;
        case DBKeys.shadows:
          return FShadow.fromJson(value as Map<String, dynamic>);
        case DBKeys.showControls:
          return value;
        case DBKeys.startAt:
          return value;
        case DBKeys.textAlign:
          return FTextAlign.fromJson(value as String);
        case DBKeys.textDecoration:
          return FTextDecoration.fromJson(value as String);
        case DBKeys.textFill:
          return FFill().fromJson(value as Map<String, dynamic>);
        case DBKeys.activeFill:
          return FFill().fromJson(value as Map<String, dynamic>);
        case DBKeys.textStyle:
          return FTextStyle.fromJson(value as Map<String, dynamic>);
        case DBKeys.textStyle2:
          return FTextStyle.fromJson(value as Map<String, dynamic>);
        case DBKeys.textStyleModel:
          return value;
        case DBKeys.top:
          return value;
        case DBKeys.value:
          return FTextTypeInput.fromJson(value as Map<String, dynamic>);
        case DBKeys.audioPlayerCurrentDataset:
          return FTextTypeInput.fromJson(value as Map<String, dynamic>);
        case DBKeys.googleMapsController:
          return FTextTypeInput.fromJson(value as Map<String, dynamic>);
        case DBKeys.googleMapsCubitController:
          return FTextTypeInput.fromJson(value as Map<String, dynamic>);
        case DBKeys.rotateX:
          return FTextTypeInput.fromJson(value as Map<String, dynamic>);
        case DBKeys.rotateY:
          return FTextTypeInput.fromJson(value as Map<String, dynamic>);
        case DBKeys.rotateZ:
          return FTextTypeInput.fromJson(value as Map<String, dynamic>);
        case DBKeys.tranX:
          return FTextTypeInput.fromJson(value as Map<String, dynamic>);
        case DBKeys.tranY:
          return FTextTypeInput.fromJson(value as Map<String, dynamic>);
        case DBKeys.duration:
          return FTextTypeInput.fromJson(value as Map<String, dynamic>);
        case DBKeys.datasetInput:
          return FDataset.fromJson(value as Map<String, dynamic>);
        case DBKeys.mapConfig:
          return FDataset.fromJson(value as Map<String, dynamic>);
        case DBKeys.markerId:
          return FDataset.fromJson(value as Map<String, dynamic>);
        case DBKeys.markerLatitude:
          return FDataset.fromJson(value as Map<String, dynamic>);
        case DBKeys.markerLongitude:
          return FDataset.fromJson(value as Map<String, dynamic>);
        case DBKeys.markerIconUrl:
          return FDataset.fromJson(value as Map<String, dynamic>);
        case DBKeys.markerIconWidth:
          return FDataset.fromJson(value as Map<String, dynamic>);
        case DBKeys.markerIconHeight:
          return FDataset.fromJson(value as Map<String, dynamic>);
        case DBKeys.mapInitialPositionLng:
          return FTextTypeInput.fromJson(value as Map<String, dynamic>);
        case DBKeys.mapCustomStyle:
          return FGoogleMapsMapStyle().fromJson(value as String);
        case DBKeys.mapCustomInitialZoomLevel:
          return FTextTypeInput.fromJson(value as Map<String, dynamic>);
        case DBKeys.mapInitialPositionLat:
          return FTextTypeInput.fromJson(value as Map<String, dynamic>);
        case DBKeys.valueOfCondition:
          return FTextTypeInput.fromJson(value as Map<String, dynamic>);
        case DBKeys.visibleOnDesktop:
          return value;
        case DBKeys.visibleOnMobile:
          return value;
        case DBKeys.visibleOnTablet:
          return value;
        case DBKeys.fadeAnimationEnabled:
          return value;
        case DBKeys.scaleAnimationEnabled:
          return value;
        case DBKeys.slideAnimationEnabled:
          return value;
        case DBKeys.width:
          return FSize.fromJson(value as Map<String, dynamic>);
        case DBKeys.widthFactor:
          return FSize.fromJson(value as Map<String, dynamic>);
        case DBKeys.minWidth:
          return FSize.fromJson(value as Map<String, dynamic>);
        case DBKeys.maxWidth:
          return FSize.fromJson(value as Map<String, dynamic>);
        case 'params':
          {
            final params = <VariableObject>[];
            if (value != null) {
              for (final e in value as List<Map<String, dynamic>>) {
                params.add(VariableObject.fromJson(e));
              }
            }
            return params;
          }
        case 'states':
          {
            final states = <VariableObject>[];
            if (value != null) {
              for (final e in value as List<Map<String, dynamic>>) {
                states.add(VariableObject.fromJson(e));
              }
            }
            return states;
          }
        case DBKeys.showAppBar:
          return value;
        case DBKeys.showBottomBar:
          return value;
        case DBKeys.showDrawer:
          return value;
        case DBKeys.customHttpRequestURL:
          return FTextTypeInput.fromJson(value as Map<String, dynamic>);
        case DBKeys.customHttpRequestList:
          {
            final list = <MapElement>[];
            if (value != null) {
              for (final e in value as List<dynamic>) {
                list.add(MapElement.fromJson(e as Map<String, dynamic>));
              }
            }
            return list;
          }
        case DBKeys.customHttpRequestHeader:
          {
            final list = <MapElement>[];
            if (value != null) {
              for (final e in value as List<dynamic>) {
                list.add(MapElement.fromJson(e as Map<String, dynamic>));
              }
            }
            return list;
          }
        case DBKeys.cmsCollection:
          return FTextTypeInput.fromJson(value as Map<String, dynamic>);
        case DBKeys.requestName:
          return FTextTypeInput.fromJson(value as Map<String, dynamic>);

        case DBKeys.cmsPage:
          return FTextTypeInput.fromJson(value as Map<String, dynamic>);
        case DBKeys.cmsLimit:
          return FTextTypeInput.fromJson(value as Map<String, dynamic>);
        case DBKeys.cmsLikeKey:
          return FTextTypeInput.fromJson(value as Map<String, dynamic>);
        case DBKeys.cmsLikeValue:
          return FTextTypeInput.fromJson(value as Map<String, dynamic>);
        case DBKeys.supabaseFrom:
          return FTextTypeInput.fromJson(value as Map<String, dynamic>);
        case DBKeys.supabaseSelect:
          return FTextTypeInput.fromJson(value as Map<String, dynamic>);
        case DBKeys.supabaseStream:
          return FTextTypeInput.fromJson(value as Map<String, dynamic>);
        case DBKeys.supabaseFromRange:
          return FTextTypeInput.fromJson(value as Map<String, dynamic>);
        case DBKeys.supabaseToRange:
          return FTextTypeInput.fromJson(value as Map<String, dynamic>);
        case DBKeys.supabaseNumberPage:
          return FTextTypeInput.fromJson(value as Map<String, dynamic>);
        case DBKeys.supabaseOrder:
          return FTextTypeInput.fromJson(value as Map<String, dynamic>);
        case DBKeys.supabaseEqName:
          return FTextTypeInput.fromJson(value as Map<String, dynamic>);
        case DBKeys.supabaseEqValue:
          return FTextTypeInput.fromJson(value as Map<String, dynamic>);
        case DBKeys.supabaseSearchName:
          return FTextTypeInput.fromJson(value as Map<String, dynamic>);
        case DBKeys.supabaseSearchValue:
          return FTextTypeInput.fromJson(value as Map<String, dynamic>);
        case DBKeys.isPrimary:
          return value;
        case DBKeys.mainAxisSpacing:
          return FTextTypeInput.fromJson(value as Map<String, dynamic>);
        case DBKeys.crossAxisCount:
          return FTextTypeInput.fromJson(value as Map<String, dynamic>);
        case DBKeys.crossAxisSpacing:
          return FTextTypeInput.fromJson(value as Map<String, dynamic>);
        case DBKeys.maxLines:
          return FTextTypeInput.fromJson(value as Map<String, dynamic>);
        case DBKeys.minLines:
          return FTextTypeInput.fromJson(value as Map<String, dynamic>);
        case DBKeys.maxLenght:
          return FTextTypeInput.fromJson(value as Map<String, dynamic>);
        case DBKeys.showCursor:
          return value;
        case DBKeys.autoCorrect:
          return value;
        case DBKeys.obscureText:
          return value;
        case DBKeys.showBorders:
          return value;
        case DBKeys.bordersSize:
          return FTextTypeInput.fromJson(value as Map<String, dynamic>);
        case DBKeys.enabledBorderColor:
          return FFill().fromJson(value as Map<String, dynamic>);
        case DBKeys.focusedBorderColor:
          return FFill().fromJson(value as Map<String, dynamic>);
        case DBKeys.cursorColor:
          return FFill().fromJson(value as Map<String, dynamic>);
        case DBKeys.hintTextColor:
          return FFill().fromJson(value as Map<String, dynamic>);
        case DBKeys.childAspectRatio:
          return FTextTypeInput.fromJson(value as Map<String, dynamic>);
        case DBKeys.latitude:
          return FTextTypeInput.fromJson(value as Map<String, dynamic>);
        case DBKeys.longitude:
          return FTextTypeInput.fromJson(value as Map<String, dynamic>);
        case DBKeys.labelText:
          return FTextTypeInput.fromJson(value as Map<String, dynamic>);
        case DBKeys.xRotation:
          return FTextTypeInput.fromJson(value as Map<String, dynamic>);
        case DBKeys.yRotation:
          return FTextTypeInput.fromJson(value as Map<String, dynamic>);
        case DBKeys.zRotation:
          return FTextTypeInput.fromJson(value as Map<String, dynamic>);
        case DBKeys.xOffset:
          return FTextTypeInput.fromJson(value as Map<String, dynamic>);
        case DBKeys.yOffset:
          return FTextTypeInput.fromJson(value as Map<String, dynamic>);
        case DBKeys.rotation:
          return FTextTypeInput.fromJson(value as Map<String, dynamic>);
        case DBKeys.xPerspective:
          return FTextTypeInput.fromJson(value as Map<String, dynamic>);
        case DBKeys.yPerspective:
          return FTextTypeInput.fromJson(value as Map<String, dynamic>);
        case DBKeys.zPerspective:
          return FTextTypeInput.fromJson(value as Map<String, dynamic>);
        case DBKeys.xTranslation:
          return FTextTypeInput.fromJson(value as Map<String, dynamic>);
        case DBKeys.yTranslation:
          return FTextTypeInput.fromJson(value as Map<String, dynamic>);
        case DBKeys.visibility:
          return value;
        case DBKeys.borderFill:
          return FFill().fromJson(value as Map<String, dynamic>);
        case DBKeys.keyboardType:
          return value is String ? FKeyboardType.fromJson(value) : FKeyboardType();
        default:
          return value;
      }
    } catch (e) {
      if (kDebugMode) {
        // ignore: avoid_print
        print(
          'Error in key_costants.dart, key: $key, value: $value, error: $e',
        );
      }
    }
  }

  static dynamic toJson(final String key, final dynamic value) {
    switch (key) {
      case DBKeys.action:
        return value != null ? value.toJson() : FAction().toJson();
      case DBKeys.actionValue:
        return value != null ? value.toJson() : FTextTypeInput().toJson();
      case DBKeys.align:
        return value != null ? value.toJson() : FAlign().toJson();
      case DBKeys.physic:
        return value != null ? value.toJson() : FPhysic().toJson();
      case DBKeys.bgFill:
        return value != null ? value.toJson() : FFill().toJson();
      case DBKeys.borderRadius:
        return value != null ? value.toJson() : FBorderRadius().toJson();
      case DBKeys.borders:
        return value != null ? value.toJson() : FBorder().toJson();
      case DBKeys.activeBorders:
        return value != null ? value.toJson() : FBorder().toJson();
      case DBKeys.bottom:
        return value;
      case DBKeys.boxFit:
        return value != null ? value.toJson() : FBoxFit().toJson();
      case DBKeys.componentName:
        return value;
      case DBKeys.conditionType:
        return value ?? ConditionType.equal;
      case DBKeys.crossAxisAlignment:
        return value != null ? value.toJson() : FCrossAxisAlignment().toJson();
      case DBKeys.fill:
        return value != null ? value.toJson() : FFill().toJson();
      case DBKeys.firestorePath:
        return value != null ? value.toJson() : FFirestorePath().toJson();
      case DBKeys.flag:
        return value;
      case DBKeys.markerDrawPathToUserCurrentLocation:
        return value != null ? value.toJson() : FDataset().toJson();
      case DBKeys.mapConfigShowMyLocationMarker:
        return value;
      case DBKeys.mapConfigTrackMyLocation:
        return value;
      case DBKeys.stringDropdown:
        return value;
      case DBKeys.fontFamily:
        return value;
      case DBKeys.fontSize:
        return value != null ? value.toJson() : FFontSize().toJson();
      case DBKeys.adMobAdAndroidUnitId:
        return value != null ? value.toJson() : FTextTypeInput().toJson();
      case DBKeys.adMobAdIosUnitId:
        return value != null ? value.toJson() : FTextTypeInput().toJson();
      case DBKeys.fontStyle:
        return value != null ? value.toJson() : FFontStyle().toJson();
      case DBKeys.fontWeight:
        return value != null ? value.toJson() : FFontWeight().toJson();
      case DBKeys.height:
        return value != null ? value.toJson() : FSize().toJson();
      case DBKeys.heightFactor:
        return value != null ? value.toJson() : FSize().toJson();
      case DBKeys.minHeight:
        return value != null ? value.toJson() : FSize().toJson();
      case DBKeys.maxHeight:
        return value != null ? value.toJson() : FSize().toJson();
      case DBKeys.icon:
        return value;
      case DBKeys.faIcon:
        return value;
      case DBKeys.featherIcon:
        return value;
      case DBKeys.lineIcon:
        return value;
      case DBKeys.image:
        return value != null ? value.toJson() : FTextTypeInput().toJson();
      case DBKeys.isFullWidth:
        return value;
      case DBKeys.isVertical:
        return value;
      case DBKeys.left:
        return value;
      case DBKeys.loopVideo:
        return value;
      case DBKeys.mainAxisAlignment:
        return value != null ? value.toJson() : FMainAxisAlignment().toJson();
      case DBKeys.mainAxisSize:
        return value != null ? value.toJson() : FMainAxisSize().toJson();
      case DBKeys.margins:
        return value != null ? value.toJson() : FMargins().toJson();
      case DBKeys.padding:
        return value != null ? value.toJson() : FMargins().toJson();
      case DBKeys.pageTransition:
        return value != null ? value.toJson() : FPageTransition().toJson();
      case DBKeys.paramsToSend:
        return value as Map<String, dynamic>;
      case DBKeys.right:
        return value;
      case DBKeys.shadows:
        return value != null ? value.toJson() : FShadow().toJson();
      case DBKeys.showControls:
        return value;
      case DBKeys.startAt:
        return value;
      case DBKeys.textAlign:
        return value != null ? value.toJson() : FTextAlign().toJson();
      case DBKeys.textDecoration:
        return value != null ? value.toJson() : FTextDecoration().toJson();
      case DBKeys.textFill:
        return value != null ? value.toJson() : FFill().toJson();
      case DBKeys.activeFill:
        return value != null ? value.toJson() : FFill().toJson();
      case DBKeys.textStyle:
        return value != null ? value.toJson() : FTextStyle().toJson();
      case DBKeys.textStyle2:
        return value != null ? value.toJson() : FTextStyle().toJson();
      case DBKeys.textStyleModel:
        return value;
      case DBKeys.top:
        return value;
      case DBKeys.value:
        return value != null ? value.toJson() : FTextTypeInput().toJson();
      case DBKeys.audioPlayerCurrentDataset:
        return value != null ? value.toJson() : FTextTypeInput().toJson();
      case DBKeys.googleMapsController:
        return value != null ? value.toJson() : FTextTypeInput().toJson();
      case DBKeys.googleMapsCubitController:
        return value != null ? value.toJson() : FTextTypeInput().toJson();
      case DBKeys.rotateX:
        return value != null ? value.toJson() : FTextTypeInput().toJson();
      case DBKeys.rotateY:
        return value != null ? value.toJson() : FTextTypeInput().toJson();
      case DBKeys.rotateZ:
        return value != null ? value.toJson() : FTextTypeInput().toJson();
      case DBKeys.tranX:
        return value != null ? value.toJson() : FTextTypeInput().toJson();
      case DBKeys.tranY:
        return value != null ? value.toJson() : FTextTypeInput().toJson();
      case DBKeys.datasetInput:
        return value != null ? value.toJson() : FDataset().toJson();
      case DBKeys.mapConfig:
        return value != null ? value.toJson() : FDataset().toJson();
      case DBKeys.markerId:
        return value != null ? value.toJson() : FDataset().toJson();
      case DBKeys.markerLatitude:
        return value != null ? value.toJson() : FDataset().toJson();
      case DBKeys.markerLongitude:
        return value != null ? value.toJson() : FDataset().toJson();
      case DBKeys.markerIconUrl:
        return value != null ? value.toJson() : FDataset().toJson();
      case DBKeys.markerIconWidth:
        return value != null ? value.toJson() : FDataset().toJson();
      case DBKeys.markerIconHeight:
        return value != null ? value.toJson() : FDataset().toJson();
      case DBKeys.mapCustomStyle:
        return value != null ? value.toJson() : FGoogleMapsMapStyle().toJson();
      case DBKeys.mapCustomInitialZoomLevel:
        return value != null ? value.toJson() : FTextTypeInput().toJson();
      case DBKeys.mapInitialPositionLat:
        return value != null ? value.toJson() : FTextTypeInput().toJson();
      case DBKeys.mapInitialPositionLng:
        return value != null ? value.toJson() : FTextTypeInput().toJson();
      case DBKeys.valueOfCondition:
        return value != null ? value.toJson() : FTextTypeInput().toJson();
      case DBKeys.duration:
        return value != null ? value.toJson() : FTextTypeInput().toJson();
      case DBKeys.visibleOnDesktop:
        return value;
      case DBKeys.visibleOnMobile:
        return value;
      case DBKeys.visibleOnTablet:
        return value;
      case DBKeys.fadeAnimationEnabled:
        return value;
      case DBKeys.scaleAnimationEnabled:
        return value;
      case DBKeys.slideAnimationEnabled:
        return value;
      case DBKeys.width:
        return value != null ? value.toJson() : FSize().toJson();
      case DBKeys.widthFactor:
        return value != null ? value.toJson() : FSize().toJson();
      case DBKeys.minWidth:
        return value != null ? value.toJson() : FSize().toJson();
      case DBKeys.maxWidth:
        return value != null ? value.toJson() : FSize().toJson();
      case DBKeys.showAppBar:
        return value;
      case DBKeys.showBottomBar:
        return value;
      case DBKeys.showDrawer:
        return value;
      case 'params':
        return (value != null)
            ? (value as List<VariableObject>).map((final e) => e.toJson()).toList()
            : null;
      case 'states':
        return (value != null)
            ? (value as List<VariableObject>).map((final e) => e.toJson()).toList()
            : null;
      case DBKeys.customHttpRequestURL:
        return value != null ? value.toJson() : FTextTypeInput().toJson();
      case DBKeys.customHttpRequestList:
        return (value != null)
            ? (value as List<MapElement>).map((final e) => e.toJson()).toList()
            : <MapElement>[];
      case DBKeys.customHttpRequestHeader:
        return (value != null)
            ? (value as List<MapElement>).map((final e) => e.toJson()).toList()
            : <MapElement>[];
      case DBKeys.cmsCollection:
        return value != null ? value.toJson() : FTextTypeInput().toJson();
      case DBKeys.cmsPage:
        return value != null ? value.toJson() : FTextTypeInput().toJson();
      case DBKeys.cmsLimit:
        return value != null ? value.toJson() : FTextTypeInput().toJson();
      case DBKeys.cmsLikeKey:
        return value != null ? value.toJson() : FTextTypeInput().toJson();
      case DBKeys.cmsLikeValue:
        return value != null ? value.toJson() : FTextTypeInput().toJson();
      case DBKeys.supabaseFrom:
        return value != null ? value.toJson() : FTextTypeInput().toJson();
      case DBKeys.supabaseSelect:
        return value != null ? value.toJson() : FTextTypeInput().toJson();
      case DBKeys.supabaseStream:
        return value != null ? value.toJson() : FTextTypeInput().toJson();
      case DBKeys.supabaseFromRange:
        return value != null ? value.toJson() : FTextTypeInput().toJson();
      case DBKeys.supabaseToRange:
        return value != null ? value.toJson() : FTextTypeInput().toJson();
      case DBKeys.supabaseNumberPage:
        return value != null ? value.toJson() : FTextTypeInput().toJson();
      case DBKeys.supabaseOrder:
        return value != null ? value.toJson() : FTextTypeInput().toJson();
      case DBKeys.supabaseEqName:
        return value != null ? value.toJson() : FTextTypeInput().toJson();
      case DBKeys.supabaseEqValue:
        return value != null ? value.toJson() : FTextTypeInput().toJson();
      case DBKeys.supabaseSearchName:
        return value != null ? value.toJson() : FTextTypeInput().toJson();
      case DBKeys.supabaseSearchValue:
        return value != null ? value.toJson() : FTextTypeInput().toJson();
      case DBKeys.isPrimary:
        return value;
      case DBKeys.mainAxisSpacing:
        return value != null ? value.toJson() : FTextTypeInput().toJson();
      case DBKeys.crossAxisCount:
        return value != null ? value.toJson() : FTextTypeInput().toJson();
      case DBKeys.crossAxisSpacing:
        return value != null ? value.toJson() : FTextTypeInput().toJson();
      case DBKeys.maxLines:
        return value != null ? value.toJson() : FTextTypeInput().toJson();
      case DBKeys.minLines:
        return value != null ? value.toJson() : FTextTypeInput().toJson();
      case DBKeys.maxLenght:
        return value != null ? value.toJson() : FTextTypeInput().toJson();
      case DBKeys.showCursor:
        return value;
      case DBKeys.autoCorrect:
        return value;
      case DBKeys.obscureText:
        return value;
      case DBKeys.showBorders:
        return value;
      case DBKeys.bordersSize:
        return value != null ? value.toJson() : FTextTypeInput().toJson();
      case DBKeys.enabledBorderColor:
        return value != null ? value.toJson() : FFill().toJson();
      case DBKeys.focusedBorderColor:
        return value != null ? value.toJson() : FFill().toJson();
      case DBKeys.cursorColor:
        return value != null ? value.toJson() : FFill().toJson();
      case DBKeys.hintTextColor:
        return value != null ? value.toJson() : FFill().toJson();
      case DBKeys.childAspectRatio:
        return value != null ? value.toJson() : FTextTypeInput().toJson();
      case DBKeys.latitude:
        return value != null ? value.toJson() : FTextTypeInput().toJson();
      case DBKeys.longitude:
        return value != null ? value.toJson() : FTextTypeInput().toJson();
      case DBKeys.labelText:
        return value != null ? value.toJson() : FTextTypeInput().toJson();
      case DBKeys.visibility:
        return value;
      case DBKeys.borderFill:
        return value != null ? value.toJson() : FFill().toJson();
      case DBKeys.keyboardType:
        return value != null ? value.toJson() : FKeyboardType().toJson();
      case DBKeys.xRotation:
        return value != null ? value.toJson() : FKeyboardType().toJson();
      case DBKeys.yRotation:
        return value != null ? value.toJson() : FKeyboardType().toJson();
      case DBKeys.zRotation:
        return value != null ? value.toJson() : FKeyboardType().toJson();
      case DBKeys.xOffset:
        return value != null ? value.toJson() : FKeyboardType().toJson();
      case DBKeys.yOffset:
        return value != null ? value.toJson() : FKeyboardType().toJson();
      case DBKeys.xPerspective:
        return value != null ? value.toJson() : FKeyboardType().toJson();
      case DBKeys.yPerspective:
        return value != null ? value.toJson() : FKeyboardType().toJson();
      case DBKeys.zPerspective:
        return value != null ? value.toJson() : FKeyboardType().toJson();
      case DBKeys.rotation:
        return value != null ? value.toJson() : FKeyboardType().toJson();
      case DBKeys.xTranslation:
        return value != null ? value.toJson() : FKeyboardType().toJson();
      case DBKeys.yTranslation:
        return value != null ? value.toJson() : FKeyboardType().toJson();
      case DBKeys.requestName:
        return value != null ? value.toJson() : FTextTypeInput().toJson();
      default:
        return <String, dynamic>{};
    }
  }
}
