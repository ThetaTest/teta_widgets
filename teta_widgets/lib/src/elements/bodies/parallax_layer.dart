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
import 'package:mobile_editor/src/elements/nodes/center.dart';
import 'package:mobile_editor/src/elements/nodes/container.dart';
import 'package:mobile_editor/src/elements/nodes/node.dart';
import 'package:mobile_editor/src/elements/nodes/row.dart';
import 'package:mobile_editor/src/elements/widgets/parallax_layer.dart';
import 'package:mobile_editor/src/models/dataset.dart';
import 'package:mobile_editor/src/models/variable.dart';

const globalType = "PLayer";
const global_name = "Parallax Layer";

class ParallaxLayerIntrinsicStates extends IntrinsicStates {
  final String nodeIcon = "w_icons/parallax_layer.png";
  final String? nodeVideo = "EgtPleVwxBQ"; //Check
  final String? nodeDescription = null;
  final List<String> advicedChildren = [
    NContainer.nodeName,
    NRow.nodeName,
    NCenter.nodeName,
  ];
  final List<String> blockedTypes = [];
  final List<String> synonymous = [
    'parallax layer',
    'rotation',
    'transition',
    'effect'
  ];
  final List<String> advicedChildrenCanHaveAtLeastAChild = [];
  final String displayName = global_name;
  final String type = globalType;
}

//ignore: must_be_immutable
class NParallaxLayer extends CNode {
  static final Map<String, IntrinsicStates> types = {};

  final IntrinsicStates intrinsicState;
  static String get nodeType => globalType;
  static String get nodeName => global_name;
  String? parent;
  String? nid;
  CNode? child;
  FChildrenIds? childrenIds;
  int? index;

  double? xRotation, yRotation, zRotation;
  double? xOffset, yOffset;

  String? prjId;
  String? pageId;
  BuildContext? context;
  StreamSubscription? streamSubscription;
  Database db = database();
  DatabaseReference? ref;

  NParallaxLayer({
    this.nid,
    this.child,
    this.childrenIds,
    this.prjId,
    this.pageId,
    this.context,
    this.xRotation,
    this.yRotation,
    this.zRotation,
    this.xOffset,
    this.yOffset,
  }) : intrinsicState = getIntrinsicStates() {
    if (nid == null) this.nid = Uuid().v1();

    StreamConnection.connect(
        prjId, pageId, nid, context, (map) => mergeJson(map));
  }

  static IntrinsicStates getIntrinsicStates() {
    return types.putIfAbsent(
      globalType,
      () => ParallaxLayerIntrinsicStates(),
    );
  }

  @override
  List<Object?> get props => [
        this.nid,
        this.child,
        this.childrenIds,
        this.prjId,
        this.pageId,
        this.context,
        this.xRotation,
        this.yRotation,
        this.zRotation,
        this.xOffset,
        this.yOffset,
      ];

  @override
  List<ControlModel> get controls => [];

  static NParallaxLayer fromJson(
    Map<String, dynamic> doc,
    String prjId,
    String pageId,
    BuildContext context,
  ) {
    return NParallaxLayer(
      nid: doc[DBKeys.id],
      childrenIds: FChildrenIds().fromJson(doc),
      prjId: prjId,
      pageId: pageId,
      context: context,
      xRotation: doc[DBKeys.xRotation],
      yRotation: doc[DBKeys.yRotation],
      zRotation: doc[DBKeys.zRotation],
      xOffset: doc[DBKeys.xOffset],
      yOffset: doc[DBKeys.yOffset],
    );
  }

  mergeJson(
    Map<String, dynamic> map,
  ) {
    map.keys.forEach((key) {
      if (key == DBKeys.childrenIds) childrenIds = FChildrenIds().fromJson(map);
      if (key == DBKeys.xRotation) xRotation = map[key];
      if (key == DBKeys.yRotation) yRotation = map[key];
      if (key == DBKeys.zRotation) zRotation = map[key];
      if (key == DBKeys.xOffset) xOffset = map[key];
      if (key == DBKeys.yOffset) yOffset = map[key];
    });
  }

  Map<String, dynamic> toJson() {
    return {
      DBKeys.id: nid,
      DBKeys.type: globalType,
      DBKeys.childrenIds: (childrenIds != null)
          ? childrenIds.toJson()
          : FChildrenIds().toJson(),
      DBKeys.xRotation: xRotation,
      DBKeys.yRotation: yRotation,
      DBKeys.zRotation: zRotation,
      DBKeys.xOffset: xOffset,
      DBKeys.yOffset: yOffset,
    };
  }

  @override
  String toString() => 'Positioned { nid: $nid, child: $child }';

  @override
  Widget toWidget({
    required List<VariableObject> params,
    required List<VariableObject> states,
    required List<DatasetObject> dataset,
    int? loop,
    required bool forPlay,
  }) =>
      WParallaxLayer(
        node: this,
        child: child,
        xRotation: xRotation!,
        yRotation: yRotation!,
        zRotation: zRotation!,
        xOffset: xOffset!,
        yOffset: yOffset!,
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
      TParallaxLayer(
        child: $strChild
      ) ,
    """;
  }
}
*/
