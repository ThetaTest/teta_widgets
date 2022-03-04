// Flutter imports:
// ignore_for_file: public_member_api_docs
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recase/recase.dart';
// Project imports:
import 'package:teta_core/src/blocs/focus_project/index.dart';
import 'package:teta_core/src/models/page.dart';
import 'package:teta_core/src/models/variable.dart';
import 'package:teta_widgets/src/elements/actions/snippets/update.dart';

class FActionNavigationOpenDatePicker {
  static Future action(
    BuildContext context,
    List<VariableObject> states,
    String? stateName,
    int? loop,
  ) async {
    final index = states.indexWhere((element) => element.name == stateName);
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    states[index].value = '${picked?.toIso8601String()}';
    update(context);
  }

  static String toCode(
    BuildContext context,
    String? nameOfPage,
    Map<String, dynamic>? paramsToSend,
  ) {
    try {
      final prj =
          BlocProvider.of<FocusProjectBloc>(context).state as ProjectLoaded;
      if (nameOfPage == null ||
          (prj.prj.pages ?? <PageObject>[])
                  .indexWhere((element) => element.name == nameOfPage) ==
              -1) return '';
      final page =
          prj.prj.pages!.firstWhere((element) => element.name == nameOfPage);
      final realPageName = "Page${nameOfPage.replaceAll(' ', "")}";

      final stringParamsToSend = StringBuffer()..write('');
      for (final param in page.params) {
        final name = ReCase(param.name);
        stringParamsToSend.write('${name.camelCase}: ');
        // ignore: avoid_dynamic_calls
        final valueToSend = (paramsToSend ?? <String, dynamic>{})[param.id]
                ?['label'] as String? ??
            'null';
        final rc = ReCase(valueToSend);
        stringParamsToSend.write('${rc.camelCase}, ');
      }

      return '''
      await showModalBottomSheet<void>(
        context: context,
        builder: (context) => $realPageName(
          ${stringParamsToSend.toString()}
        ),
      );
      ''';
    } catch (e) {
      return '';
    }
  }
}
