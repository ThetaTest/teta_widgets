// Flutter imports:
// ignore_for_file: public_member_api_docs, avoid_dynamic_calls

// Package imports:
import 'package:camera/camera.dart';
import 'package:collection/collection.dart';
import 'package:diacritic/diacritic.dart';
// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recase/recase.dart';
import 'package:teta_core/src/rendering/nodes_original.dart';
import 'package:teta_core/src/repositories/queries/node.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/features/page_transition.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:transition/transition.dart' as T;

// ignore: library_prefixes

void goTo(final CNode node, final BuildContext context, final Widget child) {
  if (node.body.attributes[DBKeys.pageTransition] != null) {
    Navigator.push<void>(
      context,
      T.Transition(
        child: child,
        transitionEffect:
            (node.body.attributes[DBKeys.pageTransition] as FPageTransition)
                .transitionEffect!,
      ),
    );
  } else {
    Navigator.push<void>(
      context,
      MaterialPageRoute(
        builder: (final context) => child,
      ),
    );
  }
}

class FActionNavigationOpenPage {
  static Future<void> action(
    final CNode node,
    final BuildContext context,
    final String? nameOfPage,
    final Map<String, dynamic>? paramsToSend,
    final List<VariableObject> params,
    final List<VariableObject> states,
    final List<DatasetObject> dataset,
    final int? loop,
  ) async {
    try {
      final prj =
          BlocProvider.of<FocusProjectBloc>(context).state as ProjectLoaded;
      final currentPage = BlocProvider.of<PageCubit>(context).state;
      PageObject? page;
      page = prj.prj.pages!
          .firstWhereOrNull((final element) => element.name == nameOfPage);
      if (page != null) {
        final list = await NodeQueries.fetchNodesByPage(page.id);
        final nodes = <CNode>[];
        for (final e in list) {
          nodes.add(
            CNode.fromJson(
              e as Map<String, dynamic>,
              page.id,
            ),
          );
        }
        final scaffold = NodeRendering.renderTree(nodes);
        page = page.copyWith(flatList: nodes, scaffold: scaffold);

        await Navigator.push<void>(
          context,
          MaterialPageRoute(
            builder: (final context) => page!.scaffold!.toWidget(
              forPlay: true,
              params: page.params.map((final e) {
                if (paramsToSend?[e.id] != null) {
                  if (paramsToSend?[e.id]['dataset'] == 'Text') {
                    e.value = paramsToSend?[e.id]['label'];
                  } else {
                    final list = <DatasetObject>[
                      DatasetObject(
                        name: 'Parameters',
                        map: currentPage.params
                            .map((final e) => <String, dynamic>{e.name: e.get})
                            .toList(),
                      ),
                      DatasetObject(
                        name: 'States',
                        map: currentPage.states
                            .map((final e) => <String, dynamic>{e.name: e.get})
                            .toList(),
                      ),
                      ...dataset,
                    ];
                    Map<String, dynamic>? selectedDataset;
                    for (final element in list) {
                      if (element.getName == paramsToSend?[e.id]['dataset']) {
                        selectedDataset = <String, dynamic>{
                          'name': element.getName,
                          'map': element.getMap
                        };
                      }
                    }
                    VariableObject? variable;
                    if (selectedDataset?['name'] == 'Parameters' ||
                        selectedDataset?['name'] == 'States') {
                      final map =
                          selectedDataset!['map'] as List<Map<String, dynamic>>;
                      //final element = map[loop ?? 0];
                      for (final element in map) {
                        if (element.keys.toList()[loop ?? 0] ==
                            paramsToSend?[e.id]?['label']) {
                          if (element[element.keys.toList()[loop ?? 0]]
                              is String) {
                            variable = VariableObject(
                              name: element.keys.toList()[loop ?? 0],
                              value: element[element.keys.toList()[loop ?? 0]],
                            );
                          }
                          if (element[element.keys.toList()[loop ?? 0]]
                              is CameraController) {
                            variable = VariableObject(
                              name: element.keys.toList()[loop ?? 0],
                              type: VariableType.cameraController,
                              controller:
                                  element[element.keys.toList()[loop ?? 0]]
                                      as CameraController,
                            );
                          }
                          if (element[element.keys.toList()[loop ?? 0]]
                              is XFile) {
                            debugPrint('is XFile');
                            variable = VariableObject(
                              name: element.keys.toList()[loop ?? 0],
                              type: VariableType.file,
                              file: element[element.keys.toList()[loop ?? 0]]
                                  as XFile,
                            );
                          }
                        }
                      }
                    } else {
                      final el =
                          selectedDataset!['map'] as List<Map<String, dynamic>>;
                      final map = el[loop ?? 0];
                      for (final key in map.keys) {
                        if (key == paramsToSend?[e.id]?['label']) {
                          variable = VariableObject(name: key, value: map[key]);
                        }
                      }
                    }
                    if (variable != null) {
                      e
                        ..value = variable.get
                        ..file = variable.file
                        ..controller = variable.controller;
                    }
                  }
                  return e;
                }
                return e;
              }).toList(),
              states: page.states,
              dataset: page.datasets,
            ),
          ),
        );
      }
    } catch (e) {
      if (kDebugMode) {
        // ignore: avoid_print
        print(e);
      }
    }
  }

