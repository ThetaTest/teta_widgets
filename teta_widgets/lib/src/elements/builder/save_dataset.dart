// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_core/teta_core.dart';

/// Function to add a new dataset to scaffold and widgets' tree
/// Save local storage(Hive)
Future<List<DatasetObject>> saveDatasets(
  final BuildContext context,
  final List<DatasetObject> dataset,
  final DatasetObject map,
) async {
  final list = <DatasetObject>[...dataset, map];
  final prjState = BlocProvider.of<FocusProjectBloc>(context).state;
  final pageFocused = BlocProvider.of<PageCubit>(context).state;
  final prj = (prjState as ProjectLoaded).prj;
  try {
    Box<List<dynamic>> box;
    if (!Hive.isBoxOpen('datasets${prj.id}')) {
      box = await Hive.openBox<List<dynamic>>('datasets${prj.id}');
      Logger.printMessage("box first open" + box.keys.toString());
      Logger.printMessage("box prj.id" + prj.id.toString());
    } else {
      box = Hive.box<List<dynamic>>('datasets${prj.id}');
      Logger.printMessage("box still open" + box.keys.toString());
      Logger.printMessage("box prj.id" + prj.id.toString());
    }
    await box.put(map.getName, map.getMap);

    final boxMap = box.toMap();

    final list2 = <DatasetObject>[];

    for (final dynamic key in boxMap.keys) {
      Logger.printMessage("value alındı" + key.toString());
      final map2 = box.get(key)!;
      final map3 =
          map2.map((dynamic e) => (e as Map).cast<String, dynamic>()).toList();
      var _map = DatasetObject(name: key.toString(), map: map3);

      list2.add(_map);
    }
    for (var element in list2) {
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

    if (prjState is ProjectLoaded) {
      Logger.printMessage("prjState");
      for (final page in prjState.prj.pages!) {
        for (var element in list2) {
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

    final list3 = <DatasetObject>[...dataset, ...list2];

    return list3;
  } catch (e) {
    if (kDebugMode) {
      // ignore: avoid_print
      Logger.printError('$e');
    }
    return [];
  }
}
