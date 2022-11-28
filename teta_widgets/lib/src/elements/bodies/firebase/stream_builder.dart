// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:teta_core/src/models/variable.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:teta_widgets/src/elements/controls/control_model.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/controls/type.dart';
import 'package:teta_widgets/src/elements/features/firestore_path.dart';
import 'package:teta_widgets/src/elements/intrinsic_states/class.dart';
import 'package:teta_widgets/src/elements/nodes/categories.dart';
import 'package:teta_widgets/src/elements/nodes/children_enum.dart';
import 'package:teta_widgets/src/elements/nodes/enum.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';
import 'package:teta_widgets/src/elements/widgets/firebase/firebase_stream_builder.dart';

const _globalType = NType.firebaseStreamBuilder;

/// Intrinsic States of Firebase Stream Builder
final firebaseStreamBuilderIntrinsicStates = IntrinsicStates(
  nodeIcon: Assets.icons.left.dataset,
  nodeVideo: null,
  nodeDescription: null,
  advicedChildren: [
    NodeType.name(NType.container),
    NodeType.name(NType.column),
    NodeType.name(NType.row),
  ],
  blockedTypes: [],
  synonymous: [NodeType.name(_globalType), 'firestore', 'firebase', 'stream builder'],
  advicedChildrenCanHaveAtLeastAChild: [],
  displayName: NodeType.name(_globalType),
  type: _globalType,
  category: NodeCategories.firebase,
  maxChildren: 1,
  canHave: ChildrenEnum.child,
  addChildLabels: [],
  gestures: [],
  permissions: [],
  packages: [],
);

/// Firebase Stream Builder's body
class FirebaseSBBody extends NodeBody {
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
          valueType: VariableType.string,
        )
      ];

  @override
  Widget toWidget({
    required final TetaWidgetState state,
    final CNode? child,
    final List<CNode>? children,
  }) =>
      WFirebaseStreamBuilder(
        ValueKey('${state.node.nid} ${state.loop}'),
        state: state,
        child: child,
        path: attributes[DBKeys.firestorePath] as FFirestorePath,
      );

  @override
  Future<String> toCode(
    final BuildContext context,
    final CNode node,
    final CNode? child,
    final List<CNode>? children,
    final int pageId,
    final int? loop,
  ) =>
      Future.value('''
    Firebase(
    )
  ''');
}
