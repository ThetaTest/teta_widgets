// Flutter imports:
// ignore_for_file: lines_longer_than_80_chars

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:teta_core/src/models/dataset.dart';
import 'package:teta_core/src/models/variable.dart';
import 'package:teta_widgets/src/elements/code/snippets.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/templates/safearea.dart';
import 'package:teta_widgets/src/elements/controls/control_model.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/intrinsic_states/class.dart';
import 'package:teta_widgets/src/elements/nodes/categories.dart';
import 'package:teta_widgets/src/elements/nodes/children_enum.dart';
import 'package:teta_widgets/src/elements/nodes/enum.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';
import 'package:teta_widgets/src/elements/widgets/safearea.dart';

const _globalType = NType.safeArea;

/// IS
final safeareaIntrinsicStates = IntrinsicStates(
  nodeIcon: Assets.wIcons.safearea,
  nodeVideo: 'EgtPleVwxBQ', //Check
  nodeDescription: null,
  advicedChildren: [
    NodeType.name(NType.text),
    NodeType.name(NType.icon),
    NodeType.name(NType.gestureDetector),
  ],
  blockedTypes: [],
  synonymous: ['safearea', 'padding'],
  advicedChildrenCanHaveAtLeastAChild: [],
  displayName: NodeType.name(_globalType),
  type: _globalType,
  category: NodeCategories.advanced,
  maxChildren: 1,
  canHave: ChildrenEnum.child,
  addChildLabels: [],
  gestures: [],
  permissions: [], packages: [],
);

/// Body
class SafeAreaBody extends NodeBody {
  @override
  // ignore: overridden_fields
  Map<String, dynamic> attributes = <String, dynamic>{
    DBKeys.left: false,
    DBKeys.top: false,
    DBKeys.right: false,
    DBKeys.bottom: false,
  };

  @override
  List<ControlModel> get controls => [
        FlagControlObject(
          title: 'Left',
          key: DBKeys.left,
          value: attributes[DBKeys.left],
          description: 'Whether to avoid system intrusions on the left.',
        ),
        FlagControlObject(
          title: 'Top',
          key: DBKeys.top,
          value: attributes[DBKeys.top],
          description:
              'Whether to avoid system intrusions at the top of the screen, typically the system status bar.',
        ),
        FlagControlObject(
          title: 'Right',
          key: DBKeys.right,
          value: attributes[DBKeys.right],
          description: 'Whether to avoid system intrusions on the right.',
        ),
        FlagControlObject(
          title: 'Bottom',
          key: DBKeys.bottom,
          value: attributes[DBKeys.bottom],
          description:
              'Whether to avoid system intrusions on the bottom side of the screen.',
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
      WSafeArea(
        ValueKey(
          '''
            ${node.nid}
            $loop
            ${child ?? children}
            ${attributes[DBKeys.left] as bool}
            ${attributes[DBKeys.top] as bool}
            ${attributes[DBKeys.right] as bool}
            ${attributes[DBKeys.bottom] as bool}
            ''',
        ),
        node: node,
        child: child,
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
  Future<String> toCode(
    final BuildContext context,
    final CNode node,
    final CNode? child,
    final List<CNode>? children,
    final int pageId,
    final int? loop,
  ) =>
      CS.defaultWidgets(
        context,
        node,
        pageId,
        SafeAreaCodeTemplate.toCode(context, this, child),
        loop ?? 0,
      );
}
