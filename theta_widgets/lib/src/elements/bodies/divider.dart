// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:theta_widgets/src/core/teta_widget/index.dart';
import 'package:theta_widgets/src/elements/code/snippets.dart';
// Project imports:
import 'package:theta_widgets/src/elements/code/templates/divider.dart';
import 'package:theta_widgets/src/elements/controls/control_model.dart';
import 'package:theta_widgets/src/elements/controls/key_constants.dart';
import 'package:theta_widgets/src/elements/controls/type.dart';
import 'package:theta_widgets/src/elements/features/fill.dart';
import 'package:theta_widgets/src/elements/features/sizes.dart';
import 'package:theta_widgets/src/elements/intrinsic_states/class.dart';
import 'package:theta_widgets/src/elements/nodes/categories.dart';
import 'package:theta_widgets/src/elements/nodes/children_enum.dart';
import 'package:theta_widgets/src/elements/nodes/enum.dart';
import 'package:theta_widgets/src/elements/nodes/node.dart';
import 'package:theta_widgets/src/elements/nodes/node_body.dart';
import 'package:theta_widgets/src/elements/nodes/suggestion.dart';
import 'package:theta_widgets/src/elements/widgets/divider.dart';

const _globalType = NType.divider;

/// Instrict State of Divider
final dividerIntrinsicStates = IntrinsicStates(
  nodeIcon: Assets.wIcons.divider,
  nodeVideo: null,
  nodeDescription: null,
  advicedChildren: [
    NodeType.name(NType.container),
    NodeType.name(NType.column),
    NodeType.name(NType.row),
  ],
  blockedTypes: [],
  synonymous: ['divider', 'separator', 'div'],
  advicedChildrenCanHaveAtLeastAChild: [],
  displayName: NodeType.name(_globalType),
  type: _globalType,
  category: NodeCategories.basic,
  maxChildren: 0,
  canHave: ChildrenEnum.none,
  addChildLabels: [],
  gestures: [],
  permissions: [],
  packages: [],
  suggestionsTitle: 'Why use Divider in Teta?',
  suggestions: [
    const Suggestion(
      title: 'Why use Divider in Teta?',
      description: 'Test',
      linkToOpen: 'https://docs.teta.so/teta-docs/widget/basic-widgets/divider',
    )
  ],
);

/// Divider's body
class DividerBody extends NodeBody {
  @override
  // ignore: overridden_fields
  Map<String, dynamic> attributes = <String, dynamic>{
    DBKeys.height: FSize(
      size: '1.0',
      sizeTablet: '1.0',
      sizeDesktop: '1.0',
      unit: SizeUnit.pixel,
      unitTablet: SizeUnit.pixel,
      unitDesktop: SizeUnit.pixel,
    ),
    DBKeys.fill: FFill(),
  };

  @override
  List<ControlModel> get controls => [
        SizeControlObject(
          title: 'Height',
          type: ControlType.size,
          key: DBKeys.height,
          value: attributes[DBKeys.height] as FSize,
          isWidth: false,
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
      WDivider(
        ValueKey(
          '''
          ${state.toKey}
          ${child ?? children}
          ${(attributes[DBKeys.height] as FSize).toJson()}
          ${(attributes[DBKeys.fill] as FFill).toJson()}
          ''',
        ),
        state: state,
        child: child,
        height: attributes[DBKeys.height] as FSize,
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
        DividerCodeTemplate.toCode(context, this, child),
        loop ?? 0,
      );
}
