// Flutter imports:
// ignore_for_file: avoid_dynamic_calls

// Package imports:
// Flutter imports:
import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recase/recase.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/index.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Component Template
String componentCodeTemplate(
  final BuildContext context,
  final NodeBody body,
  final List<CNode> children,
  final int pageId,
) {
  final projectLoaded =
      BlocProvider.of<FocusProjectBloc>(context).state as ProjectLoaded;

  //this fix an error of badstate
  if (body.attributes[DBKeys.componentName] == null ||
      (projectLoaded.prj.pages ?? <PageObject>[]).indexWhere(
            (final element) =>
                element.name == body.attributes[DBKeys.componentName],
          ) ==
          -1) return '';

  final compWidget = projectLoaded.prj.pages!.firstWhere(
    (final element) => element.name == body.attributes[DBKeys.componentName],
  );

  if (compWidget.isHardCoded) {
    final pageName = body.attributes[DBKeys.componentName] as String;
    final temp = removeDiacritics(
      pageName
          .replaceFirst('0', 'A0')
          .replaceFirst('1', 'A1')
          .replaceFirst('2', 'A2')
          .replaceFirst('3', 'A3')
          .replaceFirst('4', 'A4')
          .replaceFirst('5', 'A5')
          .replaceFirst('6', 'A6')
          .replaceFirst('7', 'A7')
          .replaceFirst('8', 'A8')
          .replaceFirst('9', 'A9')
          .replaceAll(' ', '')
          .replaceAll("'", '')
          .replaceAll('"', ''),
    );
    final pageNameRC = ReCase(temp);
    //params
    final stringParamsToSend = StringBuffer()..write('');
    for (final param in compWidget.params) {
      final name = ReCase(param.name);
      stringParamsToSend.write('${name.camelCase}: ');
      final rc = ReCase(param.value.toString());
      stringParamsToSend.write(" '${rc.camelCase}', ");
    }
    return '${pageNameRC.pascalCase}(${stringParamsToSend.toString()})';
  } else {
    //here we are in the Visual Component
    //checks for Page Name
    final pageName = body.attributes[DBKeys.componentName] as String;
    final paramsToSend =
        body.attributes[DBKeys.paramsToSend] as Map<String, dynamic>?;
    final temp = removeDiacritics(
      pageName
          .replaceFirst('0', 'A0')
          .replaceFirst('1', 'A1')
          .replaceFirst('2', 'A2')
          .replaceFirst('3', 'A3')
          .replaceFirst('4', 'A4')
          .replaceFirst('5', 'A5')
          .replaceFirst('6', 'A6')
          .replaceFirst('7', 'A7')
          .replaceFirst('8', 'A8')
          .replaceFirst('9', 'A9')
          .replaceAll(' ', '')
          .replaceAll("'", '')
          .replaceAll('"', ''),
    );
    final pageNameRC = ReCase(temp);
    //params
    final parametersString = StringBuffer()..write('');
    final stringParamsToSend = StringBuffer()..write('');
    for (final param in compWidget.params) {
      if ("${paramsToSend?[param.id]?['dataset']}" == 'States' ||
          "${paramsToSend?[param.id]?['dataset']}" == 'Params') {
        final valueToSend = (paramsToSend ?? <String, dynamic>{})[param.id]
                ?['label'] as String? ??
            'null';
        if (valueToSend != 'null') {
          final name = ReCase(param.name);
          stringParamsToSend.write('${name.camelCase}: ');
          final rc = ReCase(valueToSend);
          stringParamsToSend.write('${rc.camelCase}, ');
        }
      }
      if ("${paramsToSend?[param.id]?['dataset']}" == 'Text') {
        final name = ReCase(param.name);
        stringParamsToSend.write('${name.camelCase}: ');
        final valueToSend = "'''${paramsToSend?[param.id]?['label']}'''";
        stringParamsToSend.write('$valueToSend, ');
      } else {
        final name = ReCase(param.name);
        stringParamsToSend.write('${name.camelCase}: ');
        final valueToSend =
            "datasets['${paramsToSend?[param.id]?['dataset']}']?[index]?['${paramsToSend?[param.id]?['label']}'] ?? ''";
        stringParamsToSend.write('$valueToSend, ');
      }
    }
    return 'Page${pageNameRC.pascalCase}(${stringParamsToSend.toString()})';
  }
}

String prepareParamsForUi(final PageObject page, final NodeBody body) {
  final stringParamsToSend = StringBuffer()..write('');
  for (final param in page.params) {
    final valueToSend = (body.attributes[DBKeys.paramsToSend] ??
            <String, dynamic>{})[param.id]?['label'] as String? ??
        'null';
    if (valueToSend != 'null') {
      final name = ReCase(param.name);
      stringParamsToSend.write('${name.camelCase}: ');
      if (body.attributes[DBKeys.paramsToSend][param.id]?['dataset']
                  as String ==
              'States' ||
          body.attributes[DBKeys.paramsToSend][param.id]?['dataset']
                  as String ==
              'Params') {
        final rc = ReCase(valueToSend);
        stringParamsToSend.write('${rc.camelCase}, ');
      } else if (body.attributes[DBKeys.paramsToSend][param.id]?['dataset']
              as String ==
          'Text') {
        final rc = ReCase(valueToSend);
        stringParamsToSend.write("'${rc.camelCase}', ");
      } else {
        final rc = ReCase(valueToSend);
        stringParamsToSend.write("datasets['${rc.camelCase}'], ");
      }
    }
  }
  return stringParamsToSend.toString();
}
