// Flutter imports:
// ignore_for_file: lines_longer_than_80_chars

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:teta_core/src/models/dataset.dart';
import 'package:teta_core/src/models/variable.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/templates/positioned.dart';
import 'package:teta_widgets/src/elements/controls/control_model.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/controls/type.dart';
import 'package:teta_widgets/src/elements/features/margins.dart';
import 'package:teta_widgets/src/elements/intrinsic_states/class.dart';
import 'package:teta_widgets/src/elements/nodes/categories.dart';
import 'package:teta_widgets/src/elements/nodes/children_enum.dart';
import 'package:teta_widgets/src/elements/nodes/enum.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';
import 'package:teta_widgets/src/elements/widgets/positioned.dart';

const _globalType = NType.positioned;

/// IS
final positionedIntrinsicStates = IntrinsicStates(
  nodeIcon: Assets.wIcons.positioned,
  nodeVideo: 'EgtPleVwxBQ', //Check
  nodeDescription: null,
  advicedChildren: [
    NodeType.name(NType.container),
    NodeType.name(NType.column),
    NodeType.name(NType.row),
  ],
  blockedTypes: [],
  synonymous: ['positioned', 'absolute', 'relative'],
  advicedChildrenCanHaveAtLeastAChild: [],
  displayName: NodeType.name(_globalType),
  type: _globalType,
  category: NodeCategories.unclassified,
  maxChildren: 1,
  canHave: ChildrenEnum.child,
  addChildLabels: [],
  gestures: [],
);

/// Body
class PositionedBody extends NodeBody {
  @override
  // ignore: overridden_fields
  Map<String, dynamic> attributes = <String, dynamic>{
    DBKeys.left: false,
    DBKeys.top: false,
    DBKeys.right: false,
    DBKeys.bottom: false,
    DBKeys.margins: FMargins()
  };

  @override
  List<ControlModel> get controls => [
        ControlObject(
          type: ControlType.margins,
          key: DBKeys.margins,
          value: attributes[DBKeys.margins],
        ),
        FlagControlObject(
          title: 'Left',
          key: DBKeys.left,
          value: attributes[DBKeys.left],
          description:
              "The distance that the child's left edge is inset from the left of the stack.",
        ),
        FlagControlObject(
          title: 'Top',
          key: DBKeys.top,
          value: attributes[DBKeys.top],
          description:
              "The distance that the child's top edge is inset from the top of the stack.",
        ),
        FlagControlObject(
          title: 'Right',
          key: DBKeys.right,
          value: attributes[DBKeys.right],
          description:
              "The distance that the child's right edge is inset from the right of the stack.",
        ),
        FlagControlObject(
          title: 'Bottom',
          key: DBKeys.bottom,
          value: attributes[DBKeys.bottom],
          description:
              "The distance that the child's bottom edge is inset from the bottom of the stack.",
        ),
      ];

  @override
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
      WPositioned(
        ValueKey(
          '''
            ${node.nid}
            $loop
            ${child ?? children}
            ${(attributes[DBKeys.margins] as FMargins).toJson()}, 
            ${attributes[DBKeys.left] as bool}, 
            ${attributes[DBKeys.top] as bool}, 
            ${attributes[DBKeys.right] as bool}, 
            ${attributes[DBKeys.bottom] as bool}
            ''',
        ),
        node: node,
        child: child,
        margins: attributes[DBKeys.margins] as FMargins,
        left: attributes[DBKeys.left] as bool,
        top: attributes[DBKeys.top] as bool,
        right: attributes[DBKeys.right] as bool,
        bottom: attributes[DBKeys.bottom] as bool,
        forPlay: forPlay,
        loop: loop,
        params: params,
        states: states,
        dataset: dataset,
      );

  @override
  String toCode(
    final BuildContext context,
    final CNode node,
    final CNode? child,
    final List<CNode>? children,
    final int pageId,
    final int? loop,
  ) =>
      positionedCodeTemplate(context, this, child);
}
