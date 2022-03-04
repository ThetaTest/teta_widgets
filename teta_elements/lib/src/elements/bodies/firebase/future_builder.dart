// Flutter imports:
import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:teta_core/src/models/dataset.dart';
import 'package:teta_core/src/models/variable.dart';
import 'package:teta_elements/src/elements/code/firestore/future_builder.dart';
import 'package:teta_elements/src/elements/controls/control_model.dart';
import 'package:teta_elements/src/elements/controls/key_constants.dart';
import 'package:teta_elements/src/elements/controls/type.dart';
import 'package:teta_elements/src/elements/features/firestore_path.dart';
import 'package:teta_elements/src/elements/intrinsic_states/class.dart';
import 'package:teta_elements/src/elements/nodes/categories.dart';
import 'package:teta_elements/src/elements/nodes/children_enum.dart';
import 'package:teta_elements/src/elements/nodes/enum.dart';
import 'package:teta_elements/src/elements/nodes/node.dart';
import 'package:teta_elements/src/elements/nodes/node_body.dart';
import 'package:teta_widgets/src/widgets/firebase/firebase_future_builder.dart';

const _globalType = NType.firebaseFutureBuilder;

/// NOT IN USE
/// Instrinsic State of Firebase Future Builder
final firebaseFutureBuilderIntrinsicStates = IntrinsicStates(
  nodeIcon: Assets.icons.left.dataset,
  nodeVideo: null,
  nodeDescription: null,
  advicedChildren: [
    NodeType.name(NType.container),
    NodeType.name(NType.column),
    NodeType.name(NType.row)
  ],
  blockedTypes: [],
  synonymous: [
    NodeType.name(_globalType),
    'firestore',
    'firebase',
    'future builder',
  ],
  advicedChildrenCanHaveAtLeastAChild: [],
  displayName: NodeType.name(_globalType),
  type: _globalType,
  category: NodeCategories.firebase,
  maxChildren: 1,
  canHave: ChildrenEnum.child,
  addChildLabels: [],
  gestures: [],
);

/// Firebase FB's body
class FirebaseFBBody extends NodeBody {
  @override
  // ignore: overridden_fields
  Map<String, dynamic> attributes = <String, dynamic>{
    DBKeys.firestorePath: FFirestorePath(),
  };

  @override
  List<ControlModel> get controls => [
        ControlObject(
          type: ControlType.firebasePath,
          key: DBKeys.firestorePath,
          value: attributes[DBKeys.firestorePath],
        )
      ];

  @override
  Widget toWidget({
    required List<VariableObject> params,
    required List<VariableObject> states,
    required List<DatasetObject> dataset,
    int? loop,
    required bool forPlay,
    required CNode node,
    CNode? child,
    List<CNode>? children,
  }) =>
      WFirebaseFutureBuilder(
        node: node,
        child: child,
        path: attributes[DBKeys.firestorePath] as FFirestorePath,
        forPlay: forPlay,
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
      firestoreFutureBuilderCodeTemplate(context, this, children ?? []);
}
