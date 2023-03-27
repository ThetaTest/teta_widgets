import 'package:cross_file/cross_file.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recase/recase.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_front_end/teta_front_end.dart';

import '../../../../core/teta_action/index.dart';
import '../../../../core/teta_widget/index.dart';
import '../../snippets/get_page_on_code.dart';
import '../../snippets/take_state_from.dart';
import '../../snippets/update_state_file.dart';
import 'params.dart';

class TAStatePickFile extends TetaAction {
  TAStatePickFile({
    required super.params,
    super.loop,
    super.condition,
    super.delay,
    super.id,
  });

  TAStatePickFile.fromJson(
    final Map<String, dynamic> json,
  ) : super(
          params: TAStatePickFileParams.fromJson(
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
  TAStatePickFileParams get params => super.params as TAStatePickFileParams;

  @override
  TetaActionType get type => TetaActionType.statePickFile;

  @override
  Future<void> execute(
    final BuildContext context,
    final TetaWidgetState state, {
    final String? runtimeValue,
  }) async {
    try {
      if (params.stateName == null) return;
      final pageState = context.read<PageCubit>().state;
      if (pageState is! PageLoaded) return;
      final stateExists = pageState.page.defaultStates
          .any((final element) => element.name == params.stateName);
      if (stateExists) {
        final result = await FilePicker.platform.pickFiles();
        if (result == null) return;
        final file = XFile.fromData(result.files.single.bytes!);
        updateStateFile(context, params.stateName!, file);
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
    if (params.stateName == null) return '';
    final page = getPageOnToCode(pageId, context);
    final variable = takeStateFrom(page, params.stateName!);
    if (variable == null) return '';

    final varName = ReCase(params.stateName!).camelCase;

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
