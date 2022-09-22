// Flutter imports:
// ignore_for_file: lines_longer_than_80_chars

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:teta_core/src/models/dataset.dart';
import 'package:teta_core/src/models/variable.dart';
import 'package:teta_widgets/src/elements/code/templates/cms_stream.dart';
// Project imports:
import 'package:teta_widgets/src/elements/controls/control_model.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/controls/type.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/gestures.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_widgets/src/elements/intrinsic_states/class.dart';
import 'package:teta_widgets/src/elements/nodes/categories.dart';
import 'package:teta_widgets/src/elements/nodes/children_enum.dart';
import 'package:teta_widgets/src/elements/nodes/dynamic.dart';
import 'package:teta_widgets/src/elements/nodes/enum.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';
import 'package:teta_widgets/src/elements/widgets/teta_cms/stream.dart';

const _globalType = NType.cmsStream;

/// IS
final cmsStreamIntrinsicStates = IntrinsicStates(
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
    'stream',
    'feed'
  ],
  advicedChildrenCanHaveAtLeastAChild: [],
  displayName: NodeType.name(_globalType),
  type: _globalType,
  category: NodeCategories.basic,
  maxChildren: 2,
  canHave: ChildrenEnum.children,
  addChildLabels: [
    'Add new if successful',
    'Add new if empty or failed',
  ],
  gestures: [
    ActionGesture.onStreamNewValue,
  ],
  permissions: [],
  packages: [],
);

/// Body
class CmsStreamBody extends NodeBody {
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
        ),
        ControlObject(
          title: 'Limit',
          type: ControlType.value,
          key: DBKeys.cmsLimit,
          value: attributes[DBKeys.cmsLimit],
          description: 'Limit the number of docs per page',
        ),
        ControlObject(
          title: 'Page',
          type: ControlType.value,
          key: DBKeys.cmsPage,
          value: attributes[DBKeys.cmsPage],
          description: 'Index of page',
        ),
        ControlObject(
          title: 'Like: key',
          type: ControlType.value,
          key: DBKeys.cmsLikeKey,
          value: attributes[DBKeys.cmsLikeKey],
          description: 'Like op: the key name used to filter',
        ),
        ControlObject(
          title: 'Like: value',
          type: ControlType.value,
          key: DBKeys.cmsLikeValue,
          value: attributes[DBKeys.cmsLikeValue],
          description: 'Like op: the value to search in db',
        ),
        FlagControlObject(
          title: 'Show drafts',
          key: DBKeys.flag,
          value: attributes[DBKeys.flag],
          description:
              'Show doc drafts. Valid only in editor, not in production',
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
  }) {
    return WCmsStream(
      ValueKey(
        '''
        ${node.nid}
        $loop
        ${child ?? children}
        ${(attributes[DBKeys.cmsCollection] as FTextTypeInput).toJson()}
        ${(attributes[DBKeys.cmsLimit] as FTextTypeInput).toJson()}
        ${(attributes[DBKeys.cmsPage] as FTextTypeInput).toJson()}
        ${(attributes[DBKeys.cmsLikeKey] as FTextTypeInput).toJson()}
        ${(attributes[DBKeys.cmsLikeValue] as FTextTypeInput).toJson()}
        ${attributes[DBKeys.flag] as bool}
        ${(attributes[DBKeys.cmsLikeValue] as FTextTypeInput).getStateValue(states)}
        ${(attributes[DBKeys.cmsLikeKey] as FTextTypeInput).getStateValue(states)}
        ${(attributes[DBKeys.cmsLimit] as FTextTypeInput).getStateValue(states)}
        ${(attributes[DBKeys.cmsPage] as FTextTypeInput).getStateValue(states)}
      ''',
      ),
      node: node,
      children: children ?? [],
      collection: attributes[DBKeys.cmsCollection] as FTextTypeInput,
      limit: attributes[DBKeys.cmsLimit] as FTextTypeInput,
      page: attributes[DBKeys.cmsPage] as FTextTypeInput,
      keyName: attributes[DBKeys.cmsLikeKey] as FTextTypeInput,
      keyValue: attributes[DBKeys.cmsLikeValue] as FTextTypeInput,
      showDrafts: attributes[DBKeys.flag] as bool? ?? false,
      forPlay: forPlay,
      params: params,
      states: states,
      dataset: dataset,
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
      CmsStreamCodeTemplate.toCode(
        context,
        node as NDynamic,
        children ?? <CNode>[],
        loop,
        pageId,
      );
}
