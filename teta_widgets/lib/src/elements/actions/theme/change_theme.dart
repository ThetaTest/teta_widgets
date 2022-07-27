// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_core/teta_core.dart';
// Package imports:

class FActionChangeTheme {
  static Future action(
    final BuildContext context,
  ) async {
    await BlocProvider.of<PaletteDarkLightCubit>(context).switchVal();
  }

  static String toCode(
    final BuildContext context,
  ) {
    return '''
    await BlocProvider.of<ThemeCubit>(context).changeVal();
    ''';
  }
}
