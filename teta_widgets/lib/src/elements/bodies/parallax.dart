// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:teta_core/src/models/dataset.dart';
import 'package:teta_core/src/models/variable.dart';

// Project imports:
import 'package:teta_widgets/src/elements/code/templates/parallax.dart';
import 'package:teta_widgets/src/elements/controls/control_model.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/controls/type.dart';
import 'package:teta_widgets/src/elements/features/sizes.dart';
import 'package:teta_widgets/src/elements/intrinsic_states/class.dart';
import 'package:teta_widgets/src/elements/nodes/categories.dart';
import 'package:teta_widgets/src/elements/nodes/children_enum.dart';
import 'package:teta_widgets/src/elements/nodes/enum.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';
import 'package:teta_widgets/src/elements/widgets/parallax.dart';

/// globalType for SizedBox widget
const _globalType = NType.parallax;

/// IntrinsicStates for SizedBox widget
final parallaxIntrinsicStates = IntrinsicStates(
  nodeIcon: Assets.wIcons.parallax,
  nodeVideo: null,
  nodeDescription: null,
  advicedChildren: [
    NodeType.name(NType.listView),
    NodeType.name(NType.column),
    NodeType.name(NType.center),
  ],
  blockedTypes: [],
  synonymous: ['parallax', 'animation', 'effect', 'scroll'],
  advicedChildrenCanHaveAtLeastAChild: [],
  displayName: NodeType.name(_globalType),
  type: _globalType,
  category: NodeCategories.advanced,
  maxChildren: 1,
  canHave: ChildrenEnum.child,
  addChildLabels: [],
  gestures: [],
);

/// Body for SizedBox widget
class ParallaxBoxBody extends NodeBody {
  @override
  // ignore: overridden_fields
  Map<String, dynamic> attributes = <String, dynamic>{
    DBKeys.height: FSize(size: 'null', unit: SizeUnit.pixel),
  };

  @override
  List<ControlModel> get controls => [
        SizeControlObject(
          type: ControlType.size,
          key: DBKeys.height,
          title: 'Height',
          isWidth: false,
          value: attributes[DBKeys.height] as FSize,
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
      WParallax(
        ValueKey(
          '''
            ${node.nid}
            $loop
            ${child ?? children}
            ${(attributes[DBKeys.height] as FSize? ?? FSize()).toJson()}, 
            ''',
        ),
        node: node,
        child: child,
        height: attributes[DBKeys.height] as FSize? ?? FSize(),
        forPlay: forPlay,
        loop: loop,
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
      parallaxCodeTemplate(context, this, child);
}
