/*import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:firebase/firebase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

// Project imports:
import 'package:mobile_editor/src/blocs/hover/index.dart';
import 'package:mobile_editor/src/elements/features/align.dart';
import 'package:mobile_editor/src/elements/features/border_radius.dart';
import 'package:mobile_editor/src/elements/features/features.dart';
import 'package:mobile_editor/src/elements/features/font_size.dart';
import 'package:mobile_editor/src/elements/features/font_weight.dart';
import 'package:mobile_editor/src/elements/features/keyboard_type.dart';
import 'package:mobile_editor/src/elements/features/page_transition.dart';
import 'package:mobile_editor/src/elements/features/text_align.dart';
import 'package:mobile_editor/src/elements/features/text_decoration.dart';
import 'package:mobile_editor/src/elements/features/text_type_input.dart';
import 'package:mobile_editor/src/elements/nodes/nnull.dart';
import 'package:mobile_editor/src/elements/nodes/node.dart';
import 'package:mobile_editor/src/elements/widgets/shopify/shopify_registration.dart';
import 'package:mobile_editor/src/models/dataset.dart';
import 'package:mobile_editor/src/models/variable.dart';

//ignore: must_be_immutable
class NShopifyRegistration extends CNode {
  final String? nodeIcon = "w_icons/box.png";
  String? nodeVideo = "c1xLMaTUWCY";
  List<String>? advicedChildren = ["Text", "Image", "GestureDetector"];
  List<String>? advicedChildrenCanHaveAtLeastAChild = [
    "Column",
    "Row",
    "Center",
  ];
  String? displayName = "Shopify Registration";
  final List<String>? synonymous = ['box', 'container', 'square', 'div'];
  String? type;
  String? parent;
  String? nid;
  int? index;
  FTextTypeInput? value;
  FMargins? margins;
  FMargins? paddings;
  FFill? fill;
  FFill? textFill;
  FSize? sizes;
  FFontSize? fontSize;
  String? fontFamily;
  FFontWeight? fontWeight;
  FTextDecoration? textDecoration;
  FTextAlign? textAlign;
  FFontStyle? fontStyle;
  int? level;
  String? cursorColor;
  String? hintTextColor;
  double? maxLines;
  double? minLines;
  double? maxLenght;
  FKeyboardType? keyboardType;
  FBorderRadius? borderRadius;
  bool? showCursor;
  bool? autoCorrect;
  bool? obscureText;
  FTextTypeInput? btnValue1;
  FTextTypeInput? btnValue2;
  FSize? btnSizes;
  FMargins? btnMargins;
  FMargins? btnPaddings;
  FBorderRadius? btnBorderRadius;
  FFill? btnFill;
  FFill? btnTextFill;
  FFontSize? btnFontSize;
  String? btnFontFamily;
  FFontWeight? btnFontWeight;
  FTextDecoration? btnTextDecoration;
  FTextAlign? btnTextAlign;
  FFontStyle? btnFontStyle;
  bool? linkOrAction;
  String? linkToPage;
  FPageTransition? pageTransition;
  String? textStyleModel;
  String? btnTextStyleModel;
  String? component;

  String? dataModelAttr;

  String? prjId;
  String? pageId;
  BuildContext? context;
  StreamSubscription? streamSubscription;
  Database db = database();
  DatabaseReference? ref;

  NShopifyRegistration({
    this.nid,
    this.value,
    this.parent,
    this.margins,
    this.paddings,
    this.fill,
    this.textFill,
    this.sizes,
    this.fontSize,
    this.fontFamily,
    this.fontWeight,
    this.textDecoration,
    this.textAlign,
    this.fontStyle,
    this.level,
    this.type,
    this.cursorColor,
    this.hintTextColor,
    this.maxLines,
    this.minLines,
    this.maxLenght,
    this.keyboardType,
    this.showCursor,
    this.autoCorrect,
    this.obscureText,
    this.borderRadius,
    this.textStyleModel,
    this.btnValue1,
    this.btnValue2,
    this.btnSizes,
    this.btnMargins,
    this.btnPaddings,
    this.btnBorderRadius,
    this.btnFill,
    this.btnTextFill,
    this.btnFontSize,
    this.btnFontFamily,
    this.btnFontWeight,
    this.btnTextDecoration,
    this.btnTextAlign,
    this.btnFontStyle,
    this.linkOrAction,
    this.linkToPage,
    this.pageTransition,
    this.component,
    this.dataModelAttr,
    this.btnTextStyleModel,
    this.prjId,
    this.pageId,
    this.context,
  }) {
    if (this.nid == null) this.nid = Uuid().v1();
    this.type = 'ShpRegistration';
    if (this.value == null)
      this.value = FTextTypeInput(type: FTextTypeEnum.text, value: 'Text');
    if (this.fontSize == null) fontSize = FFontSize();
    if (this.fontFamily == null) fontFamily = 'Poppins';
    if (this.fontWeight == null) fontWeight = FFontWeight();
    if (this.textDecoration == null) textDecoration = FTextDecoration();
    if (this.textAlign == null) textAlign = FTextAlign();

    StreamConnection.connect(
        prjId, pageId, nid, context, (map) => mergeJson(map));
  }

  @override
  List<Object?> get props => [
        this.nid,
        this.value,
        this.parent,
        this.margins,
        this.paddings,
        this.fill,
        this.textFill,
        this.sizes,
        this.fontSize,
        this.fontFamily,
        this.fontWeight,
        this.textDecoration,
        this.textAlign,
        this.fontStyle,
        this.level,
        this.type,
        this.cursorColor,
        this.hintTextColor,
        this.maxLines,
        this.minLines,
        this.maxLenght,
        this.keyboardType,
        this.showCursor,
        this.autoCorrect,
        this.obscureText,
        this.borderRadius,
        this.textStyleModel,
        this.btnValue1,
        this.btnValue2,
        this.btnSizes,
        this.btnMargins,
        this.btnPaddings,
        this.btnBorderRadius,
        this.btnFill,
        this.btnTextFill,
        this.btnFontSize,
        this.btnFontFamily,
        this.btnFontWeight,
        this.btnTextDecoration,
        this.btnTextAlign,
        this.btnFontStyle,
        this.align,
        this.linkOrAction,
        this.linkToPage,
        this.pageTransition,
        this.component,
        this.dataModelAttr,
        this.btnTextStyleModel,
        this.prjId,
        this.pageId,
        this.context,
      ];

  @override
  String toString() => 'ShpRegistration { nid: $nid, value: $value }';

  @override
  Widget toWidget({
    required List<VariableObject> params,
    required List<VariableObject> states,
    required List<DatasetObject> dataset,
    int? loop,
    required bool forPlay,
  }) =>
      WShopifyRegistration(
        node: this,
        margins: margins ?? FMargins(),
        paddings: paddings ?? FMargins(),
        fill: fill ?? FFill(),
        textFill: textFill ?? FFill(),
        sizes: sizes ?? FSize(),
        fontSize: fontSize ?? FFontSize(),
        fontFamily: fontFamily ?? "Poppins",
        fontWeight: fontWeight ?? FFontWeight(),
        textDecoration: textDecoration ?? FTextDecoration(),
        textAlign: textAlign ?? FTextAlign(),
        fontStyle: fontStyle ?? FFontStyle(),
        forPlay: forPlay,
        cursorColor: cursorColor,
        hintTextColor: hintTextColor,
        maxLines: maxLines,
        minLines: minLines,
        maxLenght: maxLenght,
        keyboardType: keyboardType ?? FKeyboardType(),
        showCursor: showCursor,
        autoCorrect: autoCorrect,
        obscureText: obscureText,
        textStyleModel: textStyleModel,
        borderRadius: borderRadius ?? FBorderRadius(),
        btnValue1: btnValue1 ?? FTextTypeInput(),
        btnValue2: btnValue2 ?? FTextTypeInput(),
        btnSizes: btnSizes ?? FSize(),
        btnMargins: btnMargins ?? FMargins(),
        btnPaddings: btnPaddings ?? FMargins(),
        btnBorderRadius: btnBorderRadius ?? FBorderRadius(),
        btnFill: btnFill ?? FFill(),
        btnTextFill: btnTextFill ?? FFill(),
        btnFontSize: btnFontSize ?? FFontSize(),
        btnFontFamily: btnFontFamily ?? "Poppins",
        btnFontWeight: btnFontWeight ?? FFontWeight(),
        btnTextDecoration: btnTextDecoration ?? FTextDecoration(),
        btnTextAlign: btnTextAlign ?? FTextAlign(),
        btnFontStyle: btnFontStyle ?? FFontStyle(),
        linkOrAction: linkOrAction ?? false,
        linkToPage: linkToPage,
        pageTransition: pageTransition ?? FPageTransition(),
        component: component,
        btnTextStyleModel: btnTextStyleModel,
        loop: loop,
        params: params,
        states: states,
        dataset: dataset,
      );

  static NShopifyRegistration fromJson(String id,
    Map<String, dynamic> doc,
    String prjId,
    String pageId,
    BuildContext context,
  ) {
    return NShopifyRegistration(
      nid: doc['id'],
      value: FTextTypeInput().fromJson(doc['value']),
      margins: doc['margins'] != null
          ? FMargins().fromJson(doc['margins'])
          : FMargins(),
      paddings: doc['paddings'] != null
          ? FMargins().fromJson(doc['paddings'])
          : FMargins(),
      sizes: FSize().fromJson(doc['sizes']),
      fill: FFill().fromJson(doc['fill']),
      textFill: FFill().fromJson(doc['txtFll']),
      fontSize: FFontSize().fromJson(doc['fontSize']),
      fontFamily: doc['fontFamily'],
      fontWeight: FFontWeight().fromJson(doc['fontWeight']),
      textDecoration: FTextDecoration().fromJson(doc['textDecoration']),
      textAlign: FTextAlign().fromJson(doc["textAlign"]),
      fontStyle: FFontStyle().fromJson(doc["fontStyle"]),
      level: doc['level'],
      cursorColor: doc['crsC'],
      hintTextColor: doc['hTC'],
      maxLines: doc['mxL'],
      minLines: doc['mnL'],
      maxLenght: doc['mxLth'],
      keyboardType: FKeyboardType().fromJson(doc['kT']),
      showCursor: doc['shwC'],
      autoCorrect: doc['atC'],
      obscureText: doc['obT'],
      borderRadius: FBorderRadius().fromJson(doc['bR']),
      textStyleModel: doc['textStyleModel'],
      dataModelAttr: doc['dataModelAttr'],
      btnTextStyleModel: doc['btnTextStyleModel'],
      btnValue1: FTextTypeInput().fromJson(doc['btnValue1']),
      btnValue2: FTextTypeInput().fromJson(doc['btnValue2']),
      btnMargins: FMargins().fromJson(doc['btnMargins']),
      btnPaddings: FMargins().fromJson(doc['btnMaddings']),
      btnSizes: FSize().fromJson(doc['btnSizes']),
      btnFill: FFill().fromJson(doc['btnFill']),
      btnBorderRadius: FBorderRadius().fromJson(doc['btnBR']),
      btnTextFill: FFill().fromJson(doc['btnTxtF']),
      btnFontSize: FFontSize().fromJson(doc['btnFontSize']),
      btnFontFamily: doc['btnFontFamily'],
      btnFontWeight: FFontWeight().fromJson(doc['btnFontWeight']),
      btnTextDecoration: FTextDecoration().fromJson(doc['btnTextDecoration']),
      btnTextAlign: FTextAlign().fromJson(doc["btnTextAlign"]),
      btnFontStyle: FFontStyle().fromJson(doc["btnFontStyle"]),
      linkToPage: doc['linkToPage'],
      pageTransition: FPageTransition().fromJson(doc),
      prjId: prjId,
      pageId: pageId,
      context: context,
    );
  }

  mergeJson(
    dynamic map,
  ) {
    map.keys.forEach((key) {
      if (key == 'value') value = FTextTypeInput().fromJson(map[key]);
      if (key == 'margins') margins = FMargins().fromJson(map[key]);
      if (key == 'paddings') paddings = FMargins().fromJson(map[key]);
      if (key == 'sizes') sizes = FSize().fromJson(map[key]);
      if (key == 'fill') fill = FFill().fromJson(map[key]);
      if (key == 'txtFill') textFill = FFill().fromJson(map[key]);
      if (key == 'fontSize') fontSize = FFontSize().fromJson(map[key]);
      if (key == 'fontFamily') fontFamily = map[key];
      if (key == 'fontWeight') fontWeight = FFontWeight().fromJson(map[key]);
      if (key == 'textDecoration')
        textDecoration = FTextDecoration().fromJson(map[key]);
      if (key == 'textAlign') textAlign = FTextAlign().fromJson(map[key]);
      if (key == 'fontStyle') fontStyle = FFontStyle().fromJson(map[key]);
      if (key == 'crsC') cursorColor = map[key];
      if (key == 'hTC') hintTextColor = map[key];
      if (key == 'mxL') maxLines = map[key];
      if (key == 'mnL') minLines = map[key];
      if (key == 'mxLth') maxLenght = map[key];
      if (key == 'keyboardType')
        keyboardType = FKeyboardType().fromJson(map[key]);
      if (key == 'shwC') showCursor = map[key];
      if (key == 'atC') autoCorrect = map[key];
      if (key == 'obT') obscureText = map[key];
      if (key == 'bR') borderRadius = FBorderRadius().fromJson(map[key]);
      if (key == 'btnValue1') btnValue1 = FTextTypeInput().fromJson(map[key]);
      if (key == 'btnValue2') btnValue2 = FTextTypeInput().fromJson(map[key]);
      if (key == 'btnMargins') btnMargins = FMargins().fromJson(map[key]);
      if (key == 'btnPaddings') btnPaddings = FMargins().fromJson(map[key]);
      if (key == 'btnFill') btnFill = FFill().fromJson(map[key]);
      if (key == 'btnSizes') btnSizes = FSize().fromJson(map[key]);
      if (key == 'btnBR') btnBorderRadius = FBorderRadius().fromJson(map[key]);
      if (key == 'btnTxtF') btnTextFill = FFill().fromJson(map[key]);
      if (key == 'btnFontSize') btnFontSize = FFontSize().fromJson(map[key]);
      if (key == 'btnFontFamily') btnFontFamily = map[key];
      if (key == 'btnFontWeight')
        btnFontWeight = FFontWeight().fromJson(map[key]);
      if (key == 'btnTextDecoration')
        btnTextDecoration = FTextDecoration().fromJson(map[key]);
      if (key == 'btnTextAlign') btnTextAlign = FTextAlign().fromJson(map[key]);
      if (key == 'btnFontStyle') btnFontStyle = FFontStyle().fromJson(map[key]);
      if (key == 'btnTextStyleModel') btnTextStyleModel = map[key];
      if (key == 'linkToPage') linkToPage = map[key];
      if (key == 'trsnEfx')
        pageTransition = FPageTransition().fromJson(map[key]);
      if (key == 'textStyleModel') textStyleModel = map[key];
      if (key == 'dataModelAttr') dataModelAttr = map[key];
      if (key == 'component') component = map[key];
    });
  }

  Map<String, dynamic> toJson() {
    return {
      'id': nid,
      't': "ShpRegistration",
      'value': (value != null) ? value!.toJson() : FTextTypeInput().toJson(),
      'margins': (margins != null)
          ? margins!.toJson()
          : FMargins(margins: [
              ["16", "8", "16", "8"],
              ["16", "8", "16", "8"],
              ["16", "8", "16", "8"]
            ]).toJson(),
      'paddings': (paddings != null) ? paddings!.toJson() : FMargins().toJson(),
      'sizes': (sizes != null)
          ? sizes!.toJson()
          : FSize(sizes: [
              SizeElement(sizes: ["max", "auto"], unit: SizeUnit.pixel),
              SizeElement(sizes: ["max", "auto"], unit: SizeUnit.pixel),
              SizeElement(sizes: ["max", "auto"], unit: SizeUnit.pixel),
            ]).toJson(),
      'fill': (fill != null)
          ? fill!.toJson()
          : FFill(
              type: FFillType.solid,
              levels: [FFillElement(color: 'f1f1f1', stop: 0)]).toJson(),
      'txtFll': (fill != null)
          ? fill!.toJson()
          : FFill().ready(FFillType.solid).toJson(),
      'fontSize':
          (fontSize != null) ? fontSize!.toJson() : FFontSize().toJson(),
      'fontFamily': fontFamily ?? 'Poppins',
      'fontWeight':
          (fontWeight != null) ? fontWeight!.toJson() : FFontWeight().toJson(),
      'level': level ?? -1,
      'textDecoration': (textDecoration != null)
          ? textDecoration!.toJson()
          : FTextDecoration().toJson(),
      'textAlign':
          (textAlign != null) ? textAlign!.toJson() : FTextAlign().toJson(),
      'fontStyle':
          (fontStyle != null) ? fontStyle!.toJson() : FFontStyle().toJson(),
      'crsC': cursorColor ?? '000000',
      'hTC': hintTextColor ?? 'a1a1a1',
      'mxL': maxLines ?? 1,
      'mnL': minLines ?? 1,
      'mxLth': maxLenght,
      'keyboardType': (keyboardType != null)
          ? keyboardType!.toJson()
          : FKeyboardType().toJson(),
      'shwC': showCursor ?? true,
      'atC': autoCorrect ?? false,
      'obT': obscureText ?? false,
      'bR': (borderRadius != null)
          ? borderRadius!.toJson()
          : FBorderRadius(radius: [
              [8, 8, 8, 8],
              [8, 8, 8, 8],
              [8, 8, 8, 8]
            ]).toJson(),
      'textStyleModel': textStyleModel,
      'dataModelAttr': dataModelAttr,
      'btnValue1': (btnValue1 != null)
          ? btnValue1!.toJson()
          : FTextTypeInput(type: FTextTypeEnum.text, value: 'Continue')
              .toJson(),
      'btnValue2': (btnValue2 != null)
          ? btnValue2!.toJson()
          : FTextTypeInput(type: FTextTypeEnum.text, value: 'Confirm').toJson(),
      'btnMargins': (btnMargins != null)
          ? btnMargins!.toJson()
          : FMargins(margins: [
              ["16", "16", "16", "8"],
              ["16", "16", "16", "8"],
              ["16", "16", "16", "8"]
            ]).toJson(),
      'btnPaddings':
          (btnPaddings != null) ? btnPaddings!.toJson() : FMargins().toJson(),
      'btnSizes': (btnSizes != null)
          ? btnSizes!.toJson()
          : FSize(sizes: [
              SizeElement(sizes: ["max", "48"], unit: SizeUnit.pixel),
              SizeElement(sizes: ["max", "48"], unit: SizeUnit.pixel),
              SizeElement(sizes: ["max", "48"], unit: SizeUnit.pixel),
            ]).toJson(),
      'btnFill': (btnFill != null)
          ? btnFill!.toJson()
          : FFill(paletteStyle: "xXHoXe56355C+p1").toJson(),
      'btnBR': (btnBorderRadius != null)
          ? btnBorderRadius!.toJson()
          : FBorderRadius(radius: [
              [8, 8, 8, 8],
              [8, 8, 8, 8],
              [8, 8, 8, 8]
            ]).toJson(),
      'btnTxtF': (btnTextFill != null)
          ? btnTextFill!.toJson()
          : FFill(
              type: FFillType.solid,
              levels: [FFillElement(color: 'ffffff', stop: 0)]).toJson(),
      'btnFontSize':
          (btnFontSize != null) ? btnFontSize!.toJson() : FFontSize().toJson(),
      'btnFontFamily': btnFontFamily ?? 'Poppins',
      'btnFontWeight': (btnFontWeight != null)
          ? btnFontWeight!.toJson()
          : FFontWeight(fontWeights: [
              FontWeight.w600,
              FontWeight.w600,
              FontWeight.w600,
            ]).toJson(),
      'btnTextDecoration': (btnTextDecoration != null)
          ? btnTextDecoration!.toJson()
          : FTextDecoration().toJson(),
      'btnTextAlign': (btnTextAlign != null)
          ? btnTextAlign!.toJson()
          : FTextAlign().toJson(),
      'btnFontStyle': (btnFontStyle != null)
          ? btnFontStyle!.toJson()
          : FFontStyle().toJson(),
      'btnTextStyleModel': btnTextStyleModel,
      'linkToPage': linkToPage,
      'trsnEfx': pageTransition != null
          ? pageTransition!.toJson()
          : FPageTransition().toJson()
    };
  }

  String toCode(BuildContext context) {
    return """
      TShopifyRegistrationForm(),
    """;
  }
}
*/
