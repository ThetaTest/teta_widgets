/*import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:firebase/firebase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_editor/src/blocs/hover/index.dart';
import 'package:mobile_editor/src/elements/features/children_ids.dart';
import 'package:mobile_editor/src/elements/nodes/nnull.dart';
import 'package:mobile_editor/src/elements/nodes/node.dart';
import 'package:mobile_editor/src/elements/widgets/navigation/body.dart';
import 'package:mobile_editor/src/models/dataset.dart';
import 'package:mobile_editor/src/models/variable.dart';
import 'package:uuid/uuid.dart';

const globalType = "Body";

//ignore: must_be_immutable
class NBody extends CNode {
  static String get nodeType => globalType;
  static String get nodeName => globalType;
  final String? nodeIcon = "w_icons/container.png";
  final String? displayName = globalType;
  final List<String>? synonymous = [];
  final List<String>? advicedChildren = [];
  final List<String>? advicedChildrenCanHaveAtLeastAChild = [];
  final String type = globalType;
  String? parent;
  String? nid;
  List<CNode>? children;
  FChildrenIds? childrenIds;
  int? index;

  String? prjId;
  String? pageId;
  BuildContext? context;
  StreamSubscription? streamSubscription;
  Database db = database();
  DatabaseReference? ref;

  NBody({
    this.nid,
    this.children,
    this.childrenIds,
    this.prjId,
    this.pageId,
    this.context,
  }) {
    if (nid == null) this.nid = Uuid().v1();
    if (child == null) children = [];

    StreamConnection.connect(
        prjId, pageId, nid, context, (map) => mergeJson(map));
  }

  @override
  List<Object?> get props => [
        this.nid,
        this.children,
        this.childrenIds,
        this.prjId,
        this.pageId,
        this.context,
      ];

  @override
  String toString() => '$type { nid: $nid, children: $children }';

  static NBody fromJson(
    Map<String, dynamic> doc,
    String prjId,
    String pageId,
    BuildContext context,
  ) {
    return NBody(
      nid: doc['id'],
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
      if (key == 'ids') childrenIds = FChildrenIds().fromJson(map);
    });
  }

  Map<String, dynamic> toJson() {
    return {
      'id': '4',
      't': type,
      'ids': (childrenIds != null)
          ? childrenIds.toJson()
          : FChildrenIds().toJson(),
      'level': 1,
    };
  }

  @override
  Widget toWidget({
    required List<VariableObject> params,
    required List<VariableObject> states,
    required List<DatasetObject> dataset,
    int? loop,
    required bool forPlay,
  }) =>
      WBody(
        node: this,
        children: children ?? [],
        forPlay: forPlay,
        params: params,
        states: states,
        dataset: dataset,
      );

  String toCode(BuildContext context) {
    return """
      TBody(),
    """;
  }
}
*/
