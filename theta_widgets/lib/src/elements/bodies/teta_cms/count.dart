// Flutter imports:
// ignore_for_file: lines_longer_than_80_chars

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:theta_models/src/models/variable.dart';
import 'package:theta_widgets/src/core/teta_widget/index.dart';
import 'package:theta_widgets/src/elements/code/templates/cms_count.dart';
// Project imports:
import 'package:theta_widgets/src/elements/controls/control_model.dart';
import 'package:theta_widgets/src/elements/controls/key_constants.dart';
import 'package:theta_widgets/src/elements/controls/type.dart';
import 'package:theta_widgets/src/elements/features/text_type_input.dart';
import 'package:theta_widgets/src/elements/intrinsic_states/class.dart';
import '../../../../../../../teta_open_classes/lib/src/nodes/categories.dart';
import '../../../../../../../teta_open_classes/lib/src/nodes/children_enum.dart';
import '../../../../../../../teta_open_classes/lib/src/nodes/dynamic.dart';
import '../../../../../../../teta_open_classes/lib/src/nodes/enum.dart';
import '../../../../../../../teta_open_classes/lib/src/nodes/node.dart';
import '../../../../../../../teta_open_classes/lib/src/nodes/node_body.dart';
import 'package:theta_widgets/src/elements/widgets/teta_cms/count.dart';

const _globalType = NType.cmsCount;

/// IS
final cmsCountIntrinsicStates = IntrinsicStates(
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
    'cms',
    'teta',
    'articles',
    'feed',
  ],
  advicedChildrenCanHaveAtLeastAChild: [],
  displayName: NodeType.name(_globalType),
  type: _globalType,
  category: NodeCategories.dynamicCollection,
  maxChildren: 2,
  canHave: ChildrenEnum.children,
  addChildLabels: ['Add new if successful', 'Add new if empty or failed'],
  gestures: [],
  permissions: [],
  packages: [],
);

/// Body
class CmsCountBody extends NodeBody {
  @override
  // ignore: overridden_fields
  Map<String, dynamic> attributes = <String, dynamic>{
    DBKeys.cmsCollection: FTextTypeInput(),
    DBKeys.cmsLimit: FTextTypeInput(),
    DBKeys.cmsPage: FTextTypeInput(),
    DBKeys.cmsLikeKey: FTextTypeInput(),
    DBKeys.cmsLikeValue: FTextTypeInput(),
    DBKeys.flag: true,
  };

  @override
  List<ControlModel> get controls => [
        ControlObject(
          title: 'Collection',
          type: ControlType.cmsCollections,
          key: DBKeys.cmsCollection,
          value: attributes[DBKeys.cmsCollection],
          description: 'Fetch all documents of a specific collection by name',
          valueType: VariableType.string,
        ),
        ControlObject(
          title: 'Limit',
          type: ControlType.value,
          key: DBKeys.cmsLimit,
          value: attributes[DBKeys.cmsLimit],
          description: 'Limit the number of docs per page',
          valueType: VariableType.int,
        ),
        ControlObject(
          title: 'Page',
          type: ControlType.value,
          key: DBKeys.cmsPage,
          value: attributes[DBKeys.cmsPage],
          description: 'Index of page',
          valueType: VariableType.int,
        ),
        ControlObject(
          title: 'Like: key',
          type: ControlType.value,
          key: DBKeys.cmsLikeKey,
          value: attributes[DBKeys.cmsLikeKey],
          description: 'Like op: the key name used to filter',
          valueType: VariableType.string,
        ),
        ControlObject(
          title: 'Like: value',
          type: ControlType.value,
          key: DBKeys.cmsLikeValue,
          value: attributes[DBKeys.cmsLikeValue],
          description: 'Like op: the value to search in db',
          valueType: VariableType.string,
        ),
      ];

  @override
  Widget toWidget({
    required final TetaWidgetState state,
    final CNode? child,
    final List<CNode>? children,
  }) {
    return WCmsCount(
      ValueKey(
        '''
        ${state.toKey}
        ${child ?? children}
        ${(attributes[DBKeys.cmsCollection] as FTextTypeInput).toJson()}
        ${(attributes[DBKeys.cmsLimit] as FTextTypeInput).toJson()}
        ${(attributes[DBKeys.cmsPage] as FTextTypeInput).toJson()}
        ${(attributes[DBKeys.cmsLikeKey] as FTextTypeInput).toJson()}
        ${(attributes[DBKeys.cmsLikeValue] as FTextTypeInput).toJson()}
        ${attributes[DBKeys.flag] as bool}
        ${(attributes[DBKeys.cmsLikeValue] as FTextTypeInput).getStateValue(state.states)}
        ${(attributes[DBKeys.cmsLikeKey] as FTextTypeInput).getStateValue(state.states)}
        ${(attributes[DBKeys.cmsLimit] as FTextTypeInput).getStateValue(state.states)}
        ${(attributes[DBKeys.cmsPage] as FTextTypeInput).getStateValue(state.states)}
      ''',
      ),
      state: state,
      children: children ?? [],
      collection: attributes[DBKeys.cmsCollection] as FTextTypeInput,
      limit: attributes[DBKeys.cmsLimit] as FTextTypeInput,
      page: attributes[DBKeys.cmsPage] as FTextTypeInput,
      keyName: attributes[DBKeys.cmsLikeKey] as FTextTypeInput,
      keyValue: attributes[DBKeys.cmsLikeValue] as FTextTypeInput,
      showDrafts: attributes[DBKeys.flag] as bool? ?? false,
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
      CmsCountCodeTemplate.toCode(
        context,
        node as NDynamic,
        children ?? <CNode>[],
        loop,
      );
}
