// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:theta_models/src/models/variable.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/templates/bouncing_widget.dart';
import 'package:teta_widgets/src/elements/controls/control_model.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/controls/type.dart';
import 'package:teta_widgets/src/elements/features/action.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/index.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_widgets/src/elements/intrinsic_states/class.dart';
import '../../../../../../teta_open_classes/lib/src/nodes/categories.dart';
import '../../../../../../teta_open_classes/lib/src/nodes/children_enum.dart';
import '../../../../../../teta_open_classes/lib/src/nodes/enum.dart';
import '../../../../../../teta_open_classes/lib/src/nodes/node.dart';
import '../../../../../../teta_open_classes/lib/src/nodes/node_body.dart';
import '../../../../../../teta_open_classes/lib/src/nodes/suggestion.dart';
import 'package:teta_widgets/src/elements/packages.dart';
import 'package:teta_widgets/src/elements/widgets/bouncing_widget.dart';

const _globalType = NType.bouncingWidget;

/// Instrict State of Bouncing Widget
final bouncingWidgetIntrinsicStates = IntrinsicStates(
  nodeIcon: Assets.wIcons.bouncingWidget,
  nodeVideo: 'c1xLMaTUWCY',
  nodeDescription: '''''',
  advicedChildren: [
    NodeType.name(NType.column),
    NodeType.name(NType.container),
    NodeType.name(NType.row),
  ],
  blockedTypes: [],
  synonymous: ['bouncing widget', 'animation', 'hover', 'on tap'],
  advicedChildrenCanHaveAtLeastAChild: [],
  displayName: NodeType.name(_globalType),
  type: _globalType,
  category: NodeCategories.animations,
  maxChildren: 1,
  canHave: ChildrenEnum.child,
  addChildLabels: [],
  gestures: [
    ActionGesture.onTap,
  ],
  permissions: [],
  packages: [pBouncingWidget],
  suggestionsTitle: 'Why use Button in Teta?',
  suggestions: [
    const Suggestion(
      title: 'Why use Button in Teta?',
      description: 'Test',
      linkToOpen:
          'https://docs.teta.so/teta-docs/widget/animated-widgets/bouncing-widget',
    )
  ],
);

/// Set of funcs to use Container widget
class BouncingWidgetBody extends NodeBody {
  @override
  // ignore: overridden_fields
  Map<String, dynamic> attributes = <String, dynamic>{
    DBKeys.action: NodeGestureActions.empty(),
    DBKeys.value: FTextTypeInput(value: '100'),
    DBKeys.valueOfCondition: FTextTypeInput(value: '1.5'),
  };

  @override
  List<ControlModel> get controls => [
        ControlObject(
          title: 'Duration',
          type: ControlType.value,
          key: DBKeys.value,
          value: attributes[DBKeys.value],
          description:
              'Milliseconds value. Only integers are accepted. E.g. 1000 (= 1s), 2000 (= 2s) etc.',
          valueType: VariableType.int,
        ),
        ControlObject(
          title: 'Scale Factor',
          type: ControlType.value,
          key: DBKeys.valueOfCondition,
          value: attributes[DBKeys.valueOfCondition],
          valueType: VariableType.double,
        ),
      ];

  @override
  Widget toWidget({
    required final TetaWidgetState state,
    final CNode? child,
    final List<CNode>? children,
  }) {
    return WBouncingWidget(
      ValueKey(
        '''
        ${state.toKey}
        ${child ?? children}
        ${(attributes[DBKeys.action] as NodeGestureActions).toJson()}
        ${(attributes[DBKeys.value] as FTextTypeInput).toJson()}
        ${(attributes[DBKeys.valueOfCondition] as FTextTypeInput).toJson()}
        ''',
      ),
      state: state,
      child: child,
      action: attributes[DBKeys.action] as NodeGestureActions,
      value: attributes[DBKeys.value] as FTextTypeInput,
      valueOfCondition: attributes[DBKeys.valueOfCondition] as FTextTypeInput,
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
      BouncingWidgetCodeTemplate.toCode(
        pageId,
        context,
        this,
        node,
        child,
        loop ?? 0,
      );
}
