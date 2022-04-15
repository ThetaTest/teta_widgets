// Flutter imports:
// ignore_for_file: lines_longer_than_80_chars

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:teta_core/src/models/dataset.dart';
import 'package:teta_core/src/models/variable.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/templates/future_builder.dart';
import 'package:teta_widgets/src/elements/controls/control_model.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/controls/type.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_widgets/src/elements/intrinsic_states/class.dart';
import 'package:teta_widgets/src/elements/nodes/categories.dart';
import 'package:teta_widgets/src/elements/nodes/children_enum.dart';
import 'package:teta_widgets/src/elements/nodes/enum.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';
import 'package:teta_widgets/src/elements/widgets/supabase/future_builder.dart';

const _globalType = NType.cmsFetch;

/// IS
final cms_FetchIntrinsicStates = IntrinsicStates(
  nodeIcon: Assets.wIcons.supabaseLogoIcon,
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
  category: NodeCategories.basic,
  maxChildren: 2,
  canHave: ChildrenEnum.children,
  addChildLabels: [],
  gestures: [],
  permissions: [],
);

/// Body
class SupabaseFutureBuilderBody extends NodeBody {
  @override
  // ignore: overridden_fields
  Map<String, dynamic> attributes = <String, dynamic>{
    DBKeys.supabaseFrom: FTextTypeInput(value: 'users'),
    DBKeys.supabaseSelect: FTextTypeInput(value: 'id, name'),
    DBKeys.supabaseToRange: FTextTypeInput(value: '15'),
    DBKeys.supabaseFromRange: FTextTypeInput(value: '0'),
    DBKeys.supabaseNumberPage: FTextTypeInput(value: '1'),
    DBKeys.supabaseOrder: FTextTypeInput(value: 'name'),
    DBKeys.supabaseSearchName: FTextTypeInput(),
    DBKeys.supabaseSearchValue: FTextTypeInput(),
    DBKeys.supabaseEqName: FTextTypeInput(),
    DBKeys.supabaseEqValue: FTextTypeInput(),
  };

  @override
  List<ControlModel> get controls => [
        ControlObject(
          title: 'From',
          type: ControlType.value,
          key: DBKeys.supabaseFrom,
          value: attributes[DBKeys.supabaseFrom],
        ),
        ControlObject(
          title: 'Select',
          type: ControlType.value,
          key: DBKeys.supabaseSelect,
          value: attributes[DBKeys.supabaseSelect],
        ),
        ControlObject(
          title: 'To Range',
          type: ControlType.value,
          key: DBKeys.supabaseToRange,
          value: attributes[DBKeys.supabaseToRange],
        ),
        ControlObject(
          title: 'From Range',
          type: ControlType.value,
          key: DBKeys.supabaseFromRange,
          value: attributes[DBKeys.supabaseFromRange],
        ),
        ControlObject(
          title: 'Number Page',
          type: ControlType.value,
          key: DBKeys.supabaseNumberPage,
          value: attributes[DBKeys.supabaseNumberPage],
        ),
        ControlObject(
          title: 'Order',
          type: ControlType.value,
          key: DBKeys.supabaseOrder,
          value: attributes[DBKeys.supabaseOrder],
        ),
        ControlObject(
          title: 'Search Column',
          type: ControlType.value,
          key: DBKeys.supabaseSearchName,
          value: attributes[DBKeys.supabaseSearchName],
        ),
        ControlObject(
          title: 'Search Value',
          type: ControlType.value,
          key: DBKeys.supabaseSearchValue,
          value: attributes[DBKeys.supabaseSearchValue],
        ),
        ControlObject(
          title: 'Equaliser Name',
          type: ControlType.value,
          key: DBKeys.supabaseEqName,
          value: attributes[DBKeys.supabaseEqName],
        ),
        ControlObject(
          title: 'Equaliser Value',
          type: ControlType.value,
          key: DBKeys.supabaseEqValue,
          value: attributes[DBKeys.supabaseEqValue],
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
    return WSupabaseFutureBuilder(
      ValueKey(
        '''
        ${node.nid}
        $loop
        ${child ?? children}
        ${(attributes[DBKeys.supabaseFrom] as FTextTypeInput).get(params, states, dataset, forPlay, loop)}
        ${(attributes[DBKeys.supabaseSelect] as FTextTypeInput).get(params, states, dataset, forPlay, loop)}
        ${(attributes[DBKeys.supabaseOrder] as FTextTypeInput).get(params, states, dataset, forPlay, loop)}
        ${(attributes[DBKeys.supabaseFromRange] as FTextTypeInput).get(params, states, dataset, forPlay, loop)}
        ${(attributes[DBKeys.supabaseToRange] as FTextTypeInput).get(params, states, dataset, forPlay, loop)}
        ${(attributes[DBKeys.supabaseNumberPage] as FTextTypeInput).get(params, states, dataset, forPlay, loop)}
        ${(attributes[DBKeys.supabaseSearchName] as FTextTypeInput).get(params, states, dataset, forPlay, loop)}
        ${(attributes[DBKeys.supabaseSearchValue] as FTextTypeInput).get(params, states, dataset, forPlay, loop)}
        ${(attributes[DBKeys.supabaseEqName] as FTextTypeInput).get(params, states, dataset, forPlay, loop)}
        ${(attributes[DBKeys.supabaseEqValue] as FTextTypeInput).get(params, states, dataset, forPlay, loop)}
      ''',
      ),
      node: node,
      children: children ?? [],
      from: attributes[DBKeys.supabaseFrom] as FTextTypeInput,
      select: attributes[DBKeys.supabaseSelect] as FTextTypeInput,
      order: attributes[DBKeys.supabaseOrder] as FTextTypeInput,
      fromRange: attributes[DBKeys.supabaseFromRange] as FTextTypeInput,
      toRange: attributes[DBKeys.supabaseToRange] as FTextTypeInput,
      numberPage: attributes[DBKeys.supabaseNumberPage] as FTextTypeInput,
      searchName: attributes[DBKeys.supabaseSearchName] as FTextTypeInput,
      searchValue: attributes[DBKeys.supabaseSearchValue] as FTextTypeInput,
      eqName: attributes[DBKeys.supabaseEqName] as FTextTypeInput,
      eqValue: attributes[DBKeys.supabaseEqValue] as FTextTypeInput,
      forPlay: forPlay,
      params: params,
      states: states,
      dataset: dataset,
    );
  }

  @override
  String toCode(
    final BuildContext context,
    final CNode node,
    final CNode? child,
    final List<CNode>? children,
    final int pageId,
    final int? loop,
  ) =>
      supabaseFutureBuilderCodeTemplate(context, this, children ?? [], loop);
}
