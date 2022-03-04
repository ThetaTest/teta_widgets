// Flutter imports:
import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:teta_core/src/models/dataset.dart';
import 'package:teta_core/src/models/variable.dart';
import 'package:teta_widgets/src/elements/code/templates/image.dart';
import 'package:teta_widgets/src/elements/controls/control_model.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/controls/type.dart';
import 'package:teta_widgets/src/elements/features/border_radius.dart';
import 'package:teta_widgets/src/elements/features/box_fit.dart';
import 'package:teta_widgets/src/elements/features/shadow.dart';
import 'package:teta_widgets/src/elements/features/sizes.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_widgets/src/elements/intrinsic_states/class.dart';
import 'package:teta_widgets/src/elements/nodes/categories.dart';
import 'package:teta_widgets/src/elements/nodes/children_enum.dart';
import 'package:teta_widgets/src/elements/nodes/enum.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';
import 'package:teta_widgets/src/elements/widgets/image.dart';

const _globalType = NType.image;

/// Intrinsic State of Image
final imageIntrinsicStates = IntrinsicStates(
  nodeIcon: Assets.wIcons.image,
  nodeVideo: '7oIAs-0G4mw', //Check
  nodeDescription: '''
      The Image widget displays an image. 
      You either can reference images using a URL, 
      or you can include images inside your app package. 
      Since DartPad can’t package an image, 
      the following example uses an image from the network.''',
  advicedChildren: [],
  blockedTypes: [],
  synonymous: ['image', 'picture', 'photo'],
  advicedChildrenCanHaveAtLeastAChild: [],
  displayName: NodeType.name(_globalType),
  type: _globalType,
  category: NodeCategories.basic,
  maxChildren: 0,
  canHave: ChildrenEnum.none,
  addChildLabels: [],
  gestures: [],
);

/// Image's body
class ImageBody extends NodeBody {
  @override
  // ignore: overridden_fields
  Map<String, dynamic> attributes = <String, dynamic>{
    DBKeys.width: FSize(size: 'max', unit: SizeUnit.pixel),
    DBKeys.height: FSize(size: '150', unit: SizeUnit.pixel),
    DBKeys.image: FTextTypeInput(value: 'https://source.unsplash.com/random'),
    DBKeys.boxFit: FBoxFit(),
    DBKeys.borderRadius: FBorderRadius(),
    DBKeys.shadows: FShadow(),
  };

  @override
  List<ControlModel> get controls => [
        ControlObject(
          type: ControlType.image,
          key: DBKeys.image,
          value: attributes[DBKeys.image],
        ),
        BoxFitControlObject(
          key: DBKeys.boxFit,
          value: attributes[DBKeys.boxFit] as FBoxFit,
        ),
        SizesControlObject(
          keys: const [DBKeys.width, DBKeys.height],
          values: <FSize>[
            attributes[DBKeys.width] as FSize,
            attributes[DBKeys.height] as FSize,
          ],
        ),
        ControlObject(
          type: ControlType.borderRadius,
          key: DBKeys.borderRadius,
          value: attributes[DBKeys.borderRadius] as FBorderRadius,
        ),
      ];

  @override
  Widget toWidget({
    required List<VariableObject> params,
    required List<VariableObject> states,
    required List<DatasetObject> dataset,
    int? loop,
    required bool forPlay,
    required CNode node,
    CNode? child,
    List<CNode>? children,
  }) =>
      WImage(
        key: ValueKey(
          '''
            ${node.nid}
            $loop
            ${child ?? children}
            ${(attributes[DBKeys.image] as FTextTypeInput).get(params, states, dataset, forPlay, loop)} 
            ${(attributes[DBKeys.width] as FSize).size}
            ${(attributes[DBKeys.height] as FSize).size}
            ${(attributes[DBKeys.boxFit] as FBoxFit).fit}
            ${(attributes[DBKeys.borderRadius] as FBorderRadius).radius}
            ${(attributes[DBKeys.shadows] as FShadow).toJson()}
          ''',
        ),
        node: node,
        image: attributes[DBKeys.image] as FTextTypeInput,
        width: attributes[DBKeys.width] as FSize,
        height: attributes[DBKeys.height] as FSize,
        boxFit: attributes[DBKeys.boxFit] as FBoxFit,
        borderRadius: attributes[DBKeys.borderRadius] as FBorderRadius,
        shadows: attributes[DBKeys.shadows] as FShadow,
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
      imageCodeTemplate(context, this, child, loop);
}
