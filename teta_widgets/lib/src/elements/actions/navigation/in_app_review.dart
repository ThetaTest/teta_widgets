// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:teta_core/teta_core.dart';

class FActionNavigationInAppReview {
  static Future action(final BuildContext context) async {
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

  static String toCode() {
    return '''
final InAppReview inAppReview = InAppReview.instance;

if (await inAppReview.isAvailable()) {
    inAppReview.requestReview();
}''';
  }
}
