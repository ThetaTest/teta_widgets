import 'package:dart_airtable/dart_airtable.dart';
import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recase/recase.dart';
import 'package:teta_core/src/rendering/nodes.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_db/teta_db.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
import 'package:teta_widgets/src/elements/actions/navigation/pass_params_builder.dart';
import 'package:teta_widgets/src/elements/index.dart';
import 'package:teta_front_end/src/pages/play_page/cubit_value_initializer.dart';
import 'package:teta_front_end/teta_front_end.dart';
import 'package:teta_models/teta_models.dart';

import '../../../../core/teta_action/index.dart';
import '../../../nodes/node.dart';
import 'params.dart';

class TANavigationOpenSnackBar extends TetaAction {
  TANavigationOpenSnackBar({
    required super.params,
    super.loop,
    super.condition,
    super.delay,
    super.id,
  });

  TANavigationOpenSnackBar.fromJson(
    final Map<String, dynamic> json,
  ) : super(
          params: TANavigationOpenSnackBarParams.fromJson(
            json['params'] as Map<String, dynamic>,
          ),
          loop: json['loop'] != null
              ? TetaActionLoop.fromJson(json['loop'] as Map<String, dynamic>)
              : null,
          condition: json['condition'] != null
              ? TetaActionCondition.fromJson(
                  json['condition'] as Map<String, dynamic>,
                )
              : null,
          delay: json['delay'] as int? ?? 0,
        );

  @override
  TANavigationOpenSnackBarParams get params =>
      super.params as TANavigationOpenSnackBarParams;

  @override
  TetaActionType get type => TetaActionType.navigationOpenSnackBar;

  @override
  Future<void> execute(
    final BuildContext context,
    final TetaWidgetState state, {
    final String? runtimeValue,
  }) async {
    try {
      if (params.nameOfPage != null) {
        final prj = BlocProvider.of<FocusProjectCubit>(context).state!;
        final pages = BlocProvider.of<PagesCubit>(context).state;

        final currentPage =
            BlocProvider.of<PageCubit>(context).state as PageLoaded;
        PageObject? page;
        page = pages.firstWhereOrNull(
          (final element) => element.name == params.nameOfPage,
        );
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
                      params.paramsToSend,
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

  @override
  String getActionCode(
    final BuildContext context,
    final int pageId,
    final int loop,
  ) {
    try {
      final pages = BlocProvider.of<PagesCubit>(context).state;

      if (params.nameOfPage == null ||
          pages.indexWhere(
                  (final element) => element.name == params.nameOfPage) ==
              -1) {
        return '';
      }
      final page = pages
          .firstWhere((final element) => element.name == params.nameOfPage);
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
        final valueToSend = (params.paramsToSend ??
                <String, dynamic>{})[param.id]['label'] as String? ??
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
}
