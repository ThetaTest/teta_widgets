// Flutter imports:
// ignore_for_file: avoid_dynamic_calls

// Package imports:
import 'package:diacritic/diacritic.dart';
// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recase/recase.dart';
import 'package:teta_core/src/blocs/focus_project/index.dart';
import 'package:teta_core/src/models/page.dart';
// Project imports:
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Component Template
String componentCodeTemplate(
  final BuildContext context,
  final NodeBody body,
  final List<CNode> children,
) {
  final prj = BlocProvider.of<FocusProjectBloc>(context).state as ProjectLoaded;
  if (body.attributes[DBKeys.componentName] == null ||
      (prj.prj.pages ?? <PageObject>[]).indexWhere(
            (final element) =>
                element.name == body.attributes[DBKeys.componentName],
          ) ==
          -1) return '';
  final page = prj.prj.pages!.firstWhere(
    (final element) => element.name == body.attributes[DBKeys.componentName],
  );
  final temp = removeDiacritics(
    page.name
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
  final realPageName = 'Component${pageNameRC.camelCase}';

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

  return '''
    $realPageName(
      ${stringParamsToSend.toString()}
    )
    ''';
}
