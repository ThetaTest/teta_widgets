import 'package:diacritic/diacritic.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recase/recase.dart';
import 'package:teta_core/src/rendering/nodes.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_db/teta_db.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';
import 'package:teta_widgets/src/elements/actions/navigation/pass_params_builder.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_front_end/teta_front_end.dart';
import 'package:collection/collection.dart';
import 'package:teta_models/teta_models.dart';

import '../../../../core/teta_action/index.dart';
import 'params.dart';

class TANavigationOpenBottomSheet extends TetaAction {
  TANavigationOpenBottomSheet({
    required super.params,
    super.loop,
    super.condition,
    super.delay,
    super.id,
  });

  TANavigationOpenBottomSheet.fromJson(
    final Map<String, dynamic> json,
  ) : super(
          params: TANavigationOpenBottomSheetParams.fromJson(
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
  TANavigationOpenBottomSheetParams get params =>
      super.params as TANavigationOpenBottomSheetParams;

  @override
  TetaActionType get type => TetaActionType.navigationOpenBottomSheet;

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
        final currentPageState =
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
              'Error fetching nodes NodeGestureActionsNavigationOpenPage func, error: ${list.error?.message}',
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
          await showModalBottomSheet<void>(
            backgroundColor: Colors.transparent,
            context: context,
            builder: (final c) => BlocProvider(
              create: (final c) => PageCubit(
                sl.get(),
                sl.get(),
                sl.get(),
                sl.get(),
              )..onFocus(page: page!, forPlay: true),
              child: PlayCubitsValueInitializer(
                originalContext: context,
                child: page!.scaffold.toWidget(
                  state: state.copyWith(
                    forPlay: true,
                    states: page.defaultStates,
                    dataset: currentPageState.datasets,
                    params: passParamsToNewPage(
                      page.defaultParams,
                      [...currentPageState.params, ...currentPageState.states],
                      params.paramsToSend,
                      state.dataset,
                      loop: state.loop,
                    ),
                  ),
                ),
              ).build(),
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

  @override
  String getActionCode(
    final BuildContext context,
    final int pageId,
    final int loop,
  ) {
    try {
      final prjPages = BlocProvider.of<PagesCubit>(context).state;
      if (params.nameOfPage == null ||
          prjPages.indexWhere(
                (final element) => element.name == params.nameOfPage,
              ) ==
              -1) return '';
      final page = prjPages.firstWhere(
        (final element) => element.name == params.nameOfPage,
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

      final stringParamsToSend = StringBuffer()..write('');
      for (final param in page.defaultParams) {
        final name = ReCase(param.name);
        stringParamsToSend.write('${name.camelCase}: ');
        // ignore: avoid_dynamic_calls
        final valueToSend = (params.paramsToSend ??
                <String, dynamic>{})[param.id]?['label'] as String? ??
            'null';
        final rc = ReCase(valueToSend);
        stringParamsToSend.write('widget.${rc.camelCase}, ');
      }

      return '''
      await showModalBottomSheet<void>(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) => Page${pageNameRC.pascalCase}(
          $stringParamsToSend
        ),
      );
      ''';
    } catch (e) {
      return '';
    }
  }
}
