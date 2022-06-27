// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:teta_core/src/models/dataset.dart';
import 'package:teta_core/src/models/variable.dart';
// Project imports:
import 'package:teta_widgets/src/elements/controls/control_model.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/controls/type.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_widgets/src/elements/intrinsic_states/class.dart';
import 'package:teta_widgets/src/elements/nodes/categories.dart';
import 'package:teta_widgets/src/elements/nodes/children_enum.dart';
import 'package:teta_widgets/src/elements/nodes/enum.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';
import 'package:teta_widgets/src/elements/widgets/transform.dart';

const _globalType = NType.transformPerspective;

/// IS
final transformPerspectiveIntrinsicStates = IntrinsicStates(
  nodeIcon: Assets.wIcons.toolTip,
  nodeVideo: null,
  nodeDescription: null,
  advicedChildren: [],
  blockedTypes: [],
  synonymous: [NodeType.name(_globalType), 'tooltip'],
  advicedChildrenCanHaveAtLeastAChild: [],
  displayName: NodeType.name(_globalType),
  type: _globalType,
  category: NodeCategories.unclassified,
  maxChildren: 1,
  canHave: ChildrenEnum.child,
  addChildLabels: [],
  gestures: [],
  permissions:[],
  packages: [],
);

/// Set of funcs to use Align widget
/// ```dart
/// Tooltip({
/// Key? key,
/// required String message,
/// double? height,
/// EdgeInsetsGeometry? padding,
///  EdgeInsetsGeometry? margin,
/// double? verticalOffset,
/// bool? preferBelow,
/// bool? excludeFromSemantics,
///  Decoration? decoration,
/// TextStyle? textStyle,
/// Duration? waitDuration,
/// Duration? showDuration,
/// Widget? child
/// })
/// ```

class TransformPerspectiveBody extends NodeBody {
  @override
  // ignore: overridden_fields
  Map<String, dynamic> attributes = <String, dynamic>{
    DBKeys.rotateX: FTextTypeInput(value: '0.0'),
    DBKeys.rotateY: FTextTypeInput(value: '0.0'),
    DBKeys.rotateZ: FTextTypeInput(value: '0.0'),
  };

  @override
  List<ControlModel> get controls => [
        ControlObject(
          title: 'Rotate X',
          type: ControlType.value,
          key: DBKeys.rotateY,
          value: attributes[DBKeys.rotateX],
        ),
        ControlObject(
          title: 'Rotate Y',
          type: ControlType.value,
          key: DBKeys.rotateY,
          value: attributes[DBKeys.rotateY],
        ),
        ControlObject(
          title: 'Rotate Z',
          type: ControlType.value,
          key: DBKeys.rotateZ,
          value: attributes[DBKeys.rotateZ],
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
  }) =>
      WTransform(
        ValueKey(
          '''
            ${node.nid}
            $loop
            ${child ?? children}
            ${(attributes[DBKeys.rotateX] as FTextTypeInput).get(
            params,
            states,
            dataset,
            forPlay,
            loop,
          )}
            ${(attributes[DBKeys.rotateY] as FTextTypeInput).get(
            params,
            states,
            dataset,
            forPlay,
            loop,
          )}
            ${(attributes[DBKeys.rotateZ] as FTextTypeInput).get(
            params,
            states,
            dataset,
            forPlay,
            loop,
          )}
            ''',
        ),
        node: node,
        child: child,
        valueX: attributes[DBKeys.rotateX] as FTextTypeInput,
        valueY: attributes[DBKeys.rotateY] as FTextTypeInput,
        valueZ: attributes[DBKeys.rotateZ] as FTextTypeInput,
        forPlay: forPlay,
        loop: loop,
        params: params,
        states: states,
        dataset: dataset,
      );

  // TODO: implement toCode
  @override
  String toCode(
    final BuildContext context,
    final CNode node,
    final CNode? child,
    final List<CNode>? children,
    final int pageId,
    final int? loop,
  ) =>
      '';
}
