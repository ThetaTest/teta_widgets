// Flutter imports:
// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars

// Flutter imports:
import 'package:camera/camera.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// Package imports:
import 'package:recase/recase.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/actions/snippets/get_page_on_code.dart';
// Project imports:
import 'package:teta_widgets/src/elements/actions/snippets/take_state_from.dart';
import 'package:teta_widgets/src/elements/actions/snippets/update_state_file.dart';

class FActionStateFilePicker {
  static Future action({
    required final BuildContext context,
    required final String? stateName,
    final int loop = 0,
  }) async {
    try {
      if (stateName == null) return;
      final pageState = context.read<PageCubit>().state;
      if (pageState is! PageLoaded) return;
      final index = pageState.states
          .indexWhere((final element) => element.name == stateName);
      if (index >= 0) {
        final result = await FilePicker.platform.pickFiles();
        if (result == null) return;
        final file = XFile(result.files.single.path!);
        updateStateFile(context, stateName, file);
      }
    } catch (e) {
      if (kDebugMode) {
        // ignore: avoid_print
        print(e);
      }
    }
  }

  static String toCode({
    required final int pageId,
    required final BuildContext context,
    required final String? stateName,
    final int loop = 0,
  }) {
    if (stateName == null) return '';
    final page = getPageOnToCode(pageId, context);
    if (page == null) return '';
    final variable = takeStateFrom(page, stateName);
    if (variable == null) return '';

    final varName = ReCase(stateName).camelCase;

    return '''
  final result = await FilePicker.platform.pickFiles();
  if (result == null) return;
  final file = XFile(result.files.single.path!);
  setState(() {
    $varName = file;
  });
''';
  }
}
