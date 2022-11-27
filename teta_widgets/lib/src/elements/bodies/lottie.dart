// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:teta_core/src/models/variable.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
import 'package:teta_widgets/src/elements/code/snippets.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/templates/lottie.dart';
import 'package:teta_widgets/src/elements/controls/control_model.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/controls/type.dart';
import 'package:teta_widgets/src/elements/features/box_fit.dart';
import 'package:teta_widgets/src/elements/features/sizes.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_widgets/src/elements/intrinsic_states/class.dart';
import 'package:teta_widgets/src/elements/nodes/categories.dart';
import 'package:teta_widgets/src/elements/nodes/children_enum.dart';
import 'package:teta_widgets/src/elements/nodes/enum.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';
import 'package:teta_widgets/src/elements/nodes/suggestion.dart';
import 'package:teta_widgets/src/elements/packages.dart';
import 'package:teta_widgets/src/elements/widgets/lottie.dart';

const _globalType = NType.lottie;

/// Lottie Intrinsic States
final lottieIntrinsicStates = IntrinsicStates(
  nodeIcon: Assets.wIcons.lottieFiles,
  nodeVideo: null,
  nodeDescription: null,
  advicedChildren: [],
  blockedTypes: [],
  synonymous: ['lottie', 'animation'],
  advicedChildrenCanHaveAtLeastAChild: [],
  displayName: NodeType.name(_globalType),
  type: _globalType,
  category: NodeCategories.basic,
  maxChildren: 0,
  canHave: ChildrenEnum.none,
  addChildLabels: [],
  gestures: [],
  permissions: [],
  packages: [pLottie],
  suggestionsTitle: 'Why use Lottie in Teta?',
  suggestions: [
    const Suggestion(
      title: 'Why use Lottie in Teta?',
      description: 'Test',
      linkToOpen: 'https://docs.teta.so/teta-docs/widget/advanced-widgets/lottie',
    )
  ],
);

/// Body of Lottie
class LottieBody extends NodeBody {
  @override
  // ignore: overridden_fields
  Map<String, dynamic> attributes = <String, dynamic>{
    DBKeys.width: FSize(
      size: 'max',
      unit: SizeUnit.pixel,
    ),
    DBKeys.height: FSize(
      size: '150',
      unit: SizeUnit.pixel,
    ),
    DBKeys.image: FTextTypeInput(
      value: 'https://assets6.lottiefiles.com/packages/lf20_c7mbzzus.json',
    ),
    DBKeys.boxFit: FBoxFit(),
  };

  @override
  List<ControlModel> get controls => [
        ControlObject(
          type: ControlType.image,
          key: DBKeys.image,
          value: attributes[DBKeys.image],
          valueType: VariableType.string,
        ),
        ControlObject(
          type: ControlType.boxFit,
          key: DBKeys.boxFit,
          value: attributes[DBKeys.boxFit],
          valueType: VariableType.string,
        ),
        SizesControlObject(
          keys: const [DBKeys.width, DBKeys.height],
          values: <FSize>[
            attributes[DBKeys.width] as FSize,
            attributes[DBKeys.height] as FSize,
          ],
        ),
      ];

  @override
  Widget toWidget({
    required final TetaWidgetState state,
    final CNode? child,
    final List<CNode>? children,
  }) =>
      WLottie(
        ValueKey(
          '''
      ${state.node.nid}
      ${state.loop}
            ${child ?? children}
      ${(attributes[DBKeys.image] as FTextTypeInput).toJson()}
      ${(attributes[DBKeys.width] as FSize).toJson()}
      ${(attributes[DBKeys.height] as FSize).toJson()}
      ${(attributes[DBKeys.boxFit] as FBoxFit).toJson()}
      ''',
        ),
        state: state,
        image: attributes[DBKeys.image] as FTextTypeInput,
        width: attributes[DBKeys.width] as FSize,
        height: attributes[DBKeys.height] as FSize,
        boxFit: attributes[DBKeys.boxFit] as FBoxFit,
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
        LottieCodeTemplate.toCode(context, this, child, loop),
        loop ?? 0,
      );
}
