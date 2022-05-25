// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:teta_core/src/models/dataset.dart';
import 'package:teta_core/src/models/variable.dart';

// Project imports:
import 'package:teta_widgets/src/elements/code/templates/align.dart';
import 'package:teta_widgets/src/elements/code/templates/web_view_x_template.dart';
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
import 'package:teta_widgets/src/elements/widgets/webview.dart';

const _globalType = NType.webview;

/// IS
final webviewIntrinsicStates = IntrinsicStates(
  nodeIcon: Assets.wIcons.webView,
  nodeVideo: null,
  nodeDescription: null,
  advicedChildren: [],
  blockedTypes: [],
  synonymous: [
    NodeType.name(_globalType),
  ],
  advicedChildrenCanHaveAtLeastAChild: [],
  displayName: NodeType.name(_globalType),
  type: _globalType,
  category: NodeCategories.advanced,
  maxChildren: 1,
  canHave: ChildrenEnum.none,
  addChildLabels: [],
  gestures: [],
  permissions: [],
);

/// Set of funcs to use Align widget
/// ```dart
/// Align({
///   Key? key,
///   AlignmentGeometry alignment,
///   double? widthFactor,
///   double? heightFactor,
///   Widget? child
/// })
/// ```
class WebViewBody extends NodeBody {
  @override
  // ignore: overridden_fields
  Map<String, dynamic> attributes = <String, dynamic>{
    DBKeys.value: FTextTypeInput(type: FTextTypeEnum.state),
    DBKeys.valueOfCondition: FTextTypeInput(value: 'https://teta.so'),
  };

  @override
  List<ControlModel> get controls => [
        ControlObject(
          type: ControlType.webViewController,
          key: DBKeys.value,
          value: attributes[DBKeys.value] as FTextTypeInput,
        ),
        ControlObject(
          type: ControlType.value,
          key: DBKeys.valueOfCondition,
          value: attributes[DBKeys.valueOfCondition] as FTextTypeInput,
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
      WWebViewXPage(
        ValueKey(
          '''
            ${node.nid}
            $loop
            ${child ?? children}
            ${(attributes[DBKeys.value] as FTextTypeInput).toJson()}
            ${(attributes[DBKeys.valueOfCondition] as FTextTypeInput).toJson()}
            ''',
        ),
        controller: attributes[DBKeys.value] as FTextTypeInput,
        url: attributes[DBKeys.valueOfCondition] as FTextTypeInput,
        node: node,
        forPlay: forPlay,
        loop: loop,
        params: params,
        states: states,
        dataset: dataset,
      );

  @override
  String toCode(
    final BuildContext context,
    final CNode node,
    final CNode? child,
    final List<CNode>? children,
    final int pageId,
    final int? loop,
  ) =>
      WebViewXTemplate.toCode(
        initialUrl: (attributes[DBKeys.valueOfCondition] as FTextTypeInput)
            .toCode(loop),
      );
}
