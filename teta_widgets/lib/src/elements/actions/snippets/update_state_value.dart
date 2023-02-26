// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_core/teta_core.dart';
// Package imports:

/// Refreshes the changes rebuild the scaffold
void updateStateValue(
  final BuildContext context,
  final String name,
  final dynamic value,
) {
  final pageState = context.read<PageCubit>().state;
  if (pageState is! PageLoaded) return;
  final index =
      pageState.states.indexWhere((final element) => element.name == name);
  if (index != -1) {
    final variable = pageState.states[index].copyWith(
      value: value,
    );
    context.read<PageCubit>().updateStateInPlayMode(variable);
  }
}