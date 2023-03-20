// Flutter imports:
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_core/teta_core.dart';
// Package imports:
import 'package:teta_front_end/teta_front_end.dart';

/// Refreshes the changes rebuild the scaffold
void updateStateFile(
  final BuildContext context,
  final String name,
  final XFile value,
) {
  final pageState = context.read<PageCubit>().state;
  if (pageState is! PageLoaded) return;
  final index =
      pageState.states.indexWhere((final element) => element.name == name);
  if (index != -1) {
    final variable = pageState.states[index].copyWith(
      file: value,
    );
    context.read<PageCubit>().updateStateInPlayMode(variable);
  }
}
