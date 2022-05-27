// Flutter imports:
// Package imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// Package imports:
import 'package:teta_cms/teta_cms.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/actions/navigation/open_page.dart';
import 'package:teta_widgets/src/elements/actions/snippets/change_state.dart';
import 'package:teta_widgets/src/elements/actions/snippets/take_state_from.dart';
import 'package:teta_widgets/src/elements/index.dart';
// Project imports:

class FATetaCMSLogin {
  static Future action(
    final CNode node,
    final String? nameOfPage,
    final BuildContext context,
    final Map<String, dynamic>? paramsToSend,
    final List<VariableObject> params,
    final List<VariableObject> states,
    final List<DatasetObject> dataset,
    final int? loop,
  ) async {
    final prjId =
        (BlocProvider.of<FocusProjectBloc>(context).state as ProjectLoaded)
            .prj
            .id;
    final page = BlocProvider.of<FocusPageBloc>(context).state;
    final status = takeStateFrom(page, 'status');

    final resp = await TetaCMS.instance.auth.signInWithBrowser(
      context,
      prjId,
    );
    if (!resp) {
      changeState(status, context, 'Failed');
    } else {
      changeState(status, context, 'Success');
      await FActionNavigationOpenPage.action(
        node,
        context,
        nameOfPage,
        paramsToSend,
        params,
        states,
        dataset,
        loop,
      );
    }
  }

  static String toCode(
    final BuildContext context,
    final String? collectionId,
    final Map<String, dynamic> map,
  ) =>
      "final resp = await TetaCMS.instance.auth.signInWithProvider('$collectionId', <String, dynamic>$map);";
}
