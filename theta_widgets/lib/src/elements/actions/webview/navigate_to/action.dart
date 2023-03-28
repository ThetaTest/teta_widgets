import 'package:dart_airtable/dart_airtable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recase/recase.dart';
import 'package:teta_cms/teta_cms.dart';
import 'package:teta_front_end/teta_front_end.dart';
import 'package:webviewx/webviewx.dart';

import '../../../../core/teta_action/index.dart';
import '../../../../core/teta_widget/index.dart';
import '../../../features/text_type_input.dart';
import '../../snippets/get_page_on_code.dart';
import '../../snippets/take_state_from.dart';
import 'params.dart';

class TAWebViewNavigateTo extends TetaAction {
  TAWebViewNavigateTo({
    required super.params,
    super.loop,
    super.condition,
    super.delay,
    super.id,
  });

  TAWebViewNavigateTo.fromJson(
    final Map<String, dynamic> json,
  ) : super(
          params: TAWebViewNavigateToParams.fromJson(
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
  TAWebViewNavigateToParams get params =>
      super.params as TAWebViewNavigateToParams;

  @override
  TetaActionType get type => TetaActionType.webViewNavigateTo;

  @override
  Future<void> execute(
    final BuildContext context,
    final TetaWidgetState state, {
    final String? runtimeValue,
  }) async {
    final pageLoaded = context.read<PageCubit>().state as PageLoaded;
    final variable = pageLoaded.states.firstWhereOrNull(
      (final element) => element.name == params.stateName,
    );
    TetaCMS.log('webview controller: ${variable?.webViewController}');
    if (variable?.webViewController != null && params.url != null) {
      final url = params.url!.get(
        state.params,
        state.states,
        state.dataset,
        true,
        state.loop,
        context,
      );
      await variable?.webViewController?.loadContent(url, SourceType.url);
    }
  }

  @override
  String getActionCode(
    final BuildContext context,
    final int pageId,
    final int loop,
  ) {
    final page = getPageOnToCode(pageId, context);
    final variable = takeStateFrom(page, '${params.stateName}');
    if (variable == null || params.stateName == null || params.url == null) {
      return '';
    }

    final varName = ReCase(params.stateName!).camelCase;

    return '''
    if ($varName != null) { 
      final url = ${params.url!.toCode(
      loop,
      resultType: ResultTypeEnum.string,
    )};
      $varName.loadContent(url, SourceType.url);
    }''';
  }
}
