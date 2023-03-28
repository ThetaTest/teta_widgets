// Flutter imports:
// ignore_for_file: lines_longer_than_80_chars, avoid_dynamic_calls

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
import 'package:theta_widgets/src/core/teta_widget/index.dart';
import 'package:theta_widgets/src/elements/code/templates/apiCallsFetch.dart';
import 'package:theta_widgets/src/elements/controls/control_model.dart';
import 'package:theta_widgets/src/elements/controls/key_constants.dart';
import 'package:theta_widgets/src/elements/controls/type.dart';
import 'package:theta_widgets/src/elements/features/text_type_input.dart';
import 'package:theta_widgets/src/elements/intrinsic_states/class.dart';
import '../../../../../../../teta_open_classes/lib/src/nodes/categories.dart';
import '../../../../../../../teta_open_classes/lib/src/nodes/children_enum.dart';
import '../../../../../../../teta_open_classes/lib/src/nodes/dynamic.dart';
// Project imports:
import '../../../../../../../teta_open_classes/lib/src/nodes/enum.dart';
import '../../../../../../../teta_open_classes/lib/src/nodes/node.dart';
import '../../../../../../../teta_open_classes/lib/src/nodes/node_body.dart';
import 'package:theta_widgets/src/elements/widgets/apicalls/api_calls_fetch.dart';
import 'package:theta_models/theta_models.dart';

const _globalType = NType.apiCallsFetch;

final apiCallsFetchIntrinsicStates = IntrinsicStates(
  nodeIcon: Assets.icons.left.api,
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
    'api',
    'calls',
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
  addChildLabels: [
    'Add new if successful',
    'Add new if empty or failed',
  ],
  gestures: [],
  permissions: [],
  packages: [],
);

class ApiCallsFetchBody extends NodeBody {
  @override
  // ignore: overridden_fields
  Map<String, dynamic> attributes = <String, dynamic>{
    DBKeys.requestName: '',
    DBKeys.apiCallsResponseName: FTextTypeInput(),
    DBKeys.apiCallsDynamicValue: <MapElement>[],
    DBKeys.apiCallsSelectedRequest: <String, dynamic>{},
  };

  @override
  List<ControlModel> get controls => [
        ControlObject(
          type: ControlType.apiCallsRequestControl,
          key: DBKeys.requestName,
          value: attributes[DBKeys.requestName],
          valueType: VariableType.string,
        ),
        ControlObject(
          ignoreDeviceTypeValue: true,
          title: 'Response Name',
          type: ControlType.value,
          key: DBKeys.apiCallsResponseName,
          value: attributes[DBKeys.apiCallsResponseName],
          valueType: VariableType.string,
        ),
        ControlObject(
          ignoreDeviceTypeValue: true,
          title: 'Add Dynamic Value',
          type: ControlType.httpParamsControl,
          key: DBKeys.apiCallsDynamicValue,
          value: attributes[DBKeys.apiCallsDynamicValue] ?? <MapElement>[],
          valueType: VariableType.dynamic,
        ),
      ];

  @override
  Widget toWidget({
    required final TetaWidgetState state,
    final CNode? child,
    final List<CNode>? children,
  }) {
    return WApiCallsFetch(
      ValueKey(
        '''
        ${state.toKey}
        ${child ?? children}
        ${attributes[DBKeys.requestName] as String}
        ${(attributes[DBKeys.apiCallsResponseName] as FTextTypeInput).toJson()}
        ${(attributes[DBKeys.apiCallsResponseName] as FTextTypeInput).getStateValue(state.states)}
        ${attributes[DBKeys.apiCallsDynamicValue]}
        ${attributes[DBKeys.apiCallsSelectedRequest] as Map}
        ''',
      ),
      state: state,
      children: children ?? [],
      requestName: attributes[DBKeys.requestName] as String,
      apiCallsResponseName:
          attributes[DBKeys.apiCallsResponseName] as FTextTypeInput,
      apiCallsDynamicValue:
          attributes[DBKeys.apiCallsDynamicValue] as List<MapElement>,
      apiCallsSelectedRequest:
          attributes[DBKeys.apiCallsSelectedRequest] as Map<String, dynamic>,
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
      ApiCallsFetchCodeTemplate.toCode(
        context,
        node as NDynamic,
        children ?? <CNode>[],
        loop,
      );
}
