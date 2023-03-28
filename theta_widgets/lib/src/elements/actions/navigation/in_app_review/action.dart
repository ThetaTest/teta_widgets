import 'package:flutter/material.dart';
import 'package:teta_front_end/teta_front_end.dart';

import '../../../../core/teta_action/index.dart';
import '../../../../core/teta_widget/index.dart';
import 'params.dart';

class TANavigationInAppReview extends TetaAction {
  TANavigationInAppReview({
    required super.params,
    super.loop,
    super.condition,
    super.delay,
    super.id,
  });

  TANavigationInAppReview.fromJson(
    final Map<String, dynamic> json,
  ) : super(
          params: const TANavigationInAppReviewParams(),
          loop: json['loop'] != null
              ? TetaActionLoop.fromJson(json['loop'] as Map<String, dynamic>)
              : null,
          condition: json['condition'] != null
              ? TetaActionCondition.fromJson(
                  json['condition'] as Map<String, dynamic>,
                )
              : null,
          delay: json['delay'] as int? ?? 0,
        );

  @override
  TANavigationInAppReviewParams get params =>
      super.params as TANavigationInAppReviewParams;

  @override
  TetaActionType get type => TetaActionType.navigationInAppReview;

  @override
  Future<void> execute(
    final BuildContext context,
    final TetaWidgetState state, {
    final String? runtimeValue,
  }) async {
    await showDialog<void>(
      context: context,
      builder: (final context) {
        return AlertDialog(
          title: const TAlertTitle('In App Review'),
          backgroundColor: Palette.bgDialog,
          content: const TParagraph(
            'In App Review will be activated in your released app.',
          ),
        );
      },
    );
  }

  @override
  String getActionCode(
    final BuildContext context,
    final int pageId,
    final int loop,
  ) {
    return '''
      final InAppReview inAppReview = InAppReview.instance;
      if (await inAppReview.isAvailable()) {
          inAppReview.requestReview();
      }
    ''';
  }
}
