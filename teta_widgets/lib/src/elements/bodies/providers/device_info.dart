/*import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:firebase/firebase.dart';
import 'package:mobile_editor/src/elements/builder/stream_connection.dart';
import 'package:mobile_editor/src/elements/controls/key_constants.dart';
import 'package:mobile_editor/src/elements/features/children_ids.dart';
import 'package:mobile_editor/src/elements/intrinsic_states/class.dart';
import 'package:mobile_editor/src/elements/nodes/enum.dart';
import 'package:mobile_editor/src/elements/nodes/node.dart';
import 'package:mobile_editor/src/elements/widgets/providers/device_info.dart';
import 'package:mobile_editor/src/models/dataset.dart';
import 'package:mobile_editor/src/models/variable.dart';
import 'package:uuid/uuid.dart';

const globalType = NType;

class DeviceInfoIntrinsicStates extends IntrinsicStates {
  final String nodeIcon = "w_icons/positioned.png";
  final String? nodeVideo = null;
  final String? nodeDescription = null;
  final List<String> advicedChildren = [
    NodeType.name(NType.container),
    NodeType.name(NType.column),
    NodeType.name(NType.row),
  ];
  final List<String> blockedTypes = [];
  final List<String> synonymous = ['device info', 'version', 'browser', 'os'];
  final List<String> advicedChildrenCanHaveAtLeastAChild = [];
  final String displayName = global_name;
  final String type = globalType;
}

//ignore: must_be_immutable
class NDeviceInfo extends CNode {
  static final Map<String, IntrinsicStates> types = {};

  final IntrinsicStates intrinsicState;
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

  NDeviceInfo({
    this.nid,
    this.child,
    this.childrenIds,
    this.prjId,
    this.pageId,
    this.context,
  }) : intrinsicState = getIntrinsicStates() {
    if (nid == null) this.nid = Uuid().v1();

    StreamConnection.connect(
        prjId, pageId, nid, context, (map) => mergeJson(map));
  }

  static IntrinsicStates getIntrinsicStates() {
    return types.putIfAbsent(
      globalType,
      () => DeviceInfoIntrinsicStates(),
    );
  }

  @override
  List<Object?> get props => [
        this.nid,
        this.childrenIds,
        this.prjId,
        this.pageId,
        this.context,
      ];

  static NDeviceInfo fromJson(
    Map<String, dynamic> doc,
    String prjId,
    String pageId,
    BuildContext context,
  ) {
    return NDeviceInfo(
      nid: doc[DBKeys.id],
      childrenIds: doc[DBKeys.childrenIds] != null
          ? FChildrenIds().fromJson(doc)
          : FChildrenIds(),
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
      DBKeys.childrenIds:
          childrenIds != null ? childrenIds.toJson() : FChildrenIds().toJson(),
    };
  }

  @override
  String toString() => 'Divider { nid: $nid, child: $child }';

  @override
  Widget toWidget({
    required List<VariableObject> params,
    required List<VariableObject> states,
    required List<DatasetObject> dataset,
    int? loop,
    required bool forPlay,
  }) =>
      WDeviceInfo(
        node: this,
        child: child,
        forPlay: forPlay,
        loop: loop,
        params: params,
        states: states,
        dataset: dataset,
      );

  String toCode(BuildContext context) {
    return """
      DeviceInfo(),
    """;
  }
}
*/
