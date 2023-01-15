import 'package:dart_style/dart_style.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_repositories/src/project_repository.dart';

class FormatterTest {
  static bool format(final String code) {
    var result = false;
    final formatter = DartFormatter();
    try {
      formatter.format('''
import 'package:flutter/material.dart';

class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return $code;
  }
}''');
      return true;
    } catch (e) {
      Logger.printError('Error formating: $e');
    }
    if (result = false) {
      sl.get<ProjectRepository>().sendToCodeError(code);
    }
    return result;
  }
}
