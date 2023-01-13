// Flutter imports:
// Package imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_cms/teta_cms.dart';
// Package imports:
import 'package:teta_core/src/services/track_service.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:

class FATetaCMSLogout {
  static Future action(
    final BuildContext context,
  ) async {
    final prjId =
        (BlocProvider.of<FocusProjectBloc>(context).state as ProjectLoaded)
            .prj
            .id;

    await TetaCMS.instance.auth.signOut();
  }

  static String toCode() {
    return '''
      await TetaCMS.instance.auth.signOut();
    ''';
  }
}
