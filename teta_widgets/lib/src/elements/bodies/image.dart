// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:teta_core/src/models/variable.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
import 'package:teta_widgets/src/elements/code/snippets.dart';
// Project imports:
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
import 'package:teta_widgets/src/elements/nodes/suggestion.dart';
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
  permissions: [],
  packages: [],
  suggestionsTitle: 'Why use Image in Teta?',
  suggestions: [
    const Suggestion(
      title: 'Why use Image in Teta?',
      description: 'Test',
      linkToOpen: 'https://docs.teta.so/teta-docs/widget/basic-widgets/image',
    )
  ],
);

/// Image's body
class ImageBody extends NodeBody {
  @override
  // ignore: overridden_fields
  Map<String, dynamic> attributes = <String, dynamic>{
    DBKeys.width: FSize(size: 'max', unit: SizeUnit.pixel),
    DBKeys.height: FSize(size: '150', unit: SizeUnit.pixel),
    DBKeys.image: FTextTypeInput(),
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
          valueType: VariableType.string,
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
          valueType: VariableType.double,
        ),
      ];

  @override
  Widget toWidget({
    required final TetaWidgetState state,
    final CNode? child,
    final List<CNode>? children,
  }) =>
      WImage(
        ValueKey(
          '''
            ${state.node.nid}
            ${state.loop}
            ${child ?? children}
            ${(attributes[DBKeys.image] as FTextTypeInput).toJson()} 
            ${(attributes[DBKeys.width] as FSize).size}
            ${(attributes[DBKeys.height] as FSize).size}
            ${(attributes[DBKeys.boxFit] as FBoxFit).fit}
            ${(attributes[DBKeys.borderRadius] as FBorderRadius).radius}
            ${(attributes[DBKeys.shadows] as FShadow).toJson()}
          ''',
        ),
        state: state,
        image: attributes[DBKeys.image] as FTextTypeInput,
        width: attributes[DBKeys.width] as FSize,
        height: attributes[DBKeys.height] as FSize,
        boxFit: attributes[DBKeys.boxFit] as FBoxFit,
        borderRadius: attributes[DBKeys.borderRadius] as FBorderRadius,
        shadows: attributes[DBKeys.shadows] as FShadow,
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
        ImageCodeTemplate.toCode(context, this, child, loop),
        loop ?? 0,
      );
}
