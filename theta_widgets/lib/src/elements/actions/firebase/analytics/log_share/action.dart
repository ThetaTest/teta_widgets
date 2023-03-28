import 'package:flutter/material.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
import 'package:teta_widgets/src/elements/index.dart';
import 'package:teta_front_end/teta_front_end.dart';

import '../../../../../core/teta_action/index.dart';
import '../../../../../core/teta_widget/teta_widget_state.dart';
import '../../../../features/text_type_input.dart';
import 'params.dart';

class TAFirebaseAnalyticsLogShare extends TetaAction {
  TAFirebaseAnalyticsLogShare({
    required super.params,
    super.loop,
    super.condition,
    super.delay,
    super.id,
  });

  TAFirebaseAnalyticsLogShare.fromJson(
    final Map<String, dynamic> json,
  ) : super(
          params: TAFirebaseAnalyticsLogShareParams.fromJson(
            json['params'] as Map<String, dynamic>,
          ),
          condition: json['condition'] != null
              ? TetaActionCondition.fromJson(
                  json['condition'] as Map<String, dynamic>,
                )
              : null,
          delay: json['delay'] as int? ?? 0,
        );

  @override
  TAFirebaseAnalyticsLogShareParams get params =>
      super.params as TAFirebaseAnalyticsLogShareParams;

  @override
  TetaActionType get type => TetaActionType.firebaseAnalyticsLogShare;

  @override
  Future<void> execute(
    final BuildContext context,
    final TetaWidgetState state, {
    final String? runtimeValue,
  }) async {
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
              '(Firebase Analytics- Log Screen View) will be activated in your released app.',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
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
    final firebaseAnalyticsContentTypeNew = params.firebaseAnalyticsContentType
        ?.toCode(
          loop,
          resultType: ResultTypeEnum.string,
        )
        .replaceAll(' ', '');
    final firebaseAnalyticsItemIdNew = params.firebaseAnalyticsItemId
        ?.toCode(
          loop,
          resultType: ResultTypeEnum.string,
        )
        .replaceAll(' ', '');
    final firebaseAnalyticsMethodNew = params.firebaseAnalyticsMethod
        ?.toCode(
          loop,
          resultType: ResultTypeEnum.string,
        )
        .replaceAll(' ', '');
    return '''
    await FirebaseAnalytics.instance.logShare(
      contentType: $firebaseAnalyticsContentTypeNew,
      itemId: $firebaseAnalyticsItemIdNew,
      method: $firebaseAnalyticsMethodNew,);
    ''';
  }
}
