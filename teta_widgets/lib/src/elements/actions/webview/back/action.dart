import 'package:dart_airtable/dart_airtable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recase/recase.dart';
import 'package:teta_front_end/teta_front_end.dart';

import '../../../../core/teta_action/index.dart';
import '../../../../core/teta_widget/index.dart';
import '../../snippets/get_page_on_code.dart';
import '../../snippets/take_state_from.dart';
import 'params.dart';

class TAWebViewGoBack extends TetaAction {
  TAWebViewGoBack({
    required super.params,
    super.loop,
    super.condition,
    super.delay,
    super.id,
  });

  TAWebViewGoBack.fromJson(
    final Map<String, dynamic> json,
  ) : super(
          params: TAWebViewGoBackParams.fromJson(
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
  TAWebViewGoBackParams get params => super.params as TAWebViewGoBackParams;

  @override
  TetaActionType get type => TetaActionType.webViewGoBack;

  @override
  Future<void> execute(
    final BuildContext context,
    final TetaWidgetState state, {
    final String? runtimeValue,
  }) async {
    final pageLoaded = context.read<PageCubit>().state as PageLoaded;
    final variable = pageLoaded.states
        .firstWhereOrNull((final element) => element.name == params.stateName);
    if (variable?.webViewController != null) {
      final flag = await variable?.webViewController?.canGoBack();
      if (flag ?? false) {
        await variable?.webViewController?.goBack();
      }
    }
  }

  @override
  String getActionCode(
    final BuildContext context,
    final int pageId,
    final int loop,
  ) {
    final page = getPageOnToCode(pageId, context);
    if (page == null) return '';
    final variable = takeStateFrom(page, '${params.stateName}');
    if (variable == null || params.stateName == null) return '';

    final varName = ReCase(params.stateName!).camelCase;

    return '''
    if ($varName != null) { 
      final flag = await $varName.canGoBack();
      if (flag ?? false) {
      $varName.goBack();
      }
    }''';
  }
}
