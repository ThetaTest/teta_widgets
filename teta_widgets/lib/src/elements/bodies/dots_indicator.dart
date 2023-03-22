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
import 'package:teta_widgets/src/elements/features/border.dart';
import 'package:teta_widgets/src/elements/features/border_radius.dart';
import 'package:teta_widgets/src/elements/features/border_style.dart';
import 'package:teta_widgets/src/elements/features/fill.dart';
import 'package:teta_widgets/src/elements/features/margins.dart';
import 'package:teta_widgets/src/elements/features/shadow.dart';
import 'package:teta_widgets/src/elements/features/sizes.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_widgets/src/elements/intrinsic_states/class.dart';
import 'package:teta_widgets/src/elements/nodes/categories.dart';
import 'package:teta_widgets/src/elements/nodes/children_enum.dart';
import 'package:teta_widgets/src/elements/nodes/enum.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';
import 'package:teta_widgets/src/elements/widgets/dots_indicator.dart';

const _globalType = NType.dotsIndicator;

/// Instrict State of Expanded
final dotsIndicatorIntrinsicStates = IntrinsicStates(
  nodeIcon: Assets.wIcons.dotsIndicator,
  nodeVideo: null,
  nodeDescription: null,
  advicedChildren: [
    NodeType.name(NType.image),
    NodeType.name(NType.center),
    NodeType.name(NType.column),
  ],
  blockedTypes: [],
  synonymous: ['dots', 'indicator'],
  advicedChildrenCanHaveAtLeastAChild: [],
  displayName: NodeType.name(_globalType),
  type: _globalType,
  category: NodeCategories.unclassified,
  maxChildren: 1,
  canHave: ChildrenEnum.child,
  addChildLabels: [],
  gestures: [],
  permissions: [],
  packages: [],
);

/// Expanded's body
class DotsIndicatorBody extends NodeBody {
  @override
  // ignore: overridden_fields
  Map<String, dynamic> attributes = <String, dynamic>{
    DBKeys.value: FTextTypeInput(value: '3'),
    DBKeys.valueOfCondition: FTextTypeInput(value: '0'),
    DBKeys.margins: FMargins(margins: ['4', '4', '4', '4']),
    DBKeys.borderRadius: FBorderRadius(radius: [8, 8, 8, 8]),
    DBKeys.width: FSize(size: '8'),
    DBKeys.height: FSize(size: '8'),
    DBKeys.fill: FFill(levels: [FFillElement(color: 'a1a1a1', stop: 0)]),
    DBKeys.bgFill: FFill(levels: [FFillElement(color: '444444', stop: 0)]),
    DBKeys.borderStyle: FBorderStyle(),
    DBKeys.borders: FBorder(),
    DBKeys.activeBorders: FBorder(),
    DBKeys.shadows: FShadow(),
  };

  @override
  List<ControlModel> get controls => [
        ControlObject(
          type: ControlType.value,
          key: DBKeys.value,
          value: attributes[DBKeys.value],
          title: 'Number of dots',
          valueType: VariableType.int,
        ),
        ControlObject(
          type: ControlType.value,
          key: DBKeys.valueOfCondition,
          value: attributes[DBKeys.valueOfCondition],
          title: 'Current position',
          description: 'The position index starts from 0',
          valueType: VariableType.int,
        ),
        ControlObject(
          type: ControlType.margins,
          key: DBKeys.margins,
          value: attributes[DBKeys.margins],
          valueType: VariableType.double,
        ),
        SizesControlObject(
          keys: const [DBKeys.width, DBKeys.height],
          values: [
            attributes[DBKeys.width] as FSize,
            attributes[DBKeys.height] as FSize
          ],
        ),
        ControlObject(
          type: ControlType.borderRadius,
          key: DBKeys.borderRadius,
          value: attributes[DBKeys.borderRadius],
          valueType: VariableType.double,
        ),
        FillControlObject(
          title: 'Active Color',
          key: DBKeys.fill,
          value: attributes[DBKeys.fill] as FFill,
          isStyled: true,
          isImageEnabled: false,
          isNoneEnabled: false,
          isOnlySolid: true,
        ),
        FillControlObject(
          title: 'Color',
          key: DBKeys.bgFill,
          value: attributes[DBKeys.bgFill] as FFill,
          isStyled: true,
          isImageEnabled: false,
          isNoneEnabled: false,
          isOnlySolid: true,
        ),
      ];

  @override
  Widget toWidget({
    required final TetaWidgetState state,
    final CNode? child,
    final List<CNode>? children,
  }) =>
      WDotsIndicator(
        ValueKey(
          '''
          ${state.toKey}
          ${child ?? children}
          ${(attributes[DBKeys.height] as FSize).toJson()}
          ${(attributes[DBKeys.fill] as FFill).toJson()}
          ${(attributes[DBKeys.bgFill] as FFill).toJson()}
          ${(attributes[DBKeys.value] as FTextTypeInput).toJson()}
          ${(attributes[DBKeys.valueOfCondition] as FTextTypeInput).toJson()}
          ${(attributes[DBKeys.margins] as FMargins).toJson()}
          ${(attributes[DBKeys.borderRadius] as FBorderRadius).toJson()}
          ${(attributes[DBKeys.width] as FSize).toJson()}
          ${(attributes[DBKeys.height] as FSize).toJson()}
          ${(attributes[DBKeys.shadows] as FShadow).toJson()}
          ${(attributes[DBKeys.borders] as FBorder).toJson()}
          ${(attributes[DBKeys.activeBorders] as FBorder).toJson()}
          ''',
        ),
        state: state,
        child: child,
        activeColor: attributes[DBKeys.fill] as FFill,
        color: attributes[DBKeys.bgFill] as FFill,
        dotsCount: attributes[DBKeys.value] as FTextTypeInput,
        position: attributes[DBKeys.valueOfCondition] as FTextTypeInput,
        margins: attributes[DBKeys.margins] as FMargins,
        borderRadius: attributes[DBKeys.borderRadius] as FBorderRadius,
        width: attributes[DBKeys.width] as FSize,
        height: attributes[DBKeys.height] as FSize,
        shadow: attributes[DBKeys.shadows] as FShadow,
        border: attributes[DBKeys.borders] as FBorder,
        activeBorder: attributes[DBKeys.activeBorders] as FBorder,
      );

  //! TODO
  @override
  Future<String> toCode(
    final BuildContext context,
    final CNode node,
    final CNode? child,
    final List<CNode>? children,
    final int pageId,
    final int? loop,
  ) =>
      Future.value('');
}
