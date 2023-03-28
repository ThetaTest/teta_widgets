// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:theta_models/src/models/variable.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/code/templates/icon_feather.dart';
// Project imports:
import 'package:teta_widgets/src/elements/controls/control_model.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/controls/type.dart';
import 'package:teta_widgets/src/elements/features/fill.dart';
import 'package:teta_widgets/src/elements/features/sizes.dart';
import 'package:teta_widgets/src/elements/intrinsic_states/class.dart';
import '../../../../../../teta_open_classes/lib/src/nodes/categories.dart';
import '../../../../../../teta_open_classes/lib/src/nodes/children_enum.dart';
import '../../../../../../teta_open_classes/lib/src/nodes/enum.dart';
import '../../../../../../teta_open_classes/lib/src/nodes/node.dart';
import '../../../../../../teta_open_classes/lib/src/nodes/node_body.dart';
import '../../../../../../teta_open_classes/lib/src/nodes/suggestion.dart';
import 'package:teta_widgets/src/elements/packages.dart';
import 'package:teta_widgets/src/elements/widgets/icon_feather.dart';

const _globalType = NType.featherIcon;

/// Intrinsic States of featherIcon node
final featherIconIntrinsicStates = IntrinsicStates(
  nodeIcon: Assets.wIcons.icon,
  nodeVideo: '',
  nodeDescription: null,
  advicedChildren: [
    NodeType.name(NType.container),
    NodeType.name(NType.column),
    NodeType.name(NType.image),
  ],
  blockedTypes: [],
  synonymous: ['feather', 'icon', 'font'],
  advicedChildrenCanHaveAtLeastAChild: [],
  displayName: 'Feather Icon',
  type: _globalType,
  category: NodeCategories.basic,
  maxChildren: 0,
  canHave: ChildrenEnum.none,
  addChildLabels: [],
  gestures: [],
  permissions: [],
  packages: [pFeatherIcons],
  suggestionsTitle: 'Why use Feather Icon in Teta?',
  suggestions: [
    const Suggestion(
      title: 'Why use Feather Icon in Teta?',
      description: 'Test',
      linkToOpen:
          'https://docs.teta.so/teta-docs/widget/icon-widgets/feather-icon',
    )
  ],
);

/// Feather Icon's body
class FeatherIconBody extends NodeBody {
  @override
  // ignore: overridden_fields
  Map<String, dynamic> attributes = <String, dynamic>{
    DBKeys.featherIcon: 'plus',
    DBKeys.width: FSize(size: '24', unit: SizeUnit.pixel),
    DBKeys.fill: FFill(),
  };

  @override
  List<ControlModel> get controls => [
        ControlObject(
          type: ControlType.featherIcon,
          key: DBKeys.featherIcon,
          value: attributes[DBKeys.featherIcon],
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
      WFeatherIcon(
        ValueKey(
          '''
          ${state.toKey}
          ${(attributes[DBKeys.width] as FSize).toJson()}
          ${attributes[DBKeys.featherIcon]}
          ${(attributes[DBKeys.fill] as FFill).toJson()}
          ''',
        ),
        state: state,
        width: attributes[DBKeys.width] as FSize,
        icon: attributes[DBKeys.featherIcon] as String? ?? 'plus',
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
        IconFeatherCodeTemplate.toCode(context, this, node, child, loop),
        loop ?? 0,
      );
}
