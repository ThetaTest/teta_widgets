// Flutter imports:
// ignore_for_file: public_member_api_docs, avoid_dynamic_calls

// Package imports:
import 'package:collection/collection.dart';
import 'package:diacritic/diacritic.dart';
// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recase/recase.dart';
import 'package:teta_core/src/rendering/nodes.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_db/teta_db.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
import 'package:teta_widgets/src/elements/actions/navigation/pass_params_builder.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';
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
    final BuildContext context,
    final TetaWidgetState state,
    final String? nameOfPage,
    final Map<String, dynamic>? paramsToSend,
  ) async {
    try {
      final prj = BlocProvider.of<FocusProjectCubit>(context).state!;
      final currentPage = BlocProvider.of<PageCubit>(context).state;
      PageObject? page;
      page = prj.pages!
          .firstWhereOrNull((final element) => element.name == nameOfPage);
      if (page != null) {
        final list = await TetaDB.instance.client.selectList(
          'nodes',
          match: <String, dynamic>{
            'page_id': page.id,
          },
        );
        if (list.error != null) {
          Logger.printError(
            'Error fetching nodes FActionNavigationOpenPage func, error: ${list.error?.message}',
          );
        }
        final nodes = <CNode>[];
        for (final e in list.data ?? <dynamic>[]) {
          nodes.add(
            CNode.fromJson(
              e as Map<String, dynamic>,
              page.id,
            ),
          );
        }
        final scaffold = sl.get<NodeRendering>().renderTree(nodes);
        page = page.copyWith(flatList: nodes, scaffold: scaffold);

        BlocProvider.of<PageCubit>(context)
            .onFocus(prj: prj, page: page, context: context);

        await Navigator.push<void>(
          context,
          MaterialPageRoute(
            builder: (final context) => BlocProvider(
              create: (final context) => PageCubit(sl.get())
                ..onFocus(prj: prj, page: page!, context: context),
              child: page!.scaffold!.toWidget(
                state: state.copyWith(
                  forPlay: true,
                  states: page.states,
                  dataset: page.datasets,
                  params: passParamsToNewPage(
                    page.params,
                    currentPage.params,
                    paramsToSend,
                    state.dataset,
                    loop: state.loop,
                  ),
                ),
              ),
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
    final prj = BlocProvider.of<FocusProjectCubit>(context).state!;
    if (nameOfPage == null ||
        (prj.pages ?? <PageObject>[])
                .indexWhere((final element) => element.name == nameOfPage) ==
            -1) return '';
    final page =
        prj.pages!.firstWhere((final element) => element.name == nameOfPage);
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
      // ignore: literal_only_boolean_expressions
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

  static void testActionCode() {
    group('Open Page Action ToCode Test', () {
      test(
        'Open Page',
        () {
          expect(
            FormatterTest.format('''
         GestureDetector(
           onTap: () async {
             await Navigator.push<void>(
             context,
             MaterialPageRoute(
                builder: (context) => Page( ),),);
             },
           child: const SizedBox(),
           )
            '''),
            true,
          );
        },
      );
    });
  }
}
