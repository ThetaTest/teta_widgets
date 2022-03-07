// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:teta_core/src/models/dataset.dart';
import 'package:teta_core/src/models/variable.dart';

// Project imports:
import 'package:teta_widgets/src/elements/code/templates/ignore_pointer.dart';
import 'package:teta_widgets/src/elements/controls/control_model.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/intrinsic_states/class.dart';
import 'package:teta_widgets/src/elements/nodes/categories.dart';
import 'package:teta_widgets/src/elements/nodes/children_enum.dart';
import 'package:teta_widgets/src/elements/nodes/enum.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';
import 'package:teta_widgets/src/elements/widgets/ignore_pointer.dart';

const _globalType = NType.ignorePointer;

/// Intrinsic States IgnorePointer
final ignorePointIntrinsicStates = IntrinsicStates(
  nodeIcon: Assets.wIcons.ignorePointer,
  nodeVideo: null,
  nodeDescription: null,
  advicedChildren: [
    NodeType.name(NType.container),
    NodeType.name(NType.column),
    NodeType.name(NType.row),
  ],
  blockedTypes: [],
  synonymous: ['disabled', 'ignore pointer'],
  advicedChildrenCanHaveAtLeastAChild: [],
  displayName: NodeType.name(_globalType),
  type: _globalType,
  category: NodeCategories.logic,
  maxChildren: 1,
  canHave: ChildrenEnum.child,
  addChildLabels: [],
  gestures: [],
);

/// IgnorePointer's body
class IgnorePointerBody extends NodeBody {
  @override
  // ignore: overridden_fields
  Map<String, dynamic> attributes = <String, dynamic>{
    DBKeys.flag: false,
  };

  @override
  List<ControlModel> get controls => [
        FlagControlObject(
          title: 'Ignoring',
          key: DBKeys.flag,
          value: attributes[DBKeys.flag],
          description: '',
        ),
      ];

  @override
  Widget toWidget({
    required List<VariableObject> params,
    required List<VariableObject> states,
    required List<DatasetObject> dataset,
    required bool forPlay,
    required CNode node,
    int? loop,
    CNode? child,
    List<CNode>? children,
  }) =>
      WIgnorePointer(
        ValueKey(
          '''
      ${node.nid}
      $loop
            ${child ?? children}
      ${attributes[DBKeys.flag] as bool}
      ''',
        ),
        node: node,
        child: child,
        flag: attributes[DBKeys.flag] as bool,
        forPlay: forPlay,
        loop: loop,
        params: params,
        states: states,
        dataset: dataset,
      );

  @override
  String toCode(
    BuildContext context,
    CNode node,
    CNode? child,
    List<CNode>? children,
    int pageId,
    int? loop,
  ) =>
      ignorePointerCodeTemplate(context, this, child);
}