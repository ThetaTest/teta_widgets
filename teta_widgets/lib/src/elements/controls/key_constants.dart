// Project imports:
// ignore_for_file: public_member_api_docs, avoid_dynamic_calls

import 'package:flutter/foundation.dart';
import 'package:teta_core/src/models/variable.dart';
import 'package:teta_widgets/src/elements/features/action.dart';
import 'package:teta_widgets/src/elements/features/align.dart';
import 'package:teta_widgets/src/elements/features/border.dart';
import 'package:teta_widgets/src/elements/features/border_radius.dart';
import 'package:teta_widgets/src/elements/features/box_fit.dart';
import 'package:teta_widgets/src/elements/features/cross_axis_alignment.dart';
import 'package:teta_widgets/src/elements/features/dataset.dart';
import 'package:teta_widgets/src/elements/features/fill.dart';
import 'package:teta_widgets/src/elements/features/firestore_path.dart';
import 'package:teta_widgets/src/elements/features/font_size.dart';
import 'package:teta_widgets/src/elements/features/font_style.dart';
import 'package:teta_widgets/src/elements/features/font_weight.dart';
import 'package:teta_widgets/src/elements/features/main_axis_alignment.dart';
import 'package:teta_widgets/src/elements/features/main_axis_size.dart';
import 'package:teta_widgets/src/elements/features/margins.dart';
import 'package:teta_widgets/src/elements/features/page_transition.dart';
import 'package:teta_widgets/src/elements/features/shadow.dart';
import 'package:teta_widgets/src/elements/features/sizes.dart';
import 'package:teta_widgets/src/elements/features/text_align.dart';
import 'package:teta_widgets/src/elements/features/text_decoration.dart';
import 'package:teta_widgets/src/elements/features/text_style.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';

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
  static const String textStyle = 'txtStl';
  static const String textStyle2 = 'txtStl2';
  static const String margins = 'm';
  static const String padding = 'p';
  static const String childrenIds = 'ids';
  static const String width = 'wdh';
  static const String minWidth = 'miwdh';
  static const String maxWidth = 'mawdh';
  static const String height = 'hgh';
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
  static const String textStyleModel = 'txtSM';
  static const String pageTransition = 'pgTrn';
  static const String componentName = 'cmp';
  static const String paramsToSend = 'prm';
  static const String condition = 'cndt';
  static const String valueOfCondition = 'vCndt';
  static const String conditionType = 'cndT';
  static const String isVertical = 'isV';
  static const String icon = 'icn';
  static const String boxFit = 'bxF';
  static const String xRotation = 'xR';
  static const String yRotation = 'yR';
  static const String zRotation = 'zR';
  static const String xOffset = 'xO';
  static const String yOffset = 'yO';
  static const String left = 'dl';
  static const String top = 'tp';
  static const String right = 'dr';
  static const String bottom = 'db';
  static const String isFullWidth = 'sFW';
  static const String visibleOnMobile = 'vOM';
  static const String visibleOnTablet = 'vOT';
  static const String visibleOnDesktop = 'vOD';
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
}

class DynamicAttributes {
  ///[value] == [doc[key]]
  static dynamic fromJson(String key, dynamic value) {
    try {
      switch (key) {
        case DBKeys.action:
          return FAction.fromJson(value as Map<String, dynamic>);
        case DBKeys.actionValue:
          return FTextTypeInput.fromJson(value as Map<String, dynamic>);
        case DBKeys.align:
          return FAlign.fromJson(value as String);
        case DBKeys.bgFill:
          return FFill().fromJson(value as Map<String, dynamic>);
        case DBKeys.borderRadius:
          return FBorderRadius.fromJson(value as List<dynamic>);
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
        case DBKeys.fontFamily:
          return value;
        case DBKeys.fontSize:
          return FFontSize().fromJson(value);
        case DBKeys.fontStyle:
          return FFontStyle().fromJson(value as String);
        case DBKeys.fontWeight:
          return FFontWeight().fromJson(value as String);
        case DBKeys.height:
          return FSize.fromJson(value as Map<String, dynamic>);
        case DBKeys.minHeight:
          return FSize.fromJson(value as Map<String, dynamic>);
        case DBKeys.maxHeight:
          return FSize.fromJson(value as Map<String, dynamic>);
        case DBKeys.icon:
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
          return FMargins.fromJson(value as List<dynamic>);
        case DBKeys.padding:
          return FMargins.fromJson(value as List<dynamic>);
        case DBKeys.pageTransition:
          return FPageTransition.fromJson(value as String);
        case DBKeys.paramsToSend:
          return value;
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
        case DBKeys.duration:
          return FTextTypeInput.fromJson(value as Map<String, dynamic>);
        case DBKeys.datasetInput:
          return FDataset.fromJson(value as Map<String, dynamic>);
        case DBKeys.valueOfCondition:
          return FTextTypeInput.fromJson(value as Map<String, dynamic>);
        case DBKeys.visibleOnDesktop:
          return value;
        case DBKeys.visibleOnMobile:
          return value;
        case DBKeys.visibleOnTablet:
          return value;
        case DBKeys.width:
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
        case DBKeys.visibility:
          return value;
        case DBKeys.borderFill:
          return FFill().fromJson(value as Map<String, dynamic>);
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

  static dynamic toJson(String key, dynamic value) {
    switch (key) {
      case DBKeys.action:
        return value != null ? value.toJson() : FAction().toJson();
      case DBKeys.actionValue:
        return value != null ? value.toJson() : FTextTypeInput().toJson();
      case DBKeys.align:
        return value != null ? value.toJson() : FAlign().toJson();
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
      case DBKeys.fontFamily:
        return value;
      case DBKeys.fontSize:
        return value != null ? value.toJson() : FFontSize().toJson();
      case DBKeys.fontStyle:
        return value != null ? value.toJson() : FFontStyle().toJson();
      case DBKeys.fontWeight:
        return value != null ? value.toJson() : FFontWeight().toJson();
      case DBKeys.height:
        return value != null ? value.toJson() : FSize().toJson();
      case DBKeys.minHeight:
        return value != null ? value.toJson() : FSize().toJson();
      case DBKeys.maxHeight:
        return value != null ? value.toJson() : FSize().toJson();
      case DBKeys.icon:
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
        return value;
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
      case DBKeys.datasetInput:
        return value != null ? value.toJson() : FDataset().toJson();
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
      case DBKeys.width:
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
            ? (value as List<VariableObject>).map((e) => e.toJson()).toList()
            : null;
      case 'states':
        return (value != null)
            ? (value as List<VariableObject>).map((e) => e.toJson()).toList()
            : null;
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
      case DBKeys.cursorColor:
        return value != null ? value.toJson() : FFill().toJson();
      case DBKeys.hintTextColor:
        return value != null ? value.toJson() : FFill().toJson();
      case DBKeys.childAspectRatio:
        return value != null ? value.toJson() : FTextTypeInput().toJson();
      case DBKeys.latitude:
        return FTextTypeInput.fromJson(value as Map<String, dynamic>);
      case DBKeys.longitude:
        return FTextTypeInput.fromJson(value as Map<String, dynamic>);
      case DBKeys.labelText:
        return value != null ? value.toJson() : FTextTypeInput().toJson();
      case DBKeys.visibility:
        return value;
      case DBKeys.borderFill:
        return value != null ? value.toJson() : FFill().toJson();
      default:
        return <String, dynamic>{};
    }
  }
}
