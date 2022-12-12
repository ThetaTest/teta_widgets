// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:teta_core/src/models/variable.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
import 'package:teta_widgets/src/elements/code/snippets.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/templates/container.dart';
import 'package:teta_widgets/src/elements/controls/control_model.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/controls/type.dart';
import 'package:teta_widgets/src/elements/features/border.dart';
import 'package:teta_widgets/src/elements/features/border_radius.dart';
import 'package:teta_widgets/src/elements/features/fill.dart';
import 'package:teta_widgets/src/elements/features/margins.dart';
import 'package:teta_widgets/src/elements/features/shadow.dart';
import 'package:teta_widgets/src/elements/features/sizes.dart';
import 'package:teta_widgets/src/elements/intrinsic_states/class.dart';
import 'package:teta_widgets/src/elements/nodes/categories.dart';
import 'package:teta_widgets/src/elements/nodes/children_enum.dart';
import 'package:teta_widgets/src/elements/nodes/enum.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';
import 'package:teta_widgets/src/elements/nodes/suggestion.dart';
import 'package:teta_widgets/src/elements/widgets/container.dart';

const _globalType = NType.container;

/// Instrinsic States of Container
/// Basic info for this node type, shared between all the instances
final containerIntrinsicStates = IntrinsicStates(
  nodeIcon: Assets.wIcons.box,
  nodeVideo: 'c1xLMaTUWCY',
  nodeDescription: '''
      The Container widget lets you create a rectangular visual element. 
      A container can be decorated with a background, a border, or a shadow. 
      A Container can also have margins, padding, 
      and constraints applied to its size. 
      In addition, a Container can be transformed in three dimensional space using a matrix. 
      A convenience widget that combines common painting, positioning, and sizing widgets.''',
  advicedChildren: [
    NodeType.name(NType.column),
    NodeType.name(NType.container),
    NodeType.name(NType.row),
  ],
  blockedTypes: [],
  synonymous: ['box', 'container', 'square', 'div'],
  advicedChildrenCanHaveAtLeastAChild: [],
  displayName: NodeType.name(_globalType),
  type: _globalType,
  category: NodeCategories.basic,
  maxChildren: 1,
  canHave: ChildrenEnum.child,
  addChildLabels: [],
  gestures: [],
  permissions: [],
  packages: [],
  suggestionsTitle: 'Why use Container in Teta?',
  suggestions: [
    const Suggestion(
      title: 'Why use Container in Teta?',
      description: 'Test',
      linkToOpen:
          'https://docs.teta.so/teta-docs/widget/basic-widgets/container',
    )
  ],
);

/// Set of funcs to use Container widget
class ContainerBody extends NodeBody {
  @override
  // ignore: overridden_fields
  Map<String, dynamic> attributes = <String, dynamic>{
    DBKeys.width: FSize(size: 'max', unit: SizeUnit.pixel),
    DBKeys.height: FSize(size: 'null', unit: SizeUnit.pixel),
    DBKeys.margins: FMargins(),
    DBKeys.padding: FMargins(),
    DBKeys.borderRadius: FBorderRadius(),
    DBKeys.shadows: FShadow(),
    DBKeys.fill: FFill(),
    DBKeys.borders: FBorder(),
  };

  @override
  List<ControlModel> get controls => [
        ControlObject(
          type: ControlType.margins,
          key: DBKeys.margins,
          value: attributes[DBKeys.margins],
          valueType: VariableType.double,
        ),
        ControlObject(
          type: ControlType.padding,
          key: DBKeys.padding,
          value: attributes[DBKeys.padding],
          valueType: VariableType.double,
        ),
        SizesControlObject(
          keys: const [DBKeys.width, DBKeys.height],
          values: <FSize>[
            attributes[DBKeys.width] as FSize,
            attributes[DBKeys.height] as FSize,
          ],
        ),
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
          type: ControlType.border,
          key: DBKeys.borders,
          value: attributes[DBKeys.borders],
          valueType: VariableType.string,
        ),
      ];

  @override
  Widget toWidget({
    required final TetaWidgetState state,
    final CNode? child,
    final List<CNode>? children,
  }) {
    return WContainer(
      ValueKey(
        '''
        ${state.toKey}
        ${child ?? children}
        ${(attributes[DBKeys.width] as FSize).toJson()}
        ${(attributes[DBKeys.height] as FSize).toJson()}
        ${(attributes[DBKeys.margins] as FMargins).toJson()}
        ${(attributes[DBKeys.padding] as FMargins).toJson()}
        ${(attributes[DBKeys.borderRadius] as FBorderRadius).toJson()}
        ${(attributes[DBKeys.shadows] as FShadow).toJson()}
        ${(attributes[DBKeys.fill] as FFill).toJson()}
        ${(attributes[DBKeys.borders] as FBorder).toJson()}
        ''',
      ),
      state: state,
      child: child,
      width: attributes[DBKeys.width] as FSize,
      height: attributes[DBKeys.height] as FSize,
      margins: attributes[DBKeys.margins] as FMargins,
      paddings: attributes[DBKeys.padding] as FMargins,
      borderRadius: attributes[DBKeys.borderRadius] as FBorderRadius,
      shadows: attributes[DBKeys.shadows] as FShadow,
      fill: attributes[DBKeys.fill] as FFill,
      borders: attributes[DBKeys.borders] as FBorder,
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
      CS.defaultWidgets(
        context,
        node,
        pageId,
        ContainerCodeTemplate.toCode(context, this, child),
        loop ?? 0,
      );
}
