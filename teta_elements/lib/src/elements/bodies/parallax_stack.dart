/*import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:firebase/firebase.dart';
import 'package:uuid/uuid.dart';

// Project imports:
import 'package:mobile_editor/src/elements/builder/stream_connection.dart';
import 'package:mobile_editor/src/elements/controls/control_model.dart';
import 'package:mobile_editor/src/elements/controls/key_constants.dart';
import 'package:mobile_editor/src/elements/features/children_ids.dart';
import 'package:mobile_editor/src/elements/intrinsic_states/class.dart';
import 'package:mobile_editor/src/elements/nodes/node.dart';
import 'package:mobile_editor/src/elements/nodes/parallax_layer.dart';
import 'package:mobile_editor/src/elements/widgets/parallax_stack.dart';
import 'package:mobile_editor/src/models/dataset.dart';
import 'package:mobile_editor/src/models/variable.dart';

const globalType = "PStack";
const global_name = "Parallax Stack";

class ParallaxStackIntrinsicStates extends IntrinsicStates {
  final String nodeIcon = "w_icons/parallax_stack.png";
  final String? nodeVideo = "liEGSeD3Zt8"; //Check
  final String? nodeDescription = null;
  final List<String> advicedChildren = [
    NParallaxLayer.nodeName,
  ];
  final List<String> blockedTypes = [];
  final List<String> synonymous = ['parallax', 'mouse parallax', 'effect'];
  final List<String> advicedChildrenCanHaveAtLeastAChild = [];
  final String displayName = global_name;
  final String type = globalType;
}

//ignore: must_be_immutable
class NParallaxStack extends CNode {
  static final Map<String, IntrinsicStates> types = {};

  final IntrinsicStates intrinsicState;
  static String get nodeType => globalType;
  static String get nodeName => global_name;
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

  NParallaxStack({
    this.nid,
    this.children,
    this.childrenIds,
    this.prjId,
    this.pageId,
    this.context,
  }) : intrinsicState = getIntrinsicStates() {
    if (nid == null) this.nid = Uuid().v1();
    if (children == null) children = [];

    StreamConnection.connect(
        prjId, pageId, nid, context, (map) => mergeJson(map));
  }

  static IntrinsicStates getIntrinsicStates() {
    return types.putIfAbsent(
      globalType,
      () => ParallaxStackIntrinsicStates(),
    );
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
  List<ControlModel> get controls => [];

  static NParallaxStack fromJson(
    Map<String, dynamic> doc,
    String prjId,
    String pageId,
    BuildContext context,
  ) {
    return NParallaxStack(
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
  String toString() => 'PStack { nid: $nid, children: $children }';

  @override
  Widget toWidget({
    required List<VariableObject> params,
    required List<VariableObject> states,
    required List<DatasetObject> dataset,
    int? loop,
    required bool forPlay,
  }) =>
      WParallaxStack(
        node: this,
        children: children ?? [],
        forPlay: forPlay,
        loop: loop,
        params: params,
        states: states,
        dataset: dataset,
      );

  String toCode(BuildContext context) {
    String strChildren = '';
    if (children != null) {
      children!.forEach((e) {
        strChildren += e.toCode(context);
      });
    }

    return """
      TParallaxStack(
        children: [
          $strChildren
        ]
      ) ,
    """;
  }
}
*/
