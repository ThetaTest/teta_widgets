// Flutter imports:
// ignore_for_file: lines_longer_than_80_chars

// Package imports:
// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/nodes/node.dart';

/// Generates the code for a page
String codeComponentTemplate(
  final BuildContext context,
  final CNode node,
  final List<CNode> children,
  final int pageId,
) {
  final prj =
      (BlocProvider.of<FocusProjectBloc>(context).state as ProjectLoaded).prj;

  final page = prj.pages!.firstWhere((final element) => element.id == pageId);
  final list1 = page.code!.split('void');
  final imports = list1[0]; //returns my imports
  final list2 = page.code!.split('class');
  final code = 'class ${list2[1]}\n class ${list2[2]}';

  return '''
    $imports
    $code 
  ''';
}
