import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_core/teta_core.dart';

/// Function to add a new dataset to scaffold and widgets' tree
List<DatasetObject> addDataset(
  final BuildContext context,
  final DatasetObject map,
) {
  try {
    final prj = BlocProvider.of<FocusProjectCubit>(context).state!;
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
