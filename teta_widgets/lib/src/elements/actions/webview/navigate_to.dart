// Flutter imports:
// ignore_for_file: public_member_api_docs

// Package imports:
import 'package:collection/collection.dart';
// Flutter imports:
import 'package:flutter/material.dart';
import 'package:recase/recase.dart';
import 'package:teta_cms/teta_cms.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/actions/snippets/get_page_on_code.dart';
// Project imports:
import 'package:teta_widgets/src/elements/actions/snippets/take_state_from.dart';
import 'package:teta_widgets/src/elements/index.dart';
import 'package:webviewx/webviewx.dart';

class FActionWebViewNavigateTo {
  static Future action({
    required final BuildContext context,
    required final List<VariableObject> params,
    required final List<VariableObject> states,
    required final List<DatasetObject> datasets,
    required final String? stateName,
    required final FTextTypeInput valueToChangeWith,
    required final int loop,
  }) async {
    final variable =
        states.firstWhereOrNull((final element) => element.name == stateName);
    TetaCMS.log('webview controller: ${variable?.webViewController}');
    if (variable?.webViewController != null) {
      final url = valueToChangeWith.get(params, states, datasets, true, loop);
      TetaCMS.log('webview navigate to: $url');
      await variable?.webViewController?.loadContent(url, SourceType.url);
    }
  }

  static String toCode(
    final int pageId,
    final BuildContext context,
    final String? stateName,
    final FTextTypeInput valueToChangeWith,
    final int loop,
  ) {
    final page = getPageOnToCode(pageId, context);
    if (page == null) return '';
    final variable = takeStateFrom(page, '$stateName');
    if (variable == null || stateName == null) return '';

    final varName = ReCase(stateName).camelCase;

    return '''
    if ($varName != null) { 
      final url = ${valueToChangeWith.toCode(loop)};
      $varName.loadContent(url, SourceType.url);
    }''';
  }
}
