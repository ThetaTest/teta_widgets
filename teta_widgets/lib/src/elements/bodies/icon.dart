// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:teta_core/src/models/variable.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
import 'package:teta_widgets/src/elements/code/snippets.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/templates/icon.dart';
import 'package:teta_widgets/src/elements/controls/control_model.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/controls/type.dart';
import 'package:teta_widgets/src/elements/features/fill.dart';
import 'package:teta_widgets/src/elements/features/sizes.dart';
import 'package:teta_widgets/src/elements/intrinsic_states/class.dart';
import 'package:teta_widgets/src/elements/nodes/categories.dart';
import 'package:teta_widgets/src/elements/nodes/children_enum.dart';
import 'package:teta_widgets/src/elements/nodes/enum.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';
import 'package:teta_widgets/src/elements/nodes/suggestion.dart';
import 'package:teta_widgets/src/elements/widgets/icon.dart';

const _globalType = NType.icon;

/// Intrinsic States of Icon
final iconIntrinsicStates = IntrinsicStates(
  nodeIcon: Assets.wIcons.icon,
  nodeVideo: '',
  nodeDescription: null,
  advicedChildren: [
    NodeType.name(NType.container),
    NodeType.name(NType.column),
    NodeType.name(NType.image),
  ],
  blockedTypes: [],
  synonymous: ['icon', 'menu'],
  advicedChildrenCanHaveAtLeastAChild: [],
  displayName: 'Material Icon',
  type: _globalType,
  category: NodeCategories.advanced,
  maxChildren: 0,
  canHave: ChildrenEnum.none,
  addChildLabels: [],
  gestures: [],
  permissions: [],
  packages: [],
  suggestionsTitle: 'Why use Material Icon in Teta?',
  suggestions: [
    const Suggestion(
      title: 'Why use Material Icon in Teta?',
      description: 'Test',
      linkToOpen:
          'https://docs.teta.so/teta-docs/widget/icon-widgets/material-icon',
    )
  ],
);

/// Icon's body
class IconBody extends NodeBody {
  @override
  // ignore: overridden_fields
  Map<String, dynamic> attributes = <String, dynamic>{
    DBKeys.icon: 'plus',
    DBKeys.width: FSize(size: '24', unit: SizeUnit.pixel),
    DBKeys.fill: FFill(),
  };

  @override
  List<ControlModel> get controls => [
        ControlObject(
          type: ControlType.icon,
          key: DBKeys.icon,
          value: attributes[DBKeys.icon],
          valueType: VariableType.string,
        ),
        SizeControlObject(
          type: ControlType.size,
          key: DBKeys.width,
          title: 'Size',
          isWidth: true,
          value: attributes[DBKeys.width] as FSize,
        ),
        FillControlObject(
          title: '',
          key: DBKeys.fill,
          value: attributes[DBKeys.fill] as FFill,
          isImageEnabled: false,
          isNoneEnabled: false,
          isOnlySolid: true,
          isStyled: false,
        ),
      ];

  @override
  Widget toWidget({
    required final TetaWidgetState state,
    final CNode? child,
    final List<CNode>? children,
  }) =>
      WIcon(
        ValueKey(
          '''
      ${state.toKey}
      ${child ?? children}
      ${(attributes[DBKeys.width] as FSize).toJson()}
      ${attributes[DBKeys.icon]}
      ${(attributes[DBKeys.fill] as FFill).toJson()}
      ''',
        ),
        state: state,
        width: attributes[DBKeys.width] as FSize,
        icon: attributes[DBKeys.icon] as String? ?? 'plus',
        fill: attributes[DBKeys.fill] as FFill,
      );

  @override
  Future<String> toCode(
    final BuildContext context,
    final CNode node,
    final CNode? child,
    final List<CNode>? children,
    final int pageId,
    final int? loop,
  ) =>
      CS.defaultWidgets(
        context,
        node,
        pageId,
        IconCodeTemplate.toCode(context, this, node, child, loop),
        loop ?? 0,
      );
}
