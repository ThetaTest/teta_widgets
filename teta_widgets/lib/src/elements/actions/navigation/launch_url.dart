// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recase/recase.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/actions/snippets/take_state_from.dart';
// Package imports:
import 'package:url_launcher/url_launcher_string.dart';

class FActionNavigationLaunchURL {
  static Future action(
    final BuildContext context,
    final List<VariableObject> states,
    final String? stateName,
  ) async {
    final index =
        states.indexWhere((final element) => element.name == stateName);
    if (await canLaunchUrlString('${states[index].get}')) {
      await launchUrlString(
        '${states[index].get}',
        mode: LaunchMode.inAppWebView,
      );
    }
  }

  static String toCode(
    final BuildContext context,
    final String? stateName,
  ) {
    final page = BlocProvider.of<FocusPageBloc>(context).state;
    final variable = takeStateFrom(page, '$stateName');
    if (variable == null || stateName == null) return '';

    final varName = ReCase(stateName).camelCase;

    final buffer = StringBuffer()..write('');
    return """
    if (await canLaunchUrlString('''\${$varName}''')) {
      await launchUrlString(
        '''\${$varName}''',
        mode: LaunchMode.inAppWebView,
      );
    }
    """;
  }
}
