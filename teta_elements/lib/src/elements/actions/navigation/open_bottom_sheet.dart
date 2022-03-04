// Flutter imports:
// ignore_for_file: public_member_api_docs

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recase/recase.dart';
// Project imports:
import 'package:teta_core/src/blocs/focus_project/index.dart';
import 'package:teta_core/src/models/dataset.dart';
import 'package:teta_core/src/models/page.dart';
import 'package:teta_core/src/models/variable.dart';
import 'package:teta_core/src/rendering/nodes_original.dart';
import 'package:teta_core/src/repositories/queries/node.dart';
import 'package:teta_elements/src/elements/nodes/node.dart';

class FActionNavigationOpenBottomSheet {
  static Future action(
    BuildContext context,
    String? nameOfPage,
    Map<String, dynamic>? paramsToSend,
    List<VariableObject> params,
    List<VariableObject> states,
    List<DatasetObject> dataset,
    int? loop,
  ) async {
    try {
      if (nameOfPage != null) {
        final prj =
            BlocProvider.of<FocusProjectBloc>(context).state as ProjectLoaded;
        var page = prj.prj.pages!
            .firstWhereOrNull((element) => element.name == nameOfPage);
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
          await showModalBottomSheet<void>(
            context: context,
            builder: (context) => page!.scaffold!.toWidget(
              forPlay: true,
              params: page.params,
              states: page.states,
              dataset: page.datasets,
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
    BuildContext context,
    String? nameOfPage,
    Map<String, dynamic>? paramsToSend,
  ) {
    try {
      final prj =
          BlocProvider.of<FocusProjectBloc>(context).state as ProjectLoaded;
      if (nameOfPage == null ||
          (prj.prj.pages ?? <PageObject>[])
                  .indexWhere((element) => element.name == nameOfPage) ==
              -1) return '';
      final page =
          prj.prj.pages!.firstWhere((element) => element.name == nameOfPage);
      final realPageName = "Page${nameOfPage.replaceAll(' ', "")}";

      final stringParamsToSend = StringBuffer()..write('');
      for (final param in page.params) {
        final name = ReCase(param.name);
        stringParamsToSend.write('${name.camelCase}: ');
        // ignore: avoid_dynamic_calls
        final valueToSend = (paramsToSend ?? <String, dynamic>{})[param.id]
                ?['label'] as String? ??
            'null';
        final rc = ReCase(valueToSend);
        stringParamsToSend.write('${rc.camelCase}, ');
      }

      return '''
      await showModalBottomSheet<void>(
        context: context,
        builder: (context) => $realPageName(
          ${stringParamsToSend.toString()}
        ),
      );
      ''';
    } catch (e) {
      return '';
    }
  }
}
