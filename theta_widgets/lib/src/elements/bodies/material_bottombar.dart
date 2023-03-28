// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
// Project imports:
import 'package:teta_widgets/src/elements/controls/control_model.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/features/fill.dart';
import 'package:teta_widgets/src/elements/intrinsic_states/class.dart';
import 'package:teta_widgets/src/elements/nodes/categories.dart';
import 'package:teta_widgets/src/elements/nodes/children_enum.dart';
import 'package:teta_widgets/src/elements/nodes/enum.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';
import 'package:teta_widgets/src/elements/widgets/material_bottombar.dart';

const _globalType = NType.materialBottomBar;

/// Intrinsic States of Material BottomBar
final materialBottomBarIntrinsicStates = IntrinsicStates(
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
  maxChildren: 3,
  canHave: ChildrenEnum.children,
  addChildLabels: [
    'Add Leading',
    'Add Title',
    'Add Trailing',
  ],
  gestures: [],
  permissions: [],
  packages: [],
);

/// ```dart
/// BottomNavigationBar({
/// Key? key,
/// required List<BottomNavigationBarItem> items,
///  ValueChanged<int>? onTap,
///  int currentIndex,
/// double? elevation,
/// BottomNavigationBarType? type,
///  Color? fixedColor,
///  Color? backgroundColor,
/// double iconSize,
/// Color? selectedItemColor,
///  Color? unselectedItemColor,
/// IconThemeData? selectedIconTheme,
/// IconThemeData? unselectedIconTheme,
/// double selectedFontSize,
/// double unselectedFontSize,
/// TextStyle? selectedLabelStyle,
///  TextStyle? unselectedLabelStyle,
///  bool? showSelectedLabels,
/// bool? showUnselectedLabels,
///  MouseCursor? mouseCursor,
/// bool? enableFeedback
/// })
/// ```
class MaterialBottomBarBody extends NodeBody {
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
      WMaterialBottomBar(
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
      Future.value('');
}
