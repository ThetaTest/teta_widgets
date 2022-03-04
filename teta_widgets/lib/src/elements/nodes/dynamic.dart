// Flutter imports:
// Package imports:
// ignore_for_file: public_member_api_docs, annotate_overrides, overridden_fields, lines_longer_than_80_chars

import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:teta_core/src/models/dataset.dart';
import 'package:teta_core/src/models/variable.dart';
import 'package:teta_widgets/src/elements/controls/control_model.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/features/children_ids.dart';
import 'package:teta_widgets/src/elements/intrinsic_states/class.dart';
import 'package:teta_widgets/src/elements/nodes/children_enum.dart';
import 'package:teta_widgets/src/elements/nodes/enum.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

// ignore: must_be_immutable
class NDynamic extends CNode {
  ///construct
  NDynamic({
    required this.globalType,
    required this.body,
    this.name,
    this.description,
    this.nid = 0,
    this.parent,
    this.index,
    required this.childrenIds,
    this.pageId,
    this.context,
    required this.inSpawned,
  })  : intrinsicState = getIntrinsicStates(globalType),
        super(
          childrenIds: childrenIds,
        ) {
    if (inSpawned) connect();
  }

  Future<void> connect() async {}

  static final Map<String, IntrinsicStates> types = {};

  /// type of the node
  @override
  final NType globalType;

  /// intrinsic state of node
  @override
  final IntrinsicStates intrinsicState;

  @override
  int nid;

  @override
  int? parent;

  @override
  int? index;

  /// Body has all the attributes (textStyle, ecc.) and controls of node
  @override
  NodeBody body;

  @override
  CNode? child;

  @override
  List<CNode>? children = [];

  @override
  FChildrenIds childrenIds = FChildrenIds();

  /// Current page id
  int? pageId;

  BuildContext? context;

  bool inSpawned;

  String? name;
  String? description;

  /// Get intrinsic states by node type
  static IntrinsicStates getIntrinsicStates(NType globalType) {
    return types.putIfAbsent(
      EnumToString.convertToString(globalType),
      () => IntrinsicStates.get(globalType),
    );
  }

  /// Get node body by type
  static NodeBody getBody(NType type) => NodeBody.get(type);

  @override
  List<Object?> get props => [
        name,
        description,
        nid,
        globalType,
        parent,
        index,
        body,
        body.attributes,
        ...body.props,
        childrenIds,
        pageId,
      ];

  @override
  List<ControlModel> get controls => body.controls;

  /// Instantiate a node from json
  static NDynamic fromJson(
    Map<String, dynamic> doc,
    int pageId,
  ) {
    final globalType = NodeType.fromString(doc[DBKeys.type] as String);

    List<VariableObject>? params;
    List<VariableObject>? states;

    if (globalType == NType.scaffold) {
      params = [];
      states = [];
    }

    final map = <String, dynamic>{};
    for (final e
        in doc[DBKeys.attributes] as List<dynamic>? ?? const <dynamic>[]) {
      final key = (e as Map<String, dynamic>)['name'] as String;
      dynamic value = e['value'] as dynamic;
      if (key == 'params' && globalType == NType.scaffold) {
        // for page params
        for (final e in value ?? <dynamic>[]) {
          params!.add(VariableObject.fromJson(e as Map<String, dynamic>));
        }
      } else if (key == 'states' && globalType == NType.scaffold) {
        // for page states
        for (final e in value ?? <dynamic>[]) {
          states!.add(VariableObject.fromJson(e as Map<String, dynamic>));
        }
      } else {
        // for any attribute
        value = DynamicAttributes.fromJson(key, value);
        if (value != null) map[key] = value;
      }
    }

    final body = NodeBody.fromJson(map, globalType);
    final ids = FChildrenIds.fromJson(doc);

    return NDynamic(
      name: doc['name'] as String?,
      description: doc['desc'] as String?,
      nid: doc[DBKeys.id] as int,
      globalType: globalType,
      body: body,
      childrenIds: ids,
      pageId: pageId,
      inSpawned: true,
    );
  }

  /// Update members with incoming json
  void mergeJson(
    Map<String, dynamic> map,
  ) {
    body.mergeJson(map);
    for (final key in map.keys) {
      if (key == 'name') name = map[key] as String?;
      if (key == 'desc') description = map[key] as String?;
      if (key == DBKeys.childrenIds) childrenIds = FChildrenIds.fromJson(map);
    }
  }

  /// Returns type and childrenIds
  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        DBKeys.type: NodeType.type(intrinsicState.type),
        DBKeys.childrenIds: childrenIds.toJson(),
      };

  /// Returns attributes json map
  @override
  Map<String, dynamic> attributesToJson() => body.toJson();

  @override
  String toString() =>
      '$globalType { nid: $nid, children: $children, child: $child }';

  @override
  Widget toWidget({
    required List<VariableObject> params,
    required List<VariableObject> states,
    required List<DatasetObject> dataset,
    int? loop,
    required bool forPlay,
  }) {
    return body.toWidget(
      params: params,
      states: states,
      dataset: dataset,
      forPlay: forPlay,
      loop: loop,
      node: this,
      child: child,
      children: children,
    );
  }

  @override
  String toCode(BuildContext context) => '''
      ${description != '' && description != null ? '// $description' : ''}
      ${body.toCode(context, this, child, children, pageId!, null)}
      ''';

  /// Returns if node can have at least one child (or more the one)
  bool get canHaveAtLeastOneChild =>
      (intrinsicState.canHave == ChildrenEnum.child && child == null) ||
      (intrinsicState.canHave == ChildrenEnum.children &&
          childrenIds.ids.length < (intrinsicState.maxChildren ?? 50));

  bool get canWillHaveAtLeastOneNewChild =>
      (intrinsicState.canHave == ChildrenEnum.child) ||
      (intrinsicState.canHave == ChildrenEnum.children &&
          childrenIds.ids.length < (intrinsicState.maxChildren ?? 50) - 1);

  /// Instantiate a new node (deep copy)
  NDynamic clone() => NDynamic(
        nid: nid,
        name: name,
        globalType: globalType,
        parent: parent,
        index: index,
        body: body,
        childrenIds: childrenIds,
        pageId: pageId,
        context: context,
        inSpawned: inSpawned,
      );

  /// Instantiate a new node (deep copy) with optional parameters
  NDynamic copyWith({
    int? nid,
    int? parent,
    String? name,
    int? index,
    FChildrenIds? childrenIds,
    int? pageId,
    BuildContext? context,
    bool? inSpawned,
  }) =>
      NDynamic(
        nid: nid ?? this.nid,
        name: name ?? this.name,
        globalType: globalType,
        parent: parent ?? this.parent,
        index: index ?? this.index,
        body: body,
        childrenIds: childrenIds ?? this.childrenIds,
        pageId: pageId ?? this.pageId,
        context: context ?? this.context,
        inSpawned: inSpawned ?? this.inSpawned,
      );
}
