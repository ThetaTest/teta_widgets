// Flutter imports:
// ignore_for_file: lines_longer_than_80_chars

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/code/templates/ad_mob_banner_ad_template.dart';
import 'package:teta_widgets/src/elements/controls/control_model.dart';
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/controls/type.dart';
import 'package:teta_widgets/src/elements/index.dart';
import 'package:teta_widgets/src/elements/intrinsic_states/class.dart';
import 'package:teta_widgets/src/elements/nodes/categories.dart';
import 'package:teta_widgets/src/elements/nodes/children_enum.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';
import 'package:teta_widgets/src/elements/nodes/suggestion.dart';
import 'package:teta_widgets/src/elements/packages.dart';
import 'package:teta_widgets/src/elements/widgets/w_google_ad_mob_banner_ad_body.dart';
import 'package:teta_models/src/models/variable.dart';

/// GlobalType for [] widget
const _globalType = NType.adMobBanner;

/// IntrinsicStates for [] widget
final googleAdMobBannerAdIntrinsicStates = IntrinsicStates(
  nodeIcon: Assets.wIcons.admob,
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
  packages: [pGoogleMobileAds, pIO],
  suggestionsTitle: 'Why use Ad mob banner in Teta?',
  suggestions: [
    const Suggestion(
      title: 'Why use Ad mob banner in Teta?',
      description: 'Test',
      linkToOpen:
          'https://docs.teta.so/teta-docs/widget/advanced-widgets/ad-mob-banner',
    )
  ],
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
          valueType: VariableType.string,
        ),
        ControlObject(
          title: 'Android AdMob Ad Unit Key',
          type: ControlType.value,
          key: DBKeys.adMobAdAndroidUnitId,
          value: attributes[DBKeys.adMobAdAndroidUnitId] as FTextTypeInput,
          description: 'The Android AdMob Ad unit key.',
          valueType: VariableType.string,
        ),
      ];

  @override
  Widget toWidget({
    required final TetaWidgetState state,
    final CNode? child,
    final List<CNode>? children,
  }) =>
      WGoogleAdMobBannerAd(
        ValueKey(
          '''
            ${state.toKey}
            ${child ?? children}
            ${(attributes[DBKeys.adMobAdIosUnitId] as FTextTypeInput? ?? FTextTypeInput()).toJson()}
            ${(attributes[DBKeys.adMobAdAndroidUnitId] as FTextTypeInput? ?? FTextTypeInput()).toJson()}
            ''',
        ),
        state: state,
        adMobAdIosUnitId:
            attributes[DBKeys.adMobAdIosUnitId] as FTextTypeInput? ??
                FTextTypeInput(),
        adMobAdAndroidUnitId:
            attributes[DBKeys.adMobAdAndroidUnitId] as FTextTypeInput? ??
                FTextTypeInput(),
      );

  @override
  Future<String> toCode(
    final BuildContext context,
    final CNode node,
    final CNode? child,
    final List<CNode>? children,
    final int pageId,
    final int? loop,
  ) {
    return CS.defaultWidgets(
      context,
      node,
      pageId,
      CS.defaultWidgets(
        context,
        node,
        pageId,
        AdMobBannerAdTemplate.toCode(context, this, loop),
        loop ?? 0,
      ),
      loop ?? 0,
    );
  }
}
