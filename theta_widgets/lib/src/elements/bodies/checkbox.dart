// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:theta_models/src/models/variable.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
import 'package:teta_widgets/src/elements/code/snippets.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/templates/checkbox.dart';
import 'package:teta_widgets/src/elements/controls/control_model.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/controls/type.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/gestures.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_widgets/src/elements/intrinsic_states/class.dart';
import '../../../../../../teta_open_classes/lib/src/nodes/categories.dart';
import '../../../../../../teta_open_classes/lib/src/nodes/children_enum.dart';
import '../../../../../../teta_open_classes/lib/src/nodes/enum.dart';
import '../../../../../../teta_open_classes/lib/src/nodes/node.dart';
import '../../../../../../teta_open_classes/lib/src/nodes/node_body.dart';
import 'package:teta_widgets/src/elements/widgets/checkbox.dart';

const _globalType = NType.checkbox;

/// Instrict State of Checkbox
final checkBoxIntrinsicStates = IntrinsicStates(
  nodeIcon: Assets.wIcons.checkbox,
  nodeVideo: null,
  nodeDescription: null,
  advicedChildren: [],
  blockedTypes: [],
  synonymous: ['checkbox', 'form', 'input'],
  advicedChildrenCanHaveAtLeastAChild: [],
  displayName: NodeType.name(_globalType),
  type: _globalType,
  category: NodeCategories.form,
  maxChildren: 0,
  canHave: ChildrenEnum.none,
  addChildLabels: [],
  gestures: [ActionGesture.onChange],
  permissions: [],
  packages: [],
);

/// Set of funcs to use CheckBox widget
class CheckBoxBody extends NodeBody {
  @override
  // ignore: overridden_fields
  Map<String, dynamic> attributes = <String, dynamic>{
    DBKeys.value: FTextTypeInput(),
  };

  @override
  List<ControlModel> get controls => [
        ControlObject(
          type: ControlType.value,
          key: DBKeys.value,
          value: attributes[DBKeys.value],
          valueType: VariableType.bool,
        ),
      ];

  @override
  Widget toWidget({
    required final TetaWidgetState state,
    final CNode? child,
    final List<CNode>? children,
  }) =>
      WCheckBox(
        ValueKey(
          '''
            ${state.toKey}
            ${child ?? children}
            ${(attributes[DBKeys.value] as FTextTypeInput).toJson()}
            ''',
        ),
        state: state,
        value: attributes[DBKeys.value] as FTextTypeInput,
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
        CheckBoxCodeTemplate.toCode(
          context,
          this,
          loop ?? 0,
        ),
        loop ?? 0,
      );
}
