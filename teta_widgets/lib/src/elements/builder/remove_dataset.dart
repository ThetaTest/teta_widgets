import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_core/teta_core.dart';

/// Function to remove a dataset from scaffold and widgets' tree
List<DatasetObject> removeDataset(
  final BuildContext context,
  final String datasetName,
) {
  try {
    final prj = BlocProvider.of<FocusProjectCubit>(context).state!;
    final pageFocused = BlocProvider.of<PageCubit>(context).state as PageLoaded;

    final list = [
      ...List<DatasetObject>.from(pageFocused.datasets)
        ..removeWhere((final element) => element.getName == datasetName),
    ];

    context.read<PageCubit>().updateDatasets(list);
    return list;
  } catch (e) {
    Logger.printError('Error in removeDataset func, error: $e');
    return [];
  }
}
