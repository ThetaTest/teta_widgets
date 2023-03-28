/*import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:firebase/firebase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_editor/src/blocs/hover/index.dart';
import 'package:mobile_editor/src/elements/controls/key_constants.dart';
import 'package:mobile_editor/src/elements/features/children_ids.dart';
import 'package:mobile_editor/src/elements/intrinsic_states/class.dart';
import 'package:mobile_editor/src/elements/nodes/column.dart';
import 'package:mobile_editor/src/elements/nodes/listview.dart';
import 'package:mobile_editor/src/elements/nodes/nnull.dart';
import 'package:mobile_editor/src/elements/nodes/node.dart';
import 'package:mobile_editor/src/elements/nodes/row.dart';
import 'package:mobile_editor/src/elements/widgets/shopify/shopify_product.dart';
import 'package:mobile_editor/src/models/dataset.dart';
import 'package:mobile_editor/src/models/variable.dart';
import 'package:uuid/uuid.dart';

const globalType = "ShpWishlist";
const global_name = "Shopify Wishlist";

class ShpWishlistIntrinsicStates extends IntrinsicStates {
  final String nodeIcon = "w_icons/shp_whishlist.png";
  final String? nodeVideo = null;
  final String? nodeDescription = null;
  final List<String> advicedChildren = [
    NColumn.nodeName,
    NRow.nodeName,
    NListView.nodeName
  ];
  final List<String> blockedTypes = [];
  final List<String> synonymous = [
    'shopify',
    'wishlist',
    'checkout',
  ];
  final List<String> advicedChildrenCanHaveAtLeastAChild = [];
  final String displayName = global_name;
  final String type = globalType;
}

//ignore: must_be_immutable
class NShopifyWishlist extends CNode {
  static String get nodeType => globalType;
  static String get nodeName => global_name;
  String? parent;
  String? nid;
  CNode? child;
  FChildrenIds? childrenIds;
  int? index;

  String? prjId;
  String? pageId;
  BuildContext? context;
  StreamSubscription? streamSubscription;
  Database db = database();
  DatabaseReference? ref;

  NShopifyWishlist({
    this.nid,
    this.child,
    this.childrenIds,
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
        this.prjId,
        this.pageId,
        this.context,
      ];

  static NShopifyWishlist fromJson(
    Map<String, dynamic> doc,
    String prjId,
    String pageId,
    BuildContext context,
  ) {
    return NShopifyWishlist(
      nid: doc[DBKeys.id],
      childrenIds: FChildrenIds().fromJson(doc),
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
    });
  }

  Map<String, dynamic> toJson() {
    return {
      DBKeys.id: nid,
      DBKeys.type: globalType,
      DBKeys.childrenIds: (childrenIds != null)
          ? childrenIds.toJson()
          : FChildrenIds().toJson(),
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
      WShopifyProduct(
        node: this,
        child: child,
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
      TShopifyWishlist(
        child: $strChild
      ),
    """;
  }
}
*/
