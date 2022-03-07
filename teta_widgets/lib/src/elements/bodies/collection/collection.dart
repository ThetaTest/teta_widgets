/*import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:firebase/firebase.dart';
import 'package:mobile_editor/src/elements/builder/stream_connection.dart';
import 'package:mobile_editor/src/elements/controls/key_constants.dart';
import 'package:mobile_editor/src/elements/features/children_ids.dart';
import 'package:mobile_editor/src/elements/features/text_type_input.dart';
import 'package:mobile_editor/src/elements/intrinsic_states/class.dart';
import 'package:mobile_editor/src/elements/nodes/categories.dart';
import 'package:mobile_editor/src/elements/nodes/children_enum.dart';
import 'package:mobile_editor/src/elements/nodes/enum.dart';
import 'package:mobile_editor/src/elements/nodes/node.dart';
import 'package:mobile_editor/src/elements/widgets/collection/collection.dart';
import 'package:mobile_editor/src/models/dataset.dart';
import 'package:mobile_editor/src/models/variable.dart';
import 'package:uuid/uuid.dart';

const globalType = NType;

final collectionIntrinsicStates = IntrinsicStates(
  nodeIcon: "w_icons/gesture_detector.png",
  nodeVideo: null,
  nodeDescription: null,
  advicedChildren: [
    NodeType.name(NType.container),
    NodeType.name(NType.column),
    NodeType.name(NType.row),
  ],
  blockedTypes: [],
  synonymous: ['apple', 'login', 'cta', 'button'],
  advicedChildrenCanHaveAtLeastAChild: [],
  displayName: NodeType.name(globalType),
  type: globalType,
  category: NodeCategories.unclassified,
  maxChildren: 1,
  canHave: ChildrenEnum.child,
  addChildLabels: [],
);

class CollectionIntrinsicStates extends IntrinsicStates {
  final String nodeIcon = "w_icons/positioned.png";
  final String? nodeVideo = null;
  final String? nodeDescription = null;
  final List<String> advicedChildren = [];
  final List<String> blockedTypes = [];
  final List<String> synonymous = [];
  final List<String> advicedChildrenCanHaveAtLeastAChild = [];
  final String displayName = globalType;
  final NType type = NType.nil;
}

//ignore: must_be_immutable
class NCollection extends CNode {
  static final Map<String, IntrinsicStates> types = {};

  final IntrinsicStates intrinsicState;
  static String get nodeType => globalType;
  static String get nodeName => globalType;
  String? parent;
  String? nid;
  CNode? child;
  FChildrenIds childrenIds;
  FTextTypeInput? value;
  bool? isHorizontalScroll;
  String? result;
  bool? displayRealData;
  int? index;

  String? prjId;
  String? pageId;
  BuildContext? context;
  StreamSubscription? streamSubscription;
  Database db = database();
  DatabaseReference? ref;

  NCollection({
    this.nid,
    this.value,
    this.child,
    required this.childrenIds,
    this.isHorizontalScroll,
    this.displayRealData,
    this.prjId,
    this.pageId,
    this.context,
  })  : intrinsicState = getIntrinsicStates(),
        super(childrenIds: FChildrenIds()) {
    if (this.nid == null) this.nid = Uuid().v1();
    if (this.value == null)
      this.value = FTextTypeInput(
        type: FTextTypeEnum.text,
        value: '',
      );
    if (this.isHorizontalScroll == null) isHorizontalScroll = false;
    if (this.displayRealData == null) displayRealData = false;

    StreamConnection.connect(
        prjId, pageId, nid, context, (map) => mergeJson(map));
  }

  static IntrinsicStates getIntrinsicStates() {
    return types.putIfAbsent(
      globalType,
      () => CollectionIntrinsicStates(),
    );
  }

  @override
  List<Object?> get props => [
        this.nid,
        this.value,
        this.child,
        this.childrenIds,
        this.isHorizontalScroll,
        this.displayRealData,
        this.prjId,
        this.pageId,
        this.context,
      ];

  @override
  String toString() => '$globalType { nid: $nid, value: $value }';

  @override
  Widget toWidget({
    required List<VariableObject> params,
    required List<VariableObject> states,
    required List<DatasetObject> dataset,
    int? loop,
    required bool forPlay,
  }) =>
      WCollection(
        nid: nid,
        node: this,
        value: value,
        forPlay: forPlay,
        child: child,
        displayRealData: displayRealData,
        params: params,
        states: states,
        dataset: dataset,
      );

  static NCollection fromJson(
    Map<String, dynamic> doc,
    String prjId,
    String pageId,
    BuildContext context,
  ) {
    return NCollection(
      nid: doc[DBKeys.id],
      value: FTextTypeInput().fromJson(doc[DBKeys.value]),
      childrenIds: FChildrenIds.fromJson(doc),
      isHorizontalScroll: doc['HScroll'],
      displayRealData: doc['displayRealData'] ?? false,
      prjId: prjId,
      pageId: pageId,
      context: context,
    );
  }

  mergeJson(
    Map<String, dynamic> map,
  ) {
    map.keys.forEach((key) {
      if (key == DBKeys.value) value = FTextTypeInput().fromJson(map[key]);
      if (key == DBKeys.childrenIds) childrenIds = FChildrenIds.fromJson(map);
      if (key == 'HScroll') isHorizontalScroll = map[key];
      if (key == 'displayRealData') displayRealData = map[key];
    });
  }

  Map<String, dynamic> toJson() {
    return {
      DBKeys.id: nid,
      DBKeys.type: globalType,
      DBKeys.value:
          (value != null) ? value!.toJson() : FTextTypeInput().toJson(),
      DBKeys.childrenIds: childrenIds.toJson(),
      'HScroll': isHorizontalScroll,
      'displayRealData': displayRealData,
    };
  }

  String toCode(BuildContext context) {
    /*String strChild = 'const SizedBox()';
    if (child != null) strChild = child!.toCode(context);*/

    return """
    TCollection(
      value: "${value!.toJson()}",
      HScroll: $isHorizontalScroll,
    ),
    """;
  }
}
*/
