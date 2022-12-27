// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:teta_core/teta_core.dart';

/// Function to add a new dataset to scaffold and widgets' tree
List<DatasetObject> addDataset(
  final BuildContext context,
  final List<DatasetObject> dataset,
  final DatasetObject map,
) {
  final list = <DatasetObject>[...dataset, map];
  final prj = BlocProvider.of<FocusProjectCubit>(context).state!;
  final pageFocused = BlocProvider.of<PageCubit>(context).state;

  try {
    var flag = true;
    for (final e in pageFocused.datasets) {
      if (e.getName == map.getName) {
        pageFocused.datasets[pageFocused.datasets.indexOf(e)] = map;
        flag = false;
        break;
      }
    }
    if (flag) pageFocused.datasets = [...pageFocused.datasets, map];

    for (final page in prj.pages!) {
      if (page.id == pageFocused.id) {
        var flag = true;
        for (final e in pageFocused.datasets) {
          if (e.getName == map.getName) {
            flag = false;
            break;
          }
        }
        if (flag) page.datasets = [...page.datasets, map];
      }
    }

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
        if (flag) pageFocused.datasets = [...pageFocused.datasets, element];
      }

      for (final page in prj.pages!) {
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
    }

    return list;
  } catch (e) {
    if (kDebugMode) {
      // ignore: avoid_print
      Logger.printError('$e');
    }
    return [];
  }
}
