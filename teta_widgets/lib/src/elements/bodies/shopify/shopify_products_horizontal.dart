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
import 'package:mobile_editor/src/elements/features/features.dart';
import 'package:mobile_editor/src/elements/intrinsic_states/class.dart';
import 'package:mobile_editor/src/elements/nodes/nnull.dart';
import 'package:mobile_editor/src/elements/nodes/node.dart';
import 'package:mobile_editor/src/elements/widgets/shopify/shopify_products_horizontal.dart';
import 'package:mobile_editor/src/models/dataset.dart';
import 'package:mobile_editor/src/models/variable.dart';

const globalType = "ShpPrdsHorizontal";
const global_name = "Shopify Products Horizontal";

class ShpPrdsHorizontalIntrinsicStates extends IntrinsicStates {
  final String nodeIcon = "w_icons/shp_products_horizontal.png";
  final String? nodeVideo = null;
  final String? nodeDescription = null;
  final List<String> advicedChildren = [];
  final List<String> blockedTypes = [];
  final List<String> synonymous = [];
  final List<String> advicedChildrenCanHaveAtLeastAChild = [];
  final String displayName = global_name;
  final String type = globalType;
}

//ignore: must_be_immutable
class NShopifyProductsHorizontal extends CNode {
  static String get nodeType => globalType;
  static String get nodeName => globalType;
  final String? nodeIcon = "w_icons/shp_products_horizontal.png";
  final List<String>? advicedChildren = ["Column", "Row", "Image"];
  final List<String>? advicedChildrenCanHaveAtLeastAChild = [
    "Column",
    "Box",
    "Row",
  ];
  final String? displayName = global_name;
  final List<String>? synonymous = ['center'];
  final String type = globalType;
  String? parent;
  String? nid;
  CNode? child;
  String? linkToPage;
  FChildrenIds? childrenIds;
  FSize? width;
  FSize? height;
  int? index;

  String? prjId;
  String? pageId;
  BuildContext? context;
  StreamSubscription? streamSubscription;
  Database db = database();
  DatabaseReference? ref;

  NShopifyProductsHorizontal({
    this.nid,
    this.child,
    this.childrenIds,
    this.linkToPage,
    this.width,
    this.height,
    this.prjId,
    this.pageId,
    this.context,
  }) {
    if (nid == null) this.nid = Uuid().v1();
    StreamConnection.connect(
        prjId, pageId, nid, context, (map) => mergeJson(map));
  }

  @override
  List<Object?> get props => [
        this.nid,
        this.child,
        this.childrenIds,
        this.linkToPage,
        this.width,
        this.height,
        this.prjId,
        this.pageId,
        this.context,
      ];

  static NShopifyProductsHorizontal fromJson(
    Map<String, dynamic> doc,
    String prjId,
    String pageId,
    BuildContext context,
  ) {
    return NShopifyProductsHorizontal(
      nid: doc[DBKeys.id],
      childrenIds: FChildrenIds().fromJson(doc),
      width: doc[DBKeys.width] != null
          ? FSize().fromJson(doc[DBKeys.width])
          : FSize(element: SizeElement(size: "max")),
      height: doc[DBKeys.width] != null
          ? FSize().fromJson(doc[DBKeys.width])
          : FSize(element: SizeElement(size: "150")),
      prjId: prjId,
      pageId: pageId,
      context: context,
    );
  }

  mergeJson(
    Map<String, dynamic> map,
  ) {
    map.keys.forEach((key) {
      if (key == DBKeys.childrenIds) childrenIds = FChildrenIds().fromJson(map);
      if (key == DBKeys.width) width = FSize().fromJson(map[key]);
      if (key == DBKeys.height) height = FSize().fromJson(map[key]);
    });
  }

  Map<String, dynamic> toJson() {
    return {
      DBKeys.id: nid,
      DBKeys.type: globalType,
      DBKeys.childrenIds: (childrenIds != null)
          ? childrenIds.toJson()
          : FChildrenIds().toJson(),
      DBKeys.width: (width != null) ? width!.toJson() : FSize().toJson(),
      DBKeys.height: (height != null) ? height!.toJson() : FSize().toJson(),
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
      WShopifyProductsHorizontal(
        node: this,
        child: child,
        linkToPage: linkToPage,
        width: width ?? FSize(),
        height: height ?? FSize(),
        forPlay: forPlay,
        loop: loop,
        params: params,
        states: states,
        dataset: dataset,
      );

  String toCode(BuildContext context) {
    String strChild = 'TNull(),';
    if (child != null) strChild = child!.toCode(context);

    return """
      TShopifyProductsHorizontal(
        child: $strChild
      ),
    """;
  }
}
*/
