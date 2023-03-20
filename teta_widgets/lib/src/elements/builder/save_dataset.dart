// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_front_end/teta_front_end.dart';

/// Function to add a new dataset to scaffold and widgets' tree
/// Save local storage(Hive)
Future<List<DatasetObject>> saveDatasets(
  final BuildContext context,
  final List<DatasetObject> dataset,
  final DatasetObject map,
) async {
  final list = <DatasetObject>[...dataset, map];
  final pageFocused = BlocProvider.of<PageCubit>(context).state as PageLoaded;
  final prj = BlocProvider.of<FocusProjectCubit>(context).state!;
  try {
    Box<List<dynamic>> box;
    if (!Hive.isBoxOpen('datasets${prj.id}')) {
      box = await Hive.openBox<List<dynamic>>('datasets${prj.id}');
    } else {
      box = Hive.box<List<dynamic>>('datasets${prj.id}');
    }
    await box.put(map.getName, map.getMap);

    final boxMap = box.toMap();

    final list2 = <DatasetObject>[];

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

    /*final pages = BlocProvider.of<PagesCubit>(context).state;
    for (final page in pages) {
      for (final element in list2) {
        var flag = true;
        for (final e in page.datasets) {
          if (e.getName == element.getName) {
            page.datasets[page.datasets.indexOf(e)] = element;

            flag = false;
            break;
          }
        }
        if (flag) page.datasets = [...page.datasets, element];
      }
    }

    final list3 = <DatasetObject>[...dataset, ...list2];*/

    return [...pageFocused.datasets, map];
  } catch (e) {
    if (kDebugMode) {
      // ignore: avoid_print
      Logger.printError('$e');
    }
    return [];
  }
}
