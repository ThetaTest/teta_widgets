// Flutter imports:
// ignore_for_file: avoid_dynamic_calls

// Package imports:
// Flutter imports:
import 'package:diacritic/diacritic.dart';
import 'package:collection/collection.dart';
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
  String? toReturn = '';

  final projectLoaded =
      BlocProvider.of<FocusProjectBloc>(context).state as ProjectLoaded;
  //!this fix an error of badstate
  if (body.attributes[DBKeys.componentName] == null ||
      (projectLoaded.prj.pages ?? <PageObject>[]).indexWhere(
            (final element) =>
                element.name == body.attributes[DBKeys.componentName],
          ) ==
          -1) return '';

  final compWidget = projectLoaded.prj.pages!.firstWhere(
    (final element) => element.name == body.attributes[DBKeys.componentName],
  );
  //todo:external parameters implementation
  //used to prepare parmas in uri for loading url?
  //prepareParamsForUi(compWidget, body);
  if (compWidget.isHardCoded) {
    //? here we are in the code component part
    if (compWidget.code != null) {
      //this regex is user to pick from the first return it encounter and the last ';' of the custom code component
      //this take the material app if present and remove all untill the scaffold
      final data = RegExp('return (.*);', dotAll: true)
          .allMatches(compWidget.code.toString())
          .first
          .group(1);
      //here we have the material app as a father of the code
      if (data!.contains('home')) {
        //this regex take from scaffold and go untill he find home and remove the scaffold untill he finds the child
        //and remove the last ')' in order to be built well with the CS.children snippet
        final finalString = RegExp(r'home: (.*),.+\)', dotAll: true)
            .allMatches(data)
            .first
            .group(1);
        //if the second regex works, he finds a scaffold and remove it
        if (finalString != null) {
          toReturn = finalString;
        }
      }
      //if we are here the scaffold was not finded, so it takes the code
      else {
        toReturn = data;
      }
    } else {
      //!this will be never called, if it's called something is wrong
      toReturn = '';
    }
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
      final rc = ReCase(param.name);
      var value = param.typeDeclaration(rc.camelCase) == 'String'
          ? "'${param.get}'"
          : param.firstValueForInitialization();
      final valueToSend = (paramsToSend ?? <String, dynamic>{})[param.id]
              ?['label'] as String? ??
          'null';
      Logger.printWarning(valueToSend);
      if (valueToSend != 'null') {
        final rc = ReCase(valueToSend);
        stringParamsToSend.write('${rc.camelCase}, ');
        value = rc.camelCase;
      }
      parametersString.write('${rc.camelCase}: $value,');
    }

    // final stringParamsToSend = StringBuffer()..write('');
    // for (final param in compWidget.params) {
    //   final valueToSend = (paramsToSend ?? <String, dynamic>{})[param.id]
    //           ?['label'] as String? ??
    //       'null';
    //   if (valueToSend != 'null') {
    //     final name = ReCase(param.name);
    //     stringParamsToSend.write('${name.camelCase}: ');
    //     final rc = ReCase(valueToSend);
    //     stringParamsToSend.write('${rc.camelCase}, ');
    //   }
    // }
    //end params

    return 'Page${pageNameRC.pascalCase}(${parametersString.toString()})';
    //here im in a 'Sections' template, visual component already made
    /*else if (compWidget.runUrl == null &&
        compWidget.code == null &&
        compWidget.isPrimary == false &&
        compWidget.isPage == false &&
        compWidget.isHardCoded == false) {
      final finalSectionTemplateCode = StringBuffer()..write('');
      if (compWidget.scaffold != null &&
          compWidget.scaffold!.children!.isNotEmpty) {
        for (final item in compWidget.scaffold!.children!) {
          finalSectionTemplateCode.write(item.toCode(context));
        }
        toReturn = finalSectionTemplateCode.toString();
      }
    }
    //here im in a 'Visual' component made by user with his chicken brain
    else {
      final finalCode = StringBuffer()..write('');
      //take only the first node that will be always a scaffold if we are here in a visual
      //component. From first node take all the children in order to call the method tocode on each of his children.
      if (compWidget.flatList![0].globalType == NType.scaffold) {
        for (final item in compWidget.flatList![0].children!) {
          finalCode.write(item.toCode(context));
        }
        toReturn = finalCode.toString();
      }
    }*/
  }

  return toReturn;

  // final temp = removeDiacritics(
  //   page.name
  //       .replaceFirst('0', 'A0')
  //       .replaceFirst('1', 'A1')
  //       .replaceFirst('2', 'A2')
  //       .replaceFirst('3', 'A3')
  //       .replaceFirst('4', 'A4')
  //       .replaceFirst('5', 'A5')
  //       .replaceFirst('6', 'A6')
  //       .replaceFirst('7', 'A7')
  //       .replaceFirst('8', 'A8')
  //       .replaceFirst('9', 'A9')
  //       .replaceAll(' ', '')
  //       .replaceAll("'", '')
  //       .replaceAll('"', ''),
  // );
  // final pageNameRC = ReCase(temp);
  // final realPageName = 'Component${pageNameRC.camelCase}';
  // return '''
  //   $realPageName(
  //     ${stringParamsToSend.toString()}
  //   )
  //   ''';
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
