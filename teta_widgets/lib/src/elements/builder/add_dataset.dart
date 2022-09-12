// Flutter imports:
import 'package:flutter/foundation.dart';
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
  final list = <DatasetObject>[...dataset, map];
  final prjState = BlocProvider.of<FocusProjectBloc>(context).state;
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

    if (prjState is ProjectLoaded) {
      for (final page in prjState.prj.pages!) {
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
