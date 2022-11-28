// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/templates/cupertino_switch.dart';
import 'package:teta_widgets/src/elements/controls/control_model.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/features/action.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/gestures.dart';
import 'package:teta_widgets/src/elements/intrinsic_states/class.dart';
import 'package:teta_widgets/src/elements/nodes/categories.dart';
import 'package:teta_widgets/src/elements/nodes/children_enum.dart';
import 'package:teta_widgets/src/elements/nodes/enum.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';
import 'package:teta_widgets/src/elements/widgets/cupertino_switch.dart';

const _globalType = NType.cupertinoSwitch;

/// Instrict State of Cupertino Switch
final cupertinoSwitchIntrinsicStates = IntrinsicStates(
  nodeIcon: Assets.wIcons.cupertinoSwitch,
  nodeVideo: null,
  nodeDescription: '''
      A widget that detects gestures. 
      Attempts to recognize gestures that correspond to its non-null callbacks. 
      If this widget has a child, 
      it defers to that child for its sizing behavior. 
      If it does not have a child, it grows to fit the parent instead. 
      By default a GestureDetector with an invisible child ignores touches;''',
  advicedChildren: [
    NodeType.name(NType.container),
    NodeType.name(NType.image),
  ],
  blockedTypes: [],
  synonymous: ['cupertinoSwitch', 'checkbox', 'radio', 'ontap', 'onpressed', 'click'],
  advicedChildrenCanHaveAtLeastAChild: [],
  displayName: NodeType.name(_globalType),
  type: _globalType,
  category: NodeCategories.unclassified,
  maxChildren: 1,
  canHave: ChildrenEnum.none,
  addChildLabels: [],
  gestures: [
    ActionGesture.onChange,
  ],
  permissions: [],
  packages: [],
);

/// Instrict State of Cupertino Switch
class CupertinoSwitchBody extends NodeBody {
  @override
  // ignore: overridden_fields
  Map<String, dynamic> attributes = <String, dynamic>{
    DBKeys.action: FAction(),
  };

  @override
  List<ControlModel> get controls => [];

  @override
  Widget toWidget({
    required final TetaWidgetState state,
    final CNode? child,
    final List<CNode>? children,
  }) =>
      WCupertinoSwitch(
        ValueKey(
          '''
          ${state.node.nid}
          ${state.loop}
          ${child ?? children}
          ${(attributes[DBKeys.action] as FAction).toJson()}
          ''',
        ),
        state: state,
        child: child,
        action: attributes[DBKeys.action] as FAction,
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
      CupertinoSwitchCodeTemplate.toCode(
        pageId,
        context,
        this,
        node,
        child,
        loop ?? 0,
      );
}
