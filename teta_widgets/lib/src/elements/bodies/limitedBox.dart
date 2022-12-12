// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/code/templates/limitedBox.dart';
// Project imports:
import 'package:teta_widgets/src/elements/controls/control_model.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/controls/type.dart';
import 'package:teta_widgets/src/elements/features/sizes.dart';
import 'package:teta_widgets/src/elements/intrinsic_states/class.dart';
import 'package:teta_widgets/src/elements/nodes/categories.dart';
import 'package:teta_widgets/src/elements/nodes/children_enum.dart';
import 'package:teta_widgets/src/elements/nodes/enum.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';
import 'package:teta_widgets/src/elements/widgets/limited_box.dart';

const _globalType = NType.limitedBox;

/// Instrinsic States of LimitedBox

final limitedBoxIntrinsicStates = IntrinsicStates(
  nodeIcon: Assets.wIcons.box,
  nodeVideo: '',
  nodeDescription: '',
  advicedChildren: [
    NodeType.name(NType.column),
    NodeType.name(NType.container),
    NodeType.name(NType.row),
  ],
  blockedTypes: [],
  synonymous: ['limitedbox', 'box', 'container', 'square', 'div'],
  advicedChildrenCanHaveAtLeastAChild: [],
  displayName: NodeType.name(_globalType),
  type: _globalType,
  category: NodeCategories.basic,
  maxChildren: 1,
  canHave: ChildrenEnum.child,
  addChildLabels: [],
  gestures: [],
  permissions: [],
  packages: [],
);

class LimitedBoxBody extends NodeBody {
  @override
  // ignore: overridden_fields
  Map<String, dynamic> attributes = <String, dynamic>{
    DBKeys.maxWidth: FSize(size: 'max'),
    DBKeys.maxHeight: FSize(size: '250'),
  };

  @override
  List<ControlModel> get controls => [
        SizeControlObject(
          type: ControlType.size,
          key: DBKeys.maxWidth,
          title: 'Max Width',
          isWidth: true,
          value: attributes[DBKeys.maxWidth] as FSize,
        ),
        SizeControlObject(
          type: ControlType.size,
          key: DBKeys.maxHeight,
          title: 'Max Height',
          isWidth: false,
          value: attributes[DBKeys.maxHeight] as FSize,
        ),
      ];

  @override
  Widget toWidget({
    required final TetaWidgetState state,
    final CNode? child,
    final List<CNode>? children,
  }) {
    return WLimitedBox(
      ValueKey(
        '''
          ${state.toKey}
          ${child ?? children}
          ${(attributes[DBKeys.maxWidth] as FSize).toJson()},
          ${(attributes[DBKeys.maxHeight] as FSize).toJson()},
        ''',
      ),
      state: state,
      maxWidth: attributes[DBKeys.maxWidth] as FSize,
      maxHeight: attributes[DBKeys.maxHeight] as FSize,
      child: child,
    );
  }

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
        LimitedBoxCodeTemplate.toCode(context, this, child, loop),
        loop ?? 0,
      );
}
