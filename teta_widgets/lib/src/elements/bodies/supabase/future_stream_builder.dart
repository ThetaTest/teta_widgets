// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:teta_core/src/models/dataset.dart';
import 'package:teta_core/src/models/variable.dart';

// Project imports:
import 'package:teta_widgets/src/elements/code/templates/stream_builder.dart';
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
import 'package:teta_widgets/src/elements/widgets/supabase/supabase_stream_builder.dart';

const _globalType = NType.supabaseStreamBuilder;

/// IS
final supabaseStreamBuilderIntrinsicStates = IntrinsicStates(
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
    'firestore',
    'firebase',
    'future builder',
    'stream builder',
  ],
  advicedChildrenCanHaveAtLeastAChild: [],
  displayName: NodeType.name(_globalType),
  type: _globalType,
  category: NodeCategories.supabase,
  maxChildren: 2,
  canHave: ChildrenEnum.children,
  addChildLabels: [],
  gestures: [],
);

/// Body
class SupabaseStreamBuilderBody extends NodeBody {
  @override
  // ignore: overridden_fields
  Map<String, dynamic> attributes = <String, dynamic>{
    DBKeys.supabaseFrom: FTextTypeInput(value: 'users'),
    DBKeys.supabaseFromRange: FTextTypeInput(value: '0'),
    DBKeys.supabaseOrder: FTextTypeInput(value: 'name'),
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
          title: 'From Range',
          type: ControlType.value,
          key: DBKeys.supabaseFromRange,
          value: attributes[DBKeys.supabaseFromRange],
        ),
        ControlObject(
          title: 'Order',
          type: ControlType.value,
          key: DBKeys.supabaseOrder,
          value: attributes[DBKeys.supabaseOrder],
        ),
      ];

  @override
  Widget toWidget({
    required List<VariableObject> params,
    required List<VariableObject> states,
    required List<DatasetObject> dataset,
    required bool forPlay,
    required CNode node,
    int? loop,
    CNode? child,
    List<CNode>? children,
  }) {
    final str = StringBuffer()
      ..write(
        '''
        ${node.nid}
        $loop
        ${child ?? children}
      ''',
      )
      ..write('${(attributes[DBKeys.supabaseFrom] as FTextTypeInput).value}')
      ..write('${(attributes[DBKeys.supabaseOrder] as FTextTypeInput).value}')
      ..write(
        '${(attributes[DBKeys.supabaseFromRange] as FTextTypeInput).value}',
      );
    return WSupabaseStreamBuilder(
      ValueKey(str.toString()),
      node: node,
      children: children ?? [],
      from: attributes[DBKeys.supabaseFrom] as FTextTypeInput,
      order: attributes[DBKeys.supabaseOrder] as FTextTypeInput,
      fromRange: attributes[DBKeys.supabaseFromRange] as FTextTypeInput,
      forPlay: forPlay,
      params: params,
      states: states,
      dataset: dataset,
    );
  }

  @override
  String toCode(
    BuildContext context,
    CNode node,
    CNode? child,
    List<CNode>? children,
    int pageId,
    int? loop,
  ) =>
      streamBuilderCodeTemplate(context, this, children ?? [], loop);
}
