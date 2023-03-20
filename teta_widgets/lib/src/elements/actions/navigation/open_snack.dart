// Flutter imports:
// ignore_for_file: public_member_api_docs, avoid_dynamic_calls

// Flutter imports:
import 'package:collection/collection.dart';
import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recase/recase.dart';
import 'package:teta_core/src/rendering/nodes.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_db/teta_db.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
import 'package:teta_widgets/src/elements/actions/navigation/pass_params_builder.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';
import 'package:teta_widgets/src/elements/index.dart';
import 'package:teta_front_end/src/pages/play_page/cubit_value_initializer.dart';
import 'package:teta_front_end/teta_front_end.dart';

class FActionNavigationOpenSnackBar {
  static Future action(
    final BuildContext context,
    final TetaWidgetState state,
    final String? nameOfPage,
    final Map<String, dynamic>? paramsToSend,
  ) async {
    try {
      if (nameOfPage != null) {
        final prj = BlocProvider.of<FocusProjectCubit>(context).state!;
        final pages = BlocProvider.of<PagesCubit>(context).state;

        final currentPage =
            BlocProvider.of<PageCubit>(context).state as PageLoaded;
        PageObject? page;
        page = pages
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
          final snackBar = SnackBar(
            padding: EdgeInsets.zero,
            margin: EdgeInsets.zero,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            elevation: 0,
            content: BlocProvider(
              lazy: false,
              create: (final c) => PageCubit(
                sl.get(),
                sl.get(),
                sl.get(),
                sl.get(),
              )..onFocus(page: page!, forPlay: true),
              child: PlayCubitsValueInitializer(
                originalContext: context,
                child: page.scaffold.toWidget(
                  state: state.copyWith(
                    forPlay: true,
                    states: page.defaultStates,
                    dataset: [],
                    params: passParamsToNewPage(
                      page.defaultParams,
                      currentPage.params,
                      paramsToSend,
                      state.dataset,
                      loop: state.loop,
                    ),
                  ),
                ),
              ).build(),
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      }
    } catch (e) {
      debugPrint('$e');
    }
  }

  static String toCode(
    final BuildContext context,
    final String? nameOfPage,
    final Map<String, dynamic>? paramsToSend,
  ) {
    try {
      final prj = BlocProvider.of<FocusProjectCubit>(context).state!;
      final pages = BlocProvider.of<PagesCubit>(context).state;

      if (nameOfPage == null ||
          pages.indexWhere((final element) => element.name == nameOfPage) ==
              -1) {
        return '';
      }
      final page =
          pages.firstWhere((final element) => element.name == nameOfPage);
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
      for (final param in page.defaultParams) {
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
        padding: EdgeInsets.zero,
        margin: EdgeInsets.zero,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: Page${pageNameRC.pascalCase}(
          ${stringParamsToSend.toString()}
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      ''';
    } catch (e) {
      return '';
    }
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
             final snackBar = SnackBar(
        content: Page(),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
