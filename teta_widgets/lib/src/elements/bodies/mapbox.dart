// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/gen/assets.gen.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
import 'package:teta_widgets/src/elements/code/snippets.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/templates/map.dart';
import 'package:teta_widgets/src/elements/controls/control_model.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/features/action.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/index.dart';
import 'package:teta_widgets/src/elements/features/actions/enums/permissions.dart';
import 'package:teta_widgets/src/elements/features/box_fit.dart';
import 'package:teta_widgets/src/elements/features/fill.dart';
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
import 'package:teta_widgets/src/elements/widgets/mapbox.dart';

const _globalType = NType.mapBox;

/// Intrinsic States of Map
final mapBoxIntrinsicStates = IntrinsicStates(
  nodeIcon: Assets.wIcons.box,
  nodeVideo: null,
  nodeDescription: null,
  advicedChildren: [],
  blockedTypes: [],
  synonymous: ['map'],
  advicedChildrenCanHaveAtLeastAChild: [],
  displayName: NodeType.name(_globalType),
  type: _globalType,
  category: NodeCategories.unclassified,
  maxChildren: null,
  canHave: ChildrenEnum.children,
  addChildLabels: [],
  gestures: [
    ActionGesture.onDoubleTap,
  ],
  permissions: [
    Permissions.location,
  ],
  packages: [pMap, pLatLang],
  suggestionsTitle: 'Why use Map in Teta?',
  suggestions: [
    const Suggestion(
      title: 'Why use Map in Teta?',
      description: 'Test',
      linkToOpen: 'https://docs.teta.so/teta-docs/widget/map-widgets/map',
    )
  ],
);

/// Body of Map
class MapBoxBody extends NodeBody {
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
    DBKeys.boxFit: FBoxFit(),
    DBKeys.value: FTextTypeInput(),
    DBKeys.latitude: FTextTypeInput(),
    DBKeys.longitude: FTextTypeInput(),
    DBKeys.action: FAction(),
    DBKeys.fill: FFill(),
  };

  @override
  List<ControlModel> get controls => [];

  @override
  Widget toWidget({
    required final TetaWidgetState state,
    final CNode? child,
    final List<CNode>? children,
  }) =>
      WMapBox(
        const ValueKey('MapBox'),
        state: state,
        children: children ?? [],
        width: attributes[DBKeys.width] as FSize,
        height: attributes[DBKeys.height] as FSize,
        boxFit: attributes[DBKeys.boxFit] as FBoxFit,
        latitude: attributes[DBKeys.latitude] as FTextTypeInput,
        longitude: attributes[DBKeys.longitude] as FTextTypeInput,
        action: attributes[DBKeys.action] as FAction,
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
        MapCodeTemplate.toCode(
          context,
          this,
          node,
          child,
          children ?? [],
          loop,
        ),
        loop ?? 0,
      );
}
