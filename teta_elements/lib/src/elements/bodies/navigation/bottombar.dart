// Flutter imports:
import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:teta_core/src/models/dataset.dart';
import 'package:teta_core/src/models/variable.dart';
import 'package:teta_elements/src/elements/code/templates/navigation/bottombar.dart';
import 'package:teta_elements/src/elements/controls/control_model.dart';
import 'package:teta_elements/src/elements/intrinsic_states/class.dart';
import 'package:teta_elements/src/elements/nodes/categories.dart';
import 'package:teta_elements/src/elements/nodes/children_enum.dart';
import 'package:teta_elements/src/elements/nodes/enum.dart';
import 'package:teta_elements/src/elements/nodes/node.dart';
import 'package:teta_elements/src/elements/nodes/node_body.dart';
import 'package:teta_widgets/src/widgets/navigation/bottombar.dart';

const _globalType = NType.bottomBar;

/// IS
final bottomBarIntrinsicStates = IntrinsicStates(
  nodeIcon: Assets.wIcons.bottomBar,
  nodeVideo: null,
  nodeDescription: null,
  advicedChildren: [],
  blockedTypes: [],
  synonymous: [],
  advicedChildrenCanHaveAtLeastAChild: [],
  displayName: NodeType.name(_globalType),
  type: _globalType,
  category: NodeCategories.unclassified,
  maxChildren: 1,
  canHave: ChildrenEnum.child,
  addChildLabels: ['Add BottomBar Widget'],
  gestures: [],
);

/// Body
class BottomBarBody extends NodeBody {
  @override
  // ignore: overridden_fields
  Map<String, dynamic> attributes = <String, dynamic>{};

  @override
  List<ControlModel> get controls => [];

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
      WBottomBar(
        node: node,
        child: child,
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
      bottomBarCodeTemplate(context, this, child);
}
