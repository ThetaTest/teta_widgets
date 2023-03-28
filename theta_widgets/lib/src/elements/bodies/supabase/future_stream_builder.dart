// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:theta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:theta_widgets/src/elements/code/templates/stream_builder.dart';
import 'package:theta_widgets/src/elements/controls/control_model.dart';
import 'package:theta_widgets/src/elements/controls/key_constants.dart';
import 'package:theta_widgets/src/elements/controls/type.dart';
import 'package:theta_widgets/src/elements/features/text_type_input.dart';
import 'package:theta_widgets/src/elements/intrinsic_states/class.dart';
import '../../../../../../../teta_open_classes/lib/src/nodes/categories.dart';
import '../../../../../../../teta_open_classes/lib/src/nodes/children_enum.dart';
import '../../../../../../../teta_open_classes/lib/src/nodes/enum.dart';
import '../../../../../../../teta_open_classes/lib/src/nodes/node.dart';
import '../../../../../../../teta_open_classes/lib/src/nodes/node_body.dart';
import 'package:theta_widgets/src/elements/widgets/supabase/supabase_stream_builder.dart';
import 'package:theta_models/theta_models.dart';

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
  category: NodeCategories.dynamicCollection,
  maxChildren: 2,
  canHave: ChildrenEnum.children,
  addChildLabels: [],
  gestures: [],
  permissions: [],
  packages: [],
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
          valueType: VariableType.string,
        ),
        ControlObject(
          title: 'From Range',
          type: ControlType.value,
          key: DBKeys.supabaseFromRange,
          value: attributes[DBKeys.supabaseFromRange],
          valueType: VariableType.int,
        ),
        ControlObject(
          title: 'Order',
          type: ControlType.value,
          key: DBKeys.supabaseOrder,
          value: attributes[DBKeys.supabaseOrder],
          valueType: VariableType.string,
        ),
      ];

  @override
  Widget toWidget({
    required final TetaWidgetState state,
    final CNode? child,
    final List<CNode>? children,
  }) {
    final str = StringBuffer()
      ..write(
        '''
        ${state.toKey}
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
      state: state,
      children: children ?? [],
      from: attributes[DBKeys.supabaseFrom] as FTextTypeInput,
      order: attributes[DBKeys.supabaseOrder] as FTextTypeInput,
      fromRange: attributes[DBKeys.supabaseFromRange] as FTextTypeInput,
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
      StreamBuilderCodeTemplate.toCode(context, this, children ?? [], loop);
}
