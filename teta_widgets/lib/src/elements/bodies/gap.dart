import 'package:flutter/material.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/code/templates/gap.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/features/features.dart';
import 'package:teta_widgets/src/elements/intrinsic_states/class.dart';
import 'package:teta_widgets/src/elements/nodes/categories.dart';
import 'package:teta_widgets/src/elements/nodes/children_enum.dart';
import 'package:teta_widgets/src/elements/nodes/enum.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';
import 'package:teta_widgets/src/elements/widgets/gap.dart';

const _globalType = NType.gap;

//Todo: change nodeIcon

final gapIntrinsicStates = IntrinsicStates(
    nodeIcon: Assets.wIcons.sizedBox,
    nodeVideo: null,
    nodeDescription: null,
    advicedChildren: [],
    blockedTypes: [],
    synonymous: ['gap', 'spacer'],
    advicedChildrenCanHaveAtLeastAChild: [],
    displayName: NodeType.name(_globalType),
    type: _globalType,
    maxChildren: 0,
    category: NodeCategories.space,
    canHave: ChildrenEnum.none,
    addChildLabels: [],
    gestures: [],
    permissions: [],
    packages: []);

class GapBody extends NodeBody {
  @override
  Map<String, dynamic> get attributes => <String, dynamic>{
        DBKeys.mainAxisExtend: FSize(size: '0', unit: SizeUnit.pixel),
        DBKeys.crossAxisExtend: FSize(size: '0', unit: SizeUnit.pixel),
        DBKeys.isExpandedGap: bool,
      };

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
      WGap(
        ValueKey(
          '''
            ${node.nid}
            $loop
            ${child ?? children}
            ${(attributes[DBKeys.mainAxisExtend] as FSize? ?? FSize()).toJson()}
            ${(attributes[DBKeys.crossAxisExtend] as FSize? ?? FSize()).toJson()}
            ''',
        ),
        node: node,
        params: params,
        states: states,
        dataset: dataset,
        forPlay: forPlay,
        mainAxisExtent: attributes[DBKeys.mainAxisExtend] as FSize,
        crossAxisExtent: attributes[DBKeys.crossAxisExtend] as FSize,
        isExpanded: attributes[DBKeys.isExpandedGap] as bool,
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
        GapCodeTemplate.toCode(context, this, child),
        loop ?? 0,
      );
}
