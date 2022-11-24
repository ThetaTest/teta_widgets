// Flutter imports:
// ignore_for_file: public_member_api_docs

// Package imports:
import 'package:collection/collection.dart';
import 'package:diacritic/diacritic.dart';
// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recase/recase.dart';
import 'package:teta_core/src/rendering/nodes_original.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_db/teta_db.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
import 'package:teta_widgets/src/elements/actions/navigation/pass_params_builder.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';
// Project imports:
import 'package:teta_widgets/src/elements/nodes/node.dart';

class FActionNavigationOpenBottomSheet {
  static Future action(
    final BuildContext context,
    final String? nameOfPage,
    final Map<String, dynamic>? paramsToSend,
    final TetaWidgetState state,
  ) async {
    try {
      if (nameOfPage != null) {
        final prj = BlocProvider.of<FocusProjectBloc>(context).state as ProjectLoaded;
        final currentPage = BlocProvider.of<PageCubit>(context).state;
        PageObject? page;
        page = prj.prj.pages!.firstWhereOrNull((final element) => element.name == nameOfPage);
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
          final scaffold = NodeRendering.renderTree(nodes);
          page = page.copyWith(flatList: nodes, scaffold: scaffold);
          await showModalBottomSheet<void>(
            context: context,
            builder: (final context) => page!.scaffold!.toWidget(
              state: state.copyWith(
                forPlay: true,
                params: passParamsToNewPage(
                  page.params,
                  currentPage.params,
                  paramsToSend,
                  state.dataset,
                  loop: state.loop,
                ),
                states: page.states,
                dataset: page.datasets,
              ),
            ),
          );
        }
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
    try {
      final prj = BlocProvider.of<FocusProjectBloc>(context).state as ProjectLoaded;
      if (nameOfPage == null ||
          (prj.prj.pages ?? <PageObject>[])
                  .indexWhere((final element) => element.name == nameOfPage) ==
              -1) return '';
      final page = prj.prj.pages!.firstWhere((final element) => element.name == nameOfPage);
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
        final name = ReCase(param.name);
        stringParamsToSend.write('${name.camelCase}: ');
        // ignore: avoid_dynamic_calls
        final valueToSend =
            (paramsToSend ?? <String, dynamic>{})[param.id]?['label'] as String? ?? 'null';
        final rc = ReCase(valueToSend);
        stringParamsToSend.write('widget.${rc.camelCase}, ');
      }

      return '''
      await showModalBottomSheet<void>(
        context: context,
        builder: (context) => Page${pageNameRC.pascalCase}(
          ${stringParamsToSend.toString()}
        ),
      );
      ''';
    } catch (e) {
      return '';
    }
  }

  static void testActionCode() {
    group('OpenBottomSheet Action ToCode Test', () {
      test(
        'OpenBottomSheet',
        () {
          expect(
            FormatterTest.format('''
         GestureDetector(
           onTap: () async {
              await showModalBottomSheet<void>(
              context: context,
              builder: (context) => Page(),);
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
