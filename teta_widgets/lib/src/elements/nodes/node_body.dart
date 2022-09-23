// Flutter imports:
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:teta_core/src/models/dataset.dart';
import 'package:teta_core/src/models/variable.dart';

// Project imports:
import 'package:teta_widgets/src/elements/control_center.dart';
import 'package:teta_widgets/src/elements/controls/control_model.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/nodes/enum.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';

/// The body of nodes, you can declare here all the node' attributes
class NodeBody extends Equatable {
  /// Constructor
  NodeBody();

  /// Attributes of each node
  Map<String, dynamic> attributes = <String, dynamic>{};

  /// Get all node controls.
  /// Controls are the widgets showed on right bar,
  /// used to change node's attributes.
  List<ControlModel> get controls => [];

  /// [doc] is parsed from up level NDynamic widget
  static NodeBody fromJson(
    final Map<String, dynamic> doc,
    final NType type,
  ) {
    final body = NodeBody.get(type);
    for (final key in doc.keys) {
      body.attributes[key] = doc[key];
    }
    return body;
  }

  /// Update [attributes] by incoming json
  void mergeJson(
    final Map<String, dynamic> map,
  ) {
    for (final key in map.keys) {
      attributes[key] = DynamicAttributes.fromJson(key, map[key]);
    }
  }

  /// Transform [attributes] in json
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    for (final key in attributes.keys) {
      map[key] = DynamicAttributes.toJson(key, attributes[key]);
    }
    return map;
  }

  /// Render node with [attributes] to Widget
  Widget toWidget({
    required final List<VariableObject> params,
    required final List<VariableObject> states,
    required final List<DatasetObject> dataset,
    required final bool forPlay,
    required final CNode node,
    final int? loop,
    final CNode? child,
    final List<CNode>? children,
  }) =>
      const SizedBox();

  /// Get props for comparing
  @override
  List<Object?> get props => [
        attributes,
      ];

  @override
  String toString() => 'Body { attributes; $attributes }';

  /// Render a node to widget thought body
  Future<String> toCode(
    final BuildContext context,
    final CNode node,
    final CNode? child,
    final List<CNode>? children,
    final int pageId,
    final int? loop,
  ) =>
      Future.value('');

  /// Initialization code representation
  String toCodeOnInit(
    final BuildContext context,
    final CNode node,
    final CNode? child,
    final List<CNode>? children,
    final int pageId,
    final int? loop,
    final List<NType> existingNodeTypes,
  ) {
    existingNodeTypes.add(node.globalType);
    final buffer = StringBuffer()..write('');
    if (child != null) {
      buffer.write(
        child.body.toCodeOnInit(
          context,
          child,
          child.child,
          child.children,
          pageId,
          loop,
          existingNodeTypes,
        ),
      );
    } else if (children != null) {
      for (final e in children) {
        buffer.write(
          e.body.toCodeOnInit(
            context,
            e,
            e.child,
            e.children,
            pageId,
            loop,
            existingNodeTypes,
          ),
        );
      }
    }
    return buffer.toString();
  }

  /// Additional classes code representation
  String toCodeAdditionalClasses(
    final BuildContext context,
    final CNode node,
    final CNode? child,
    final List<CNode>? children,
    final int pageId,
    final int? loop,
    final List<NType> existingNodeTypes,
  ) {
    existingNodeTypes.add(node.globalType);
    final buffer = StringBuffer()..write('');
    if (child != null) {
      buffer.write(
        child.body.toCodeAdditionalClasses(
          context,
          child,
          child.child,
          child.children,
          pageId,
          loop,
          existingNodeTypes,
        ),
      );
    } else if (children != null) {
      for (final e in children) {
        buffer.write(
          e.body.toCodeAdditionalClasses(
            context,
            e,
            e.child,
            e.children,
            pageId,
            loop,
            existingNodeTypes,
          ),
        );
      }
    }
    return buffer.toString();
  }

  /// Get body
  static NodeBody get(final NType type) => getBody(type);
}
