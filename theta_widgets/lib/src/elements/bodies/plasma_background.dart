/*import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:firebase/firebase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_editor/src/blocs/hover/index.dart';
import 'package:mobile_editor/src/elements/controls/key_constants.dart';
import 'package:mobile_editor/src/elements/features/children_ids.dart';
import 'package:mobile_editor/src/elements/features/features.dart';
import 'package:mobile_editor/src/elements/nodes/nnull.dart';
import 'package:mobile_editor/src/elements/nodes/node.dart';
import 'package:mobile_editor/src/elements/widgets/plasma_background.dart';
import 'package:mobile_editor/src/models/dataset.dart';
import 'package:mobile_editor/src/models/variable.dart';
import 'package:uuid/uuid.dart';

const globalType = "PlsmBck";
const global_name = "Plasma Background";

//ignore: must_be_immutable
class NPlasmaBackgrund extends CNode {
  static String get nodeType => globalType;
  static String get nodeName => global_name;
  final String? nodeIcon = "w_icons/spacer.png";
  final String? nodeVideo = "7FJgd7QN1zI";
  final String? displayName = global_name;
  final List<String>? synonymous = ['spacer', 'space', 'br'];
  final List<String>? advicedChildren = ["Text", "Icon", "GestureDetector"];
  final List<String>? advicedChildrenCanHaveAtLeastAChild = [
    "Column",
    "Row",
    "Box",
  ];
  final String type = globalType;
  String? parent;
  String? nid;
  CNode? child;
  FChildrenIds? childrenIds;
  FSize? sizes;
  FFill? firstColor;
  FFill? secondColor;
  int? index;

  String? prjId;
  String? pageId;
  BuildContext? context;
  StreamSubscription? streamSubscription;
  Database db = database();
  DatabaseReference? ref;

  NPlasmaBackgrund({
    this.nid,
    this.child,
    this.childrenIds,
    this.sizes,
    this.firstColor,
    this.secondColor,
    this.prjId,
    this.pageId,
    this.context,
  }) {
    if (this.nid == null) this.nid = Uuid().v1();

    StreamConnection.connect(
        prjId, pageId, nid, context, (map) => mergeJson(map));
  }

  @override
  List<Object?> get props => [
        this.nid,
        this.child,
        this.childrenIds,
        this.sizes,
        this.firstColor,
        this.secondColor,
        this.prjId,
        this.pageId,
        this.context,
      ];

  @override
  List<ControlModel> get controls => [];

  static NPlasmaBackgrund fromJson(String id,
    Map<String, dynamic> doc,
    String prjId,
    String pageId,
    BuildContext context,
  ) {
    return NPlasmaBackgrund(
      nid: doc[DBKeys.id],
      sizes: FSize().fromJson(doc[DBKeys.sizes]),
      childrenIds: FChildrenIds().fromJson(doc),
      firstColor: FFill().fromJson(doc[DBKeys.fill]),
      secondColor: FFill().fromJson(doc[DBKeys.bgFill]),
      prjId: prjId,
      pageId: pageId,
      context: context,
    );
  }

  mergeJson(
    Map<String, dynamic> map,
  ) {
    map.keys.forEach((key) {
      if (key == DBKeys.sizes) sizes = FSize().fromJson(map);
      if (key == DBKeys.fill) firstColor = FFill().fromJson(map);
      if (key == DBKeys.bgFill) secondColor = FFill().fromJson(map);
      if (key == DBKeys.childrenIds) childrenIds = FChildrenIds().fromJson(map);
    });
  }

  Map<String, dynamic> toJson() {
    return {
       
      DBKeys.type: globalType,
      DBKeys.childrenIds: (childrenIds != null)
          ? childrenIds.toJson()
          : FChildrenIds().toJson(),
      DBKeys.sizes: (sizes != null)
          ? sizes!.toJson()
          : FSize(
              sizes: SizeElement(sizes: ["250", "250"], unit: SizeUnit.pixel),
            ).toJson(),
      DBKeys.fill: firstColor != null
          ? firstColor!.toJson()
          : FFill(
              type: FFillType.solid,
              levels: [FFillElement(color: '8A2387', stop: 0)],
            ).toJson(),
      DBKeys.bgFill: secondColor != null
          ? secondColor!.toJson()
          : FFill(
              type: FFillType.solid,
              levels: [FFillElement(color: 'F27121', stop: 0)],
            ).toJson(),
    };
  }

  @override
  String toString() => 'Plasma Background { nid: $nid, image: $image }';

  @override
  Widget toWidget({
    required List<VariableObject> params,
    required List<VariableObject> states,
    required List<DatasetObject> dataset,
    int? loop,
    required bool forPlay,
  }) =>
      WPlasmaBackground(
        node: this,
        nid: nid,
        child: child,
        sizes: sizes!,
        forPlay: forPlay,
        firstColor: firstColor!,
        secondColor: secondColor!,
        params: params,
        states: states,
        dataset: dataset,
      );

  String toCode(BuildContext context) {
    String strChild = 'TNull(),';
    if (child != null) strChild = child!.toCode(context);

    return """
      TPlasmaBackground(
        child: $strChild
        sizes: ${sizes?.toCode()},
      ) ,
    """;
  }
}
*/
