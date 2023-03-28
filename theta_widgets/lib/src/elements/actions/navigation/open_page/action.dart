import 'package:dart_airtable/dart_airtable.dart';
import 'package:diacritic/diacritic.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recase/recase.dart';
import 'package:teta_core/src/rendering/nodes.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_db/teta_db.dart';
import 'package:teta_front_end/teta_front_end.dart';
import 'package:theta_models/theta_models.dart';
import 'package:transition/transition.dart' as t;
import 'package:universal_platform/universal_platform.dart';

import '../../../../core/teta_action/index.dart';
import '../../../../core/teta_widget/index.dart';
import '../../../controls/key_constants.dart';
import '../../../features/page_transition.dart';
import '../../../../../../../../teta_open_classes/lib/src/nodes/node.dart';
import '../pass_params_builder.dart';
import 'params.dart';

void goTo(final CNode node, final BuildContext context, final Widget child) {
  if (node.body.attributes[DBKeys.pageTransition] != null) {
    Navigator.push<void>(
      context,
      t.Transition(
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

class TANavigationOpenPage extends TetaAction {
  TANavigationOpenPage({
    required super.params,
    super.loop,
    super.condition,
    super.delay,
    super.id,
  });

  TANavigationOpenPage.fromJson(
    final Map<String, dynamic> json,
  ) : super(
          params: TANavigationOpenPageParams.fromJson(
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
  TANavigationOpenPageParams get params =>
      super.params as TANavigationOpenPageParams;

  @override
  TetaActionType get type => TetaActionType.navigationOpenPage;

  @override
  Future<void> execute(
    final BuildContext context,
    final TetaWidgetState state, {
    final String? runtimeValue,
  }) async {
    if (UniversalPlatform.isWeb) {
      final uri = Uri.base;
      if (uri.toString().contains('/editor/')) {
        return;
      }
    }
    try {
      final pages = BlocProvider.of<PagesCubit>(context).state;

      final currentPage =
          BlocProvider.of<PageCubit>(context).state as PageLoaded;
      PageObject? page;
      page = pages.firstWhereOrNull(
        (final element) => element.name == params.nameOfPage,
      );
      if (page == null) return;
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
      await Navigator.push<void>(
        context,
        MaterialPageRoute(
          builder: (final c) => BlocProvider(
            lazy: false,
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
        ),
      );
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
    final prj = BlocProvider.of<FocusProjectCubit>(context).state!;
    final pages = BlocProvider.of<PagesCubit>(context).state;

    if (params.nameOfPage == null ||
        pages.indexWhere(
              (final element) => element.name == params.nameOfPage,
            ) ==
            -1) {
      return '';
    }
    final page =
        pages.firstWhere((final element) => element.name == params.nameOfPage);
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
      // ignore: literal_only_boolean_expressions
      if ("${params.paramsToSend?[param.id]?['dataset']}" == 'States' ||
          "${params.paramsToSend?[param.id]?['dataset']}" == 'Params') {
        final valueToSend = (params.paramsToSend ??
                <String, dynamic>{})[param.id]?['label'] as String? ??
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
            "datasets['${params.paramsToSend?[param.id]?['dataset']}']?[index]?['${params.paramsToSend?[param.id]?['label']}'] ?? ''";
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
  }
}
