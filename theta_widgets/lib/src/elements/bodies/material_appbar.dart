// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:theta_widgets/src/core/teta_widget/index.dart';
import 'package:theta_widgets/src/elements/code/snippets.dart';
// Project imports:
import 'package:theta_widgets/src/elements/code/templates/material_appbar.dart';
import 'package:theta_widgets/src/elements/controls/control_model.dart';
import 'package:theta_widgets/src/elements/controls/key_constants.dart';
import 'package:theta_widgets/src/elements/features/fill.dart';
import 'package:theta_widgets/src/elements/intrinsic_states/class.dart';
import '../../../../../../teta_open_classes/lib/src/nodes/categories.dart';
import '../../../../../../teta_open_classes/lib/src/nodes/children_enum.dart';
import '../../../../../../teta_open_classes/lib/src/nodes/enum.dart';
import '../../../../../../teta_open_classes/lib/src/nodes/node.dart';
import '../../../../../../teta_open_classes/lib/src/nodes/node_body.dart';
import 'package:theta_widgets/src/elements/widgets/material_appbar.dart';

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
  permissions: [],
  packages: [],
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
    required final TetaWidgetState state,
    final CNode? child,
    final List<CNode>? children,
  }) =>
      WMaterialAppBar(
        ValueKey(
          '''
      ${state.toKey}
            ${child ?? children}
      ${(attributes[DBKeys.fill] as FFill).toJson()}
      ''',
        ),
        state: state,
        children: children ?? [],
        fill: attributes[DBKeys.fill] as FFill,
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
        MaterialAppBarCodeTemplate.toCode(context, this, children ?? []),
        loop ?? 0,
      );
}
