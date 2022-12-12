// Flutter imports:
// ignore_for_file: lines_longer_than_80_chars

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
import 'package:teta_widgets/src/elements/code/snippets.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/templates/stripe_transactions_builder_template.dart';
import 'package:teta_widgets/src/elements/controls/control_model.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/features/dataset.dart';
import 'package:teta_widgets/src/elements/intrinsic_states/class.dart';
import 'package:teta_widgets/src/elements/nodes/categories.dart';
import 'package:teta_widgets/src/elements/nodes/children_enum.dart';
import 'package:teta_widgets/src/elements/nodes/enum.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';
import 'package:teta_widgets/src/elements/widgets/stripe_transactions_builder.dart';

const _globalType = NType.stripeTransactionsBuilder;

/// Intrinsic States of ListView Builder
final stripeTransactionsBuilder = IntrinsicStates(
  nodeIcon: Assets.wIcons.supabaseLogoIcon,
  nodeVideo: null,
  nodeDescription: null,
  advicedChildren: [],
  blockedTypes: [],
  synonymous: ['stripe', 'scroll', 'vertical list', 'transactions'],
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

/// ListView Builder's body
class StripeTransactionsBuilderBody extends NodeBody {
  @override
  // ignore: overridden_fields
  Map<String, dynamic> attributes = <String, dynamic>{
    DBKeys.datasetInput: FDataset(),
    DBKeys.isVertical: true,
    DBKeys.flag: true,
    DBKeys.isPrimary: true,
  };

  @override
  List<ControlModel> get controls => [
        FlagControlObject(
          title: 'Is Vertical',
          key: DBKeys.isVertical,
          value: attributes[DBKeys.isVertical],
          description: 'The axis along which the scroll view scrolls.',
        ),
        FlagControlObject(
          title: 'Shrink Wrap',
          key: DBKeys.flag,
          value: attributes[DBKeys.flag],
          description:
              'Whether the extent of the scroll view in the scrollDirection should be determined by the contents being viewed.',
        ),
      ];

  @override
  Widget toWidget({
    required final TetaWidgetState state,
    final CNode? child,
    final List<CNode>? children,
  }) =>
      WStripeTransactionsBuilder(
        ValueKey(
          '''
      ${state.toKey}
      ${child ?? children}
      ${(attributes[DBKeys.datasetInput] as FDataset).toJson()}
      ${attributes[DBKeys.isVertical] as bool}
      ${attributes[DBKeys.flag] as bool}
      ''',
        ),
        state: state,
        child: child,
        value: attributes[DBKeys.datasetInput] as FDataset,
        isVertical: attributes[DBKeys.isVertical] as bool,
        shrinkWrap: attributes[DBKeys.flag] as bool,
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
        StripeTransactionsBuilderCodeTemplate.toCode(context, this, child),
        loop ?? 0,
      );
}
