// Flutter imports:
// ignore_for_file: public_member_api_docs, avoid_dynamic_calls

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recase/recase.dart';
import 'package:teta_core/src/blocs/focus_project/index.dart';
import 'package:teta_core/src/models/dataset.dart';
import 'package:teta_core/src/models/page.dart';
import 'package:teta_core/src/models/variable.dart';

class FActionNavigationOpenSnackBar {
  static Future action(
    BuildContext context,
    String? nameOfPage,
    Map<String, dynamic>? paramsToSend,
    List<VariableObject> params,
    List<VariableObject> states,
    List<DatasetObject> dataset,
    int? loop,
  ) async {
    try {
      if (nameOfPage != null) {
        final prj =
            BlocProvider.of<FocusProjectBloc>(context).state as ProjectLoaded;
        final page =
            prj.prj.pages!.firstWhere((element) => element.name == nameOfPage);
        final snackBar = SnackBar(
          content: page.scaffold!.toWidget(
            forPlay: true,
            params: page.params,
            states: page.states,
            dataset: page.datasets,
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } catch (e) {
      debugPrint('$e');
    }
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
      final realPageName = "Page${nameOfPage.replaceAll(RegExp(' '), "")}";

      final stringParamsToSend = StringBuffer()..write('');
      for (final param in page.params) {
        final name = ReCase(param.name);
        stringParamsToSend.write('${name.camelCase}: ');
        final valueToSend = (paramsToSend ?? <String, dynamic>{})[param.id]
                ['label'] as String? ??
            'null';
        final rc = ReCase(valueToSend);
        stringParamsToSend.write('${rc.camelCase}, ');
      }

      return '''
      final snackBar = SnackBar(
        content: $realPageName(
          ${stringParamsToSend.toString()}
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      ''';
    } catch (e) {
      return '';
    }
  }
}
