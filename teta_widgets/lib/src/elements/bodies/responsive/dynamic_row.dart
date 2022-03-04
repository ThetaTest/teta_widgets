/*import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:firebase/firebase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

// Project imports:
import 'package:mobile_editor/src/blocs/hover/index.dart';
import 'package:mobile_editor/src/elements/controls/key_constants.dart';
import 'package:mobile_editor/src/elements/features/children_ids.dart';
import 'package:mobile_editor/src/elements/nodes/nnull.dart';
import 'package:mobile_editor/src/elements/nodes/node.dart';
import 'package:mobile_editor/src/elements/widgets/responsive/dynamic_row.dart';
import 'package:mobile_editor/src/models/dataset.dart';
import 'package:mobile_editor/src/models/variable.dart';
import 'package:mobile_editor/src/types/dynamic_row_responsive_enum.dart';

const globalType = "DynamicRow";
const global_name = "Dynamic Row";

//ignore: must_be_immutable
class NDynamicRow extends CNode {
  static String get nodeType => globalType;
  static String get nodeName => global_name;
  final String? nodeIcon = "w_icons/dynamic_row.png";
  final String? displayName = global_name;
  final List<String>? synonymous = ['dynamic list', 'responsive list'];
  final List<String>? advicedChildren = ["Box", "Expanded", "GestureDetector"];
  final List<String>? advicedChildrenCanHaveAtLeastAChild = [
    "Box",
    "Expanded",
    "Column"
  ];
  final String type = globalType;
  String? parent;
  String? nid;
  List<CNode>? children;
  FChildrenIds? childrenIds;
  List<DynamicRowResponsiveEnum>? dynamicRowResponsive;
  int? index;

  String? prjId;
  String? pageId;
  BuildContext? context;
  StreamSubscription? streamSubscription;
  Database db = database();
  DatabaseReference? ref;

  NDynamicRow({
    this.nid,
    this.children,
    this.dynamicRowResponsive,
    this.childrenIds,
    this.prjId,
    this.pageId,
    this.context,
  }) {
    if (nid == null) this.nid = Uuid().v1();
    if (children == null) children = [];
    if (dynamicRowResponsive == null)
      dynamicRowResponsive = [
        DynamicRowResponsiveEnum.block,
        DynamicRowResponsiveEnum.inline,
        DynamicRowResponsiveEnum.inline
      ];

    StreamConnection.connect(
        prjId, pageId, nid, context, (map) => mergeJson(map));
  }

  @override
  List<Object?> get props => [
        this.nid,
        this.children,
        this.dynamicRowResponsive,
        this.childrenIds,
        this.prjId,
        this.pageId,
        this.context,
      ];

  static NDynamicRow fromJson(
    Map<String, dynamic> doc,
    String prjId,
    String pageId,
    BuildContext context,
  ) {
    List<String> dynamicRowResponsiveString = ["block", "inline", "inline"];
    List<DynamicRowResponsiveEnum> dynamicRowResponsive = [];
    if (doc['dynamicRowResponsive'] != null)
      dynamicRowResponsiveString = doc['dynamicRowResponsive'].cast<String>();
    dynamicRowResponsiveString.forEach((element) {
      if (element == "inline")
        dynamicRowResponsive.add(DynamicRowResponsiveEnum.inline);
      else
        dynamicRowResponsive.add(DynamicRowResponsiveEnum.block);
    });

    return NDynamicRow(
      nid: doc['id'],
      childrenIds: FChildrenIds().fromJson(doc),
      dynamicRowResponsive: dynamicRowResponsive,
      prjId: prjId,
      pageId: pageId,
      context: context,
    );
  }

  mergeJson(
    Map<String, dynamic> map,
  ) {
    map.keys.forEach((key) {
      if (key == 'ids') childrenIds = FChildrenIds().fromJson(map);
    });
  }

  Map<String, dynamic> toJson() {
    List<String> dynamicRowResponsiveString = [];
    if (dynamicRowResponsive != null)
      dynamicRowResponsive!.forEach((element) {
        if (element == DynamicRowResponsiveEnum.inline)
          dynamicRowResponsiveString.add("inline");
        else
          dynamicRowResponsiveString.add("block");
      });

    return {
      DBKeys.type: globalType,
      DBKeys.childrenIds: (childrenIds != null)
          ? childrenIds.toJson()
          : FChildrenIds().toJson(),
      'dynamicRowResponsive': dynamicRowResponsiveString,
    };
  }

  @override
  String toString() => '$type { nid: $nid, child: $child }';

  @override
  Widget toWidget({
    required List<VariableObject> params,
    required List<VariableObject> states,
    required List<DatasetObject> dataset,
    int? loop,
    required bool forPlay,
  }) =>
      WDynamicRow(
        node: this,
        children: children,
        forPlay: forPlay,
        dynamicRowResponsive: dynamicRowResponsive,
        loop: loop,
        params: params,
        states: states,
        dataset: dataset,
      );

  String toCode(BuildContext context) => """DynamicRow(),""";
}
*/
