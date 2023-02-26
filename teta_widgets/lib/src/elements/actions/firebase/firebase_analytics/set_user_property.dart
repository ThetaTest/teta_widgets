// Flutter imports:
// ignore_for_file: lines_longer_than_80_chars

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
import 'package:teta_widgets/src/elements/index.dart';

class FActionFirebaseAnalyticsSetUserProperty {
  static Future action(
    final BuildContext context,
    final TetaWidgetState state,
    final String? stateName,
    final FTextTypeInput? firebaseAnalyticsName,
    final FTextTypeInput? firebaseAnalyticsValue,
  ) async {
    await showDialog<void>(
      context: context,
      builder: (final context) {
        return const AlertDialog(
          title: TAlertTitle('Firebase Analytics'),
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 20,
          ),
          backgroundColor: Color(0xFF333333),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          content: SizedBox(
            width: 400,
            height: 400,
            child: Text(
              '(Firebase Analytics- Set User Property) will be activated in your released app.',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }

  static String toCode(
    final BuildContext context,
    final String? stateName,
    final int pageId,
    final int loop,
    final FTextTypeInput? firebaseAnalyticsName,
    final FTextTypeInput? firebaseAnalyticsValue,
  ) {
    final firebaseAnalyticsNameNew = firebaseAnalyticsName
        ?.toCode(
          loop,
          resultType: ResultTypeEnum.string,
        )
        .replaceAll(' ', '');
    final firebaseAnalyticsValueNew = firebaseAnalyticsValue
        ?.toCode(
          loop,
          resultType: ResultTypeEnum.string,
        )
        .replaceAll(' ', '');

    return '''
    await FirebaseAnalytics.instance.setUserProperty(
     name: $firebaseAnalyticsNameNew,
      value: $firebaseAnalyticsValueNew,);
    ''';
  }
}