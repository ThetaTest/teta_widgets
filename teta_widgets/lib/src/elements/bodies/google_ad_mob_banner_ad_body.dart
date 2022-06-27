// Flutter imports:
// ignore_for_file: lines_longer_than_80_chars

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/code/templates/ad_mob_banner_ad_template.dart';
import 'package:teta_widgets/src/elements/controls/control_model.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/controls/type.dart';
import 'package:teta_widgets/src/elements/index.dart';
import 'package:teta_widgets/src/elements/intrinsic_states/class.dart';
import 'package:teta_widgets/src/elements/nodes/categories.dart';
import 'package:teta_widgets/src/elements/nodes/children_enum.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';
import 'package:teta_widgets/src/elements/widgets/w_google_ad_mob_banner_ad_body.dart';

/// GlobalType for [] widget
const _globalType = NType.adMobBanner;

/// IntrinsicStates for [] widget
final googleAdMobBannerAdIntrinsicStates = IntrinsicStates(
  nodeIcon: Assets.wIcons.adMob,
  nodeVideo: null,
  nodeDescription: null,
  advicedChildren: [],
  blockedTypes: [],
  synonymous: ['ad', 'AdMob', 'banner'],
  advicedChildrenCanHaveAtLeastAChild: [],
  displayName: NodeType.name(_globalType),
  type: _globalType,
  category: NodeCategories.advanced,
  maxChildren: 0,
  canHave: ChildrenEnum.none,
  addChildLabels: [],
  gestures: [],
  permissions: [],
  packages: ['google_mobile_ads'],
);

/// Body for [] widget
class GoogleAdMobBannerAdBody extends NodeBody {
  @override
  // ignore: overridden_fields
  Map<String, dynamic> attributes = <String, dynamic>{
    DBKeys.adMobAdIosUnitId: FTextTypeInput(value: 'iOS Ad unit Key'),
    DBKeys.adMobAdAndroidUnitId: FTextTypeInput(value: 'Android Ad unit key'),
  };

  @override
  List<ControlModel> get controls => [
        ControlObject(
          title: 'iOS AdMob Ad Unit Key',
          type: ControlType.value,
          key: DBKeys.adMobAdIosUnitId,
          value: attributes[DBKeys.adMobAdIosUnitId] as FTextTypeInput,
          description: 'The iOS ADMob ad unit key.',
        ),
        ControlObject(
          title: 'Android AdMob Ad Unit Key',
          type: ControlType.value,
          key: DBKeys.adMobAdAndroidUnitId,
          value: attributes[DBKeys.adMobAdAndroidUnitId] as FTextTypeInput,
          description: 'The Android AdMob Ad unit key.',
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
      WGoogleAdMobBannerAd(
        ValueKey(
          '''
            ${node.nid}
            $loop
            ${child ?? children}
            ${(attributes[DBKeys.adMobAdIosUnitId] as FTextTypeInput? ?? FTextTypeInput()).toJson()}
            ${(attributes[DBKeys.adMobAdAndroidUnitId] as FTextTypeInput? ?? FTextTypeInput()).toJson()}
            ''',
        ),
        node: node,
        adMobAdIosUnitId:
            attributes[DBKeys.adMobAdIosUnitId] as FTextTypeInput? ??
                FTextTypeInput(),
        adMobAdAndroidUnitId:
            attributes[DBKeys.adMobAdAndroidUnitId] as FTextTypeInput? ??
                FTextTypeInput(),
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
  ) {
    return AdMobBannerAdTemplate.textCodeTemplate(context, this, loop);
  }
}
