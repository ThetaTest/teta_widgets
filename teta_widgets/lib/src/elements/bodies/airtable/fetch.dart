// Flutter imports:
// ignore_for_file: lines_longer_than_80_chars

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:teta_core/src/models/variable.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/code/templates/airtable/airtable_fetch.dart';

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
import 'package:teta_widgets/src/elements/widgets/airtable/fetch.dart';

const _globalType = NType.airtableFetch;

/// IS
final airtableFetchIntrinsicStates = IntrinsicStates(
  nodeIcon: Assets.icons.left.dataset,
  nodeVideo: null,
  nodeDescription: null,
  advicedChildren: [
    NodeType.name(NType.listViewBuilder),
    NodeType.name(NType.column),
  ],
  blockedTypes: [],
  synonymous: [
    NodeType.name(_globalType),
    'data',
    'spreadsheet',
    'dynamic',
    'collection',
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

/// Body
class AirtableFetchBody extends NodeBody {
  @override
  // ignore: overridden_fields
  Map<String, dynamic> attributes = <String, dynamic>{
    DBKeys.value: FTextTypeInput(),
  };

  @override
  List<ControlModel> get controls => [
        ControlObject(
          title: 'Record Name',
          type: ControlType.value,
          key: DBKeys.value,
          value: attributes[DBKeys.value],
          description: 'Fetch all records with this record name',
          valueType: VariableType.string,
        ),
      ];

  @override
  Widget toWidget({
    required final TetaWidgetState state,
    final CNode? child,
    final List<CNode>? children,
  }) {
    return WAirtableFetch(
      ValueKey(
        '''
        ${state.node.nid}
        ${state.loop}
        ${child ?? children}
        ${(attributes[DBKeys.value] as FTextTypeInput).toJson()}
      ''',
      ),
      state: state,
      children: children ?? [],
      recordName: attributes[DBKeys.value] as FTextTypeInput,
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
      AirtableFetchCodeTemplate.toCode(
        context,
        node as NDynamic,
        children ?? <CNode>[],
        loop,
      );
}
