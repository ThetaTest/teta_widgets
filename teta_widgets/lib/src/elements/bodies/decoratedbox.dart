// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:teta_core/src/models/variable.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
import 'package:teta_widgets/src/elements/code/snippets.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/templates/decoratedbox.dart';
import 'package:teta_widgets/src/elements/controls/control_model.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/controls/type.dart';
import 'package:teta_widgets/src/elements/features/border_radius.dart';
import 'package:teta_widgets/src/elements/features/fill.dart';
import 'package:teta_widgets/src/elements/features/shadow.dart';
import 'package:teta_widgets/src/elements/intrinsic_states/class.dart';
import 'package:teta_widgets/src/elements/nodes/categories.dart';
import 'package:teta_widgets/src/elements/nodes/children_enum.dart';
import 'package:teta_widgets/src/elements/nodes/enum.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';
import 'package:teta_widgets/src/elements/nodes/suggestion.dart';
import 'package:teta_widgets/src/elements/widgets/decoratedbox.dart';

const _globalType = NType.decoratedBox;

/// Instrict State of DecoratedBox
final decoratedBoxIntrinsicStates = IntrinsicStates(
  nodeIcon: Assets.wIcons.decoratedBox,
  nodeVideo: null,
  nodeDescription: null,
  advicedChildren: [
    NodeType.name(NType.text),
    NodeType.name(NType.image),
    NodeType.name(NType.gestureDetector),
  ],
  blockedTypes: [],
  synonymous: ['decoratedbox', 'container', 'square', 'div'],
  advicedChildrenCanHaveAtLeastAChild: [],
  displayName: NodeType.name(_globalType),
  type: _globalType,
  category: NodeCategories.advanced,
  maxChildren: 1,
  canHave: ChildrenEnum.child,
  addChildLabels: [],
  gestures: [],
  permissions: [],
  packages: [],
  suggestionsTitle: 'Why use Decorated Box in Teta?',
  suggestions: [
    const Suggestion(
      title: 'Why use Decorated Box in Teta?',
      description: 'Test',
      linkToOpen:
          'https://docs.teta.so/teta-docs/widget/advanced-widgets/decorated-box',
    )
  ],
);

/// Set of funcs to use DecoratedBox widget
class DecoratedBoxBody extends NodeBody {
  @override
  // ignore: overridden_fields
  Map<String, dynamic> attributes = <String, dynamic>{
    DBKeys.borderRadius: FBorderRadius(),
    DBKeys.shadows: FShadow(),
    DBKeys.fill: FFill(),
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
          type: ControlType.borderRadius,
          key: DBKeys.borderRadius,
          value: attributes[DBKeys.borderRadius],
          valueType: VariableType.double,
        ),
        ControlObject(
          type: ControlType.shadows,
          key: DBKeys.shadows,
          value: attributes[DBKeys.shadows],
          valueType: VariableType.string,
        ),
      ];

  @override
  Widget toWidget({
    required final TetaWidgetState state,
    final CNode? child,
    final List<CNode>? children,
  }) =>
      WDecoratedBox(
        ValueKey(
          '''
          ${state.toKey}
          ${child ?? children}
          ${(attributes[DBKeys.borderRadius] as FBorderRadius).toJson()}
          ${(attributes[DBKeys.shadows] as FShadow).toJson()}
          ${(attributes[DBKeys.fill] as FFill).toJson()}
          ''',
        ),
        state: state,
        child: child,
        borderRadius: attributes[DBKeys.borderRadius] as FBorderRadius,
        shadows: attributes[DBKeys.shadows] as FShadow,
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
        DecoratedBoxCodeTemplate.toCode(context, this, child),
        loop ?? 0,
      );
}
