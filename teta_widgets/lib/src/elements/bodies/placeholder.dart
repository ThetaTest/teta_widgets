// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:teta_core/src/models/dataset.dart';
import 'package:teta_core/src/models/variable.dart';

// Project imports:
import 'package:teta_widgets/src/elements/code/templates/placeholder.dart';
import 'package:teta_widgets/src/elements/controls/control_model.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/controls/type.dart';
import 'package:teta_widgets/src/elements/features/fill.dart';
import 'package:teta_widgets/src/elements/features/sizes.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_widgets/src/elements/intrinsic_states/class.dart';
import 'package:teta_widgets/src/elements/nodes/categories.dart';
import 'package:teta_widgets/src/elements/nodes/children_enum.dart';
import 'package:teta_widgets/src/elements/nodes/enum.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';
import 'package:teta_widgets/src/elements/widgets/placeholder.dart';

const _globalType = NType.placeholder;

/// Intrinsic States of Center node type
final placeholderIntrinsicStates = IntrinsicStates(
  nodeIcon: Assets.wIcons.placeholder,
  nodeVideo: null,
  nodeDescription: 'A widget that centers its child within itself.',
  advicedChildren: [
    NodeType.name(NType.column),
    NodeType.name(NType.row),
    NodeType.name(NType.image),
  ],
  blockedTypes: [],
  synonymous: ['placeholder', 'text'],
  advicedChildrenCanHaveAtLeastAChild: [],
  displayName: NodeType.name(_globalType),
  type: _globalType,
  category: NodeCategories.advanced,
  maxChildren: 1,
  canHave: ChildrenEnum.child,
  addChildLabels: [],
  gestures: [],
);

/// Set of funcs of Center node
class PlaceholderBody extends NodeBody {
  @override
  // ignore: overridden_fields
  Map<String, dynamic> attributes = <String, dynamic>{
    DBKeys.fill: FFill(),
    DBKeys.value: FTextTypeInput(),
    DBKeys.width: FSize(size: '400', unit: SizeUnit.pixel),
    DBKeys.height: FSize(size: '400', unit: SizeUnit.pixel),
  };

  @override
  List<ControlModel> get controls => [
        FillControlObject(
          title: '',
          key: DBKeys.fill,
          value: attributes[DBKeys.fill] as FFill,
          isImageEnabled: false,
          isNoneEnabled: true,
          isOnlySolid: false,
          isStyled: false,
        ),
        ControlObject(
          title: 'Stroke',
          type: ControlType.value,
          key: DBKeys.value,
          value: attributes[DBKeys.value],
        ),
        SizesControlObject(
          keys: const [DBKeys.width, DBKeys.height],
          values: <FSize>[
            attributes[DBKeys.width] as FSize,
            attributes[DBKeys.height] as FSize,
          ],
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
  }) =>
      WPlaceholder(
        ValueKey(
          '''
            ${node.nid}
            $loop
            ${child ?? children}
            ${(attributes[DBKeys.fill] as FFill).toJson()}, 
            ${(attributes[DBKeys.value] as FTextTypeInput).toJson()}, 
            ${(attributes[DBKeys.width] as FSize).toJson()}, 
            ${(attributes[DBKeys.height] as FSize).toJson()}, 
            ''',
        ),
        color: attributes[DBKeys.fill] as FFill,
        value: attributes[DBKeys.value] as FTextTypeInput,
        width: attributes[DBKeys.width] as FSize,
        height: attributes[DBKeys.height] as FSize,
        node: node,
        child: child,
        loop: loop,
        forPlay: forPlay,
        params: params,
        states: states,
        dataset: dataset,
      );

  @override
  String toCode(
    BuildContext context,
    CNode node,
    CNode? child,
    List<CNode>? children,
    int pageId,
    int? loop,
  ) =>
      placeholderCodeTemplate(context, this, child, loop);
}
