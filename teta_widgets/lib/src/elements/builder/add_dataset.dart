// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_core/teta_core.dart';

/// Function to add a new dataset to scaffold and widgets' tree
List<DatasetObject> addDataset(
  final BuildContext context,
  final List<DatasetObject> dataset,
  final DatasetObject map,
) {
  final prj = BlocProvider.of<FocusProjectCubit>(context).state!;
  final pageFocused = BlocProvider.of<PageCubit>(context).state as PageLoaded;

  final list = [
    ...List<DatasetObject>.from(pageFocused.datasets)
      ..removeWhere((final element) => element.getName == map.getName),
    map,
  ];

  context.read<PageCubit>().updateDatasets(list);
  return list;
/*
    Box<List<dynamic>> box;
    if (Hive.isBoxOpen('datasets${prj.id}')) {
      final list2 = <DatasetObject>[];
      box = Hive.box<List<dynamic>>('datasets${prj.id}');
      final boxMap = box.toMap();

      for (final dynamic key in boxMap.keys) {
        final map2 = box.get(key)!;
        final map3 = map2
            .map((final dynamic e) => (e as Map).cast<String, dynamic>())
            .toList();
        final _map = DatasetObject(name: key.toString(), map: map3);

        list2.add(_map);
      }
      for (final element in list2) {
        var flag = true;
        for (final e in pageFocused.datasets) {
          if (e.getName == element.getName) {
            pageFocused.datasets[pageFocused.datasets.indexOf(e)] = element;
            flag = false;
            break;
          }
        }
        if (flag) {
          context
              .read<PageCubit>()
              .updateDatasets([...pageFocused.datasets, map]);
        }
      }

    return list;*/
}