  static String toCode(
    final BuildContext context,
    final String? nameOfPage,
    final Map<String, dynamic>? paramsToSend,
  ) {
    final prj =
        BlocProvider.of<FocusProjectBloc>(context).state as ProjectLoaded;
    if (nameOfPage == null ||
        (prj.prj.pages ?? <PageObject>[])
                .indexWhere((final element) => element.name == nameOfPage) ==
            -1) return '';
    final page = prj.prj.pages!
        .firstWhere((final element) => element.name == nameOfPage);
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

    final stringParamsToSend = StringBuffer()..write('');
    for (final param in page.params) {
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
      } else {
        final name = ReCase(param.name);
        stringParamsToSend.write('${name.camelCase}: ');
        final valueToSend =
            "datasets['${paramsToSend?[param.id]?['dataset']}']?[index]?['${paramsToSend?[param.id]?['label']}'] ?? ''";
        stringParamsToSend.write('$valueToSend, ');
      }
    }

    return '''
    await Navigator.push<void>(
      context,
      MaterialPageRoute(
        builder: (context) => Page${pageNameRC.pascalCase}(
          ${stringParamsToSend.toString()}
        ),
      ),
    );
    ''';

    /*
    final page =
        prj.prj.pages!.firstWhere((element) => element.name == nameOfPage);
    final params = page.scaffold!.params ?? [];
    final paramsString = StringBuffer()..write('');
    params.forEach((element) {
      paramsString.write('${element.name}');
    });
    final realPageName = "Page${nameOfPage!.replaceAll(RegExp(r' '), "")}";*/

    /*String stringParamsToSend = '';
    if (paramsToSend != null) {
      paramsToSend.keys.forEach((key) {
        String keyString = '{"$key":';
        String value = ' {';
        final list = paramsToSend[key] as Map<String, dynamic>;
        (list.keys as List<String>).forEach((key) {
          value += '"$key": "${list[key]}", ';
        });
        value += '}';
        keyString += '$value}';
        stringParamsToSend += keyString;
      });
    }

    //final finalParams = params.forEach((element) { })*/

    /*return '''
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => $realPageName(
          ${params.toString()}
        ),
      ),
    );
    ''';*/

    /*return """
      final pageParams = [$paramsString];
      final Map<String, dynamic> paramsToSend = $stringParamsToSend;
      final finalParams = pageParams.map((e) {
        if (paramsToSend["\${e.id}"] != null) {
          final List<DatasetObject> list = [
            DatasetObject(
              name: "Parameters",
              map: params
                  .map((e) => {"\${e.name}": e.get})
                  .toList(),
            ),
            DatasetObject(
              name: "States",
              map: states
                  .map((e) => {"\${e.name}": e.get})
                  .toList(),
            ),
            ...dataset,
          ];
          Map<String, dynamic>? selectedDataset;
          list.forEach((element) {
            if (element.name == paramsToSend["\${e.id}"]["dataset"])
              selectedDataset = {"name": element.name, "map": element.map};
          });
          VariableObject? variable;
          final List<Map<String, dynamic>> map = selectedDataset!["map"];
          final element = map[loop ?? 0];
          element.keys.forEach((key) {
            print(key);
            if (key == paramsToSend["\${e.id}"]["label"]) {
              variable = VariableObject(name: key, value: element[key]);
            }
          });

          print(
              "variable: \${variable?.name} \${variable?.value} \${variable?.defaultValue}");
          if (variable != null) {
            e.value = (variable!.value != null && variable!.value != '')
                ? variable!.value
                : variable!.defaultValue;
          }
          return e;
        }
      }).toList() as List<VariableObject>;
    
      
    """;*/
  }
}
