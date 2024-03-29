// Flutter imports:
// ignore_for_file: lines_longer_than_80_chars

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:teta_models/src/models/variable.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
// Project imports:
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
import 'package:teta_widgets/src/elements/widgets/list_tile.dart';

const _globalType = NType.listTile;

/// Intrinsic State of ListTile
final listTileIntrinsicStates = IntrinsicStates(
  nodeIcon: Assets.wIcons.list,
  nodeVideo: null,
  nodeDescription: null,
  advicedChildren: [],
  blockedTypes: [],
  synonymous: [NodeType.name(NType.cupertinoAppBar), 'navigation', 'navbar'],
  advicedChildrenCanHaveAtLeastAChild: [],
  displayName: NodeType.name(_globalType),
  type: _globalType,
  category: NodeCategories.unclassified,
  maxChildren: 3,
  canHave: ChildrenEnum.children,
  addChildLabels: [
    'Add Leading',
    'Add Trailing',
    'Add Title',
  ],
  gestures: [],
  permissions: [],
  packages: [],
);

/// ListTile's body
class ListTileBody extends NodeBody {
  @override
  // ignore: overridden_fields
  Map<String, dynamic> attributes = <String, dynamic>{
    DBKeys.value: FTextTypeInput(),
    DBKeys.flag: false,
  };

  @override
  List<ControlModel> get controls => [
        ControlObject(
          type: ControlType.value,
          key: DBKeys.value,
          value: attributes[DBKeys.value],
          valueType: VariableType.string,
        ),
        FlagControlObject(
          title: 'ThreeLine',
          key: DBKeys.flag,
          value: attributes[DBKeys.flag],
          description:
              'Whether this list tile is intended to display three lines of text.',
        ),
      ];

  @override
  Widget toWidget({
    required final TetaWidgetState state,
    final CNode? child,
    final List<CNode>? children,
  }) =>
      WListTile(
        ValueKey(
          '''
          ${state.toKey}
          ${child ?? children}
          ${attributes[DBKeys.flag] as bool}
          ${(attributes[DBKeys.value] as FTextTypeInput).toJson()}
          ''',
        ),
        state: state,
        value: attributes[DBKeys.value] as FTextTypeInput,
        isThreeLine: attributes[DBKeys.flag] as bool,
        children: children ?? [],
      );

  //! TO DO
  @override
  Future<String> toCode(
    final BuildContext context,
    final CNode node,
    final CNode? child,
    final List<CNode>? children,
    final int pageId,
    final int? loop,
  );
}
