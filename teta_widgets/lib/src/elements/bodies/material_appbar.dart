// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:teta_core/src/models/dataset.dart';
import 'package:teta_core/src/models/variable.dart';

// Project imports:
import 'package:teta_widgets/src/elements/code/templates/material_appbar.dart';
import 'package:teta_widgets/src/elements/controls/control_model.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/features/fill.dart';
import 'package:teta_widgets/src/elements/intrinsic_states/class.dart';
import 'package:teta_widgets/src/elements/nodes/categories.dart';
import 'package:teta_widgets/src/elements/nodes/children_enum.dart';
import 'package:teta_widgets/src/elements/nodes/enum.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';
import 'package:teta_widgets/src/elements/widgets/material_appbar.dart';

const _globalType = NType.materialAppBar;

/// Intrinsic States of MaterialAppBar
final materialAppBarIntrinsicStates = IntrinsicStates(
  nodeIcon: Assets.wIcons.box,
  nodeVideo: null,
  nodeDescription: null,
  advicedChildren: [],
  blockedTypes: [],
  synonymous: [NodeType.name(NType.materialAppBar), 'navigation', 'navbar'],
  advicedChildrenCanHaveAtLeastAChild: [],
  displayName: NodeType.name(_globalType),
  type: _globalType,
  category: NodeCategories.unclassified,
  maxChildren: 5,
  canHave: ChildrenEnum.children,
  addChildLabels: [
    'Add Title',
    'Add Leading',
    'Add Action',
    'Add Action',
    'Add Action'
  ],
  gestures: [],
);

/// ```dart
/// AppBar({
///   Key? key,
///   Widget? leading,
///   bool automaticallyImplyLeading,
///   Widget? title,
///   List<Widget>? actions,
///   Widget? flexibleSpace,
///   PreferredSizeWidget? bottom,
///   double? elevation,
///   Color? shadowColor,
///   ShapeBorder? shape,
///   Color? backgroundColor,
///   Color? foregroundColor,
///   Brightness? brightness,
///   IconThemeData? iconTheme,
///   IconThemeData? actionsIconTheme,
///   TextTheme? textTheme,
///   bool primary,
///   bool? centerTitle,
///   bool excludeHeaderSemantics,
///   double? titleSpacing,
///   double toolbarOpacity,
///   double bottomOpacity,
///   double? toolbarHeight,
///   double? leadingWidth,
///   bool? backwardsCompatibility,
///   TextStyle? toolbarTextStyle,
///   TextStyle? titleTextStyle,
///   SystemUiOverlayStyle? systemOverlayStyle
/// })
/// ```
class MaterialAppBarBody extends NodeBody {
  @override
  // ignore: overridden_fields
  Map<String, dynamic> attributes = <String, dynamic>{
    DBKeys.fill: FFill(levels: [FFillElement(color: 'ffffff', stop: 0)]),
  };

  @override
  List<ControlModel> get controls => [
        FillControlObject(
          title: '',
          key: 'Background Color',
          value: attributes[DBKeys.fill] as FFill,
          isStyled: false,
          isImageEnabled: false,
          isNoneEnabled: false,
          isOnlySolid: true,
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
      WMaterialAppBar(
        ValueKey(
          '''
      ${node.nid}
      $loop
            ${child ?? children}
      ${(attributes[DBKeys.fill] as FFill).toJson()}
      ''',
        ),
        children: children ?? [],
        node: node,
        fill: attributes[DBKeys.fill] as FFill,
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
      materialAppBarCodeTemplate(context, this, children ?? []);
}
