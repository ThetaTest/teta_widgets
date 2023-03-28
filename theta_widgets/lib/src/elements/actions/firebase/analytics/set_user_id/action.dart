import 'package:flutter/material.dart';
import 'package:teta_front_end/teta_front_end.dart';

import '../../../../../core/teta_action/index.dart';
import '../../../../../core/teta_widget/teta_widget_state.dart';
import '../../../../features/text_type_input.dart';
import 'params.dart';

class TAFirebaseAnalyticsSetUserId extends TetaAction {
  TAFirebaseAnalyticsSetUserId({
    required super.params,
    super.loop,
    super.condition,
    super.delay,
    super.id,
  });

  TAFirebaseAnalyticsSetUserId.fromJson(
    final Map<String, dynamic> json,
  ) : super(
          params: TAFirebaseAnalyticsSetUserIdParams.fromJson(
            json['params'] as Map<String, dynamic>,
          ),
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
  TAFirebaseAnalyticsSetUserIdParams get params =>
      super.params as TAFirebaseAnalyticsSetUserIdParams;

  @override
  TetaActionType get type => TetaActionType.firebaseAnalyticsSetUserId;

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
              '(Firebase Analytics- Set User Id) will be activated in your released app.',
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
    final firebaseAnalyticsUserIdNew = params.firebaseAnalyticsUserId
        ?.toCode(
          loop,
          resultType: ResultTypeEnum.string,
        )
        .replaceAll(' ', '');

    return '''
    await FirebaseAnalytics.instance.setUserId(
    id: $firebaseAnalyticsUserIdNew,
    );
    ''';
  }
}
