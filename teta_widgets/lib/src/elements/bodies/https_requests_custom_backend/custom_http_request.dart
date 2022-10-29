// Flutter imports:
// ignore_for_file: lines_longer_than_80_chars

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:teta_core/teta_core.dart';

// Project imports:
import 'package:teta_widgets/src/elements/nodes/enum.dart';
import 'package:teta_widgets/src/elements/intrinsic_states/class.dart';
import 'package:teta_widgets/src/elements/nodes/categories.dart';
import 'package:teta_widgets/src/elements/nodes/children_enum.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';
import 'package:teta_widgets/src/elements/controls/control_model.dart';
import 'package:teta_widgets/src/elements/controls/type.dart';
import 'package:teta_widgets/src/elements/widgets/https_requests_custom_backend/custom_http_request.dart';
import 'package:teta_widgets/src/elements/code/templates/custom_http_request.dart';
import 'package:teta_widgets/src/elements/nodes/dynamic.dart';

const _globalType = NType.customHttpRequest;

final customHttpRequestIntrinsicStates = IntrinsicStates(
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
    'http',
    'request',
    'cms',
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
  addChildLabels: [
    'Add new if successful',
    'Add new if empty or failed',
  ],
  gestures: [],
  permissions: [],
  packages: [],
);

class CustomHttpRequestBody extends NodeBody {
  @override
  // ignore: overridden_fields
  Map<String, dynamic> attributes = <String, dynamic>{
    DBKeys.customHttpRequestURL: FTextTypeInput(),
  };

  @override
  List<ControlModel> get controls => [
        ControlObject(
          title: 'URL',
          type: ControlType.value,
          key: DBKeys.customHttpRequestURL,
          value: attributes[DBKeys.customHttpRequestURL],
          description: 'Fetch all data with custom URL',
          valueType: VariableType.string,
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
    return WCustomHttpRequest(
      ValueKey(
        '''
        ${node.nid}
        $loop
        ${child ?? children}
        ${(attributes[DBKeys.customHttpRequestURL] as FTextTypeInput).toJson()}
        ${(attributes[DBKeys.customHttpRequestURL] as FTextTypeInput).getStateValue(states)}
      ''',
      ),
      node: node,
      children: children ?? [],
      url: attributes[DBKeys.customHttpRequestURL] as FTextTypeInput,
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
      CustomHttpRequestCodeTemplate.toCode(
        context,
        node as NDynamic,
        children ?? <CNode>[],
        loop,
      );
}
