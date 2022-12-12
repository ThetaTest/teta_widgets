// Flutter imports:
// ignore_for_file: lines_longer_than_80_chars

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:teta_core/src/models/variable.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
import 'package:teta_widgets/src/elements/code/templates/cms_custom_query.dart';
// Project imports:
import 'package:teta_widgets/src/elements/controls/control_model.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/controls/type.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_widgets/src/elements/intrinsic_states/class.dart';
import 'package:teta_widgets/src/elements/nodes/categories.dart';
import 'package:teta_widgets/src/elements/nodes/children_enum.dart';
import 'package:teta_widgets/src/elements/nodes/dynamic.dart';
import 'package:teta_widgets/src/elements/nodes/enum.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';
import 'package:teta_widgets/src/elements/widgets/teta_cms/custom_query.dart';

const _globalType = NType.cmsCustomQuery;

/// IS
final cmsCustomQueryStates = IntrinsicStates(
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
    'cms custom query',
    'teta',
    'articles',
    'feed',
  ],
  advicedChildrenCanHaveAtLeastAChild: [],
  displayName: NodeType.name(_globalType),
  type: _globalType,
  category: NodeCategories.basic,
  maxChildren: 2,
  canHave: ChildrenEnum.children,
  addChildLabels: [],
  gestures: [],
  permissions: [],
  packages: [],
);

/// Body
class CmsCustomQueryBody extends NodeBody {
  @override
  // ignore: overridden_fields
  Map<String, dynamic> attributes = <String, dynamic>{
    DBKeys.value: FTextTypeInput(
      value: '''
MATCH name EQ CollectionName;
IN docs;
MATCHOR _name EQ 'value' _name LIKE 'value2';
SORT _name 1;
LIMIT 10;''',
    ),
  };

  @override
  List<ControlModel> get controls => [
        ControlObject(
          title: 'Collection',
          type: ControlType.cmsCustomQuery,
          key: DBKeys.value,
          value: attributes[DBKeys.value],
          description: 'Fetch all documents by specific query',
          valueType: VariableType.string,
        ),
      ];

  @override
  Widget toWidget({
    required final TetaWidgetState state,
    final CNode? child,
    final List<CNode>? children,
  }) {
    return WCmsCustomQuery(
      ValueKey(
        '''
        ${state.toKey}
        ${child ?? children}
        ${(attributes[DBKeys.value] as FTextTypeInput).toJson()}
        ${(attributes[DBKeys.value] as FTextTypeInput).getStateValue(state.states)}
      ''',
      ),
      state: state,
      children: children ?? [],
      query: attributes[DBKeys.value] as FTextTypeInput,
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
      CmsCustomQueryCodeTemplate.toCode(
        context,
        node as NDynamic,
        children ?? <CNode>[],
        loop,
      );
}
