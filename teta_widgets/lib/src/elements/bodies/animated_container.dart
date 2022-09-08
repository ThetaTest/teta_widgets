// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:teta_core/src/models/dataset.dart';
import 'package:teta_core/src/models/variable.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/templates/animated_container.dart';
import 'package:teta_widgets/src/elements/controls/control_model.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/controls/type.dart';
import 'package:teta_widgets/src/elements/features/border_radius.dart';
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
import 'package:teta_widgets/src/elements/widgets/animated_container.dart';

const _globalType = NType.animatedContainer;

/// Instrict State of AnimatedContainer
final animatedContainerIntrinsicStates = IntrinsicStates(
  nodeIcon: Assets.wIcons.animatedContainer,
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
  synonymous: ['animatedContainer', 'box', 'container', 'square', 'div'],
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

/// Set of funcs to use Container widget
class AnimatedContainerBody extends NodeBody {
  @override
  // ignore: overridden_fields
  Map<String, dynamic> attributes = <String, dynamic>{
    DBKeys.width: FSize(size: 'max', unit: SizeUnit.pixel),
    DBKeys.height: FSize(size: '150', unit: SizeUnit.pixel),
    DBKeys.margins: FMargins(),
    DBKeys.padding: FMargins(),
    DBKeys.borderRadius: FBorderRadius(),
    DBKeys.shadows: FShadow(),
    DBKeys.fill: FFill(),
    DBKeys.value: FTextTypeInput(),
    DBKeys.duration: FTextTypeInput(value: '1000'),
  };

  @override
  List<ControlModel> get controls => [
        ControlObject(
          type: ControlType.margins,
          key: DBKeys.margins,
          value: attributes[DBKeys.margins],
        ),
        ControlObject(
          type: ControlType.padding,
          key: DBKeys.padding,
          value: attributes[DBKeys.padding],
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
        ),
        ControlObject(
          type: ControlType.shadows,
          key: DBKeys.shadows,
          value: attributes[DBKeys.shadows],
        ),
        ControlObject(
          title: 'Duration',
          type: ControlType.value,
          key: DBKeys.duration,
          value: attributes[DBKeys.duration],
        ),
      ];

  @override
  Widget toWidget({
    required final List<VariableObject> params,
    required final List<VariableObject> states,
    required final List<DatasetObject> dataset,
    required final bool forPlay,
    required final CNode node,
    final int? loop,
    final CNode? child,
    final List<CNode>? children,
  }) {
    return WAnimatedContainer(
      ValueKey(
        '''
          ${node.nid}
          $loop
            ${child ?? children}
          ${(attributes[DBKeys.width] as FSize).size}
          ${(attributes[DBKeys.height] as FSize).size}
          ${(attributes[DBKeys.margins] as FMargins).margins}
          ${(attributes[DBKeys.padding] as FMargins).margins}
          ${(attributes[DBKeys.borderRadius] as FBorderRadius).radius}
          ${(attributes[DBKeys.fill] as FFill).levels}
          ${(attributes[DBKeys.value] as FTextTypeInput).toJson()}
          ${(attributes[DBKeys.duration] as FTextTypeInput).toJson()}
        ''',
      ),
      node: node,
      child: child,
      width: attributes[DBKeys.width] as FSize,
      height: attributes[DBKeys.height] as FSize,
      margins: attributes[DBKeys.margins] as FMargins,
      paddings: attributes[DBKeys.padding] as FMargins,
      borderRadius: attributes[DBKeys.borderRadius] as FBorderRadius,
      shadows: attributes[DBKeys.shadows] as FShadow,
      fill: attributes[DBKeys.fill] as FFill,
      value: attributes[DBKeys.value] as FTextTypeInput,
      duration: attributes[DBKeys.duration] as FTextTypeInput,
      forPlay: forPlay,
      loop: loop,
      params: params,
      states: states,
      dataset: dataset,
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
      AnimatedContainerCodeTemplate.toCode(context, this, child, loop);
}
