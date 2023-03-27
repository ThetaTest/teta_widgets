import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../core/teta_action/index.dart';
import '../../../../core/teta_widget/index.dart';
import '../../../features/text_type_input.dart';
import 'params.dart';

class TANavigationLaunchUrl extends TetaAction {
  TANavigationLaunchUrl({
    required super.params,
    super.loop,
    super.condition,
    super.delay,
    super.id,
  });

  TANavigationLaunchUrl.fromJson(
    final Map<String, dynamic> json,
  ) : super(
          params: TANavigationLaunchUrlParams.fromJson(
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
  TANavigationLaunchUrlParams get params =>
      super.params as TANavigationLaunchUrlParams;

  @override
  TetaActionType get type => TetaActionType.navigationLaunchUrl;

  @override
  Future<void> execute(
    final BuildContext context,
    final TetaWidgetState state, {
    final String? runtimeValue,
  }) async {
    final valueCode = params.value?.get(
          state.params,
          state.states,
          state.dataset,
          true,
          state.loop,
          context,
        ) ??
        '';
    if (await canLaunchUrlString(valueCode)) {
      await launchUrlString(
        valueCode,
        mode: LaunchMode.inAppWebView,
      );
    }
  }

  @override
  String getActionCode(
    final BuildContext context,
    final int pageId,
    final int loop,
  ) {
    final code = params.value?.toCode(
          loop,
          resultType: ResultTypeEnum.string,
        ) ??
        '';
    return '''
    if (await canLaunchUrlString($code)) {
      await launchUrlString(
        $code,
        mode: LaunchMode.inAppWebView,
      );
    }
    ''';
  }
}
