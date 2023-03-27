import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_front_end/teta_front_end.dart';
import 'package:theta_models/theta_models.dart';

/// Function to add a new dataset to scaffold and widgets' tree
List<DatasetObject> addDataset(
  final BuildContext context,
  final DatasetObject map,
) {
  try {
    final pageFocused = BlocProvider.of<PageCubit>(context).state as PageLoaded;

    final list = [
      ...List<DatasetObject>.from(pageFocused.datasets)
        ..removeWhere((final element) => element.getName == map.getName),
      map,
    ];

    context.read<PageCubit>().updateDatasets(list);
    return list;
  } catch (e) {
    Logger.printError('Error in addDataset func, error: $e');
    return [];
  }
}
