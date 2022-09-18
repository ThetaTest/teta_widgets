import 'package:camera/camera.dart';
import 'package:just_audio/just_audio.dart';
import 'package:teta_core/teta_core.dart';

List<VariableObject> passParamsToNewPage(
  final List<VariableObject> newPageParams,
  final List<VariableObject> oldPageParams,
  final Map<String, dynamic>? paramsToSend,
  final List<DatasetObject> dataset, {
  final int? loop = 0,
}) {
  return newPageParams.map((final e) {
    if (paramsToSend?[e.id] != null) {
      if (paramsToSend?[e.id]['dataset'] == 'Text') {
        e.value = paramsToSend?[e.id]['label'];
      } else {
        final list = <DatasetObject>[
          DatasetObject(
            name: 'Parameters',
            map: oldPageParams
                .map((final e) => <String, dynamic>{e.name: e.get})
                .toList(),
          ),
          DatasetObject(
            name: 'States',
            map: oldPageParams
                .map((final e) => <String, dynamic>{e.name: e.get})
                .toList(),
          ),
          ...dataset,
        ];
        Map<String, dynamic>? selectedDataset;
        for (final element in list) {
          if (element.getName == paramsToSend?[e.id]['dataset']) {
            selectedDataset = <String, dynamic>{
              'name': element.getName,
              'map': element.getMap
            };
          }
        }
        VariableObject? variable;
        if (selectedDataset?['name'] == 'Parameters' ||
            selectedDataset?['name'] == 'States') {
          final map = selectedDataset!['map'] as List<Map<String, dynamic>>;
          //final element = map[loop ?? 0];
          for (final element in map) {
            if (element.keys.toList()[loop ?? 0] ==
                paramsToSend?[e.id]?['label']) {
              if (element[element.keys.toList()[loop ?? 0]] is String) {
                variable = VariableObject(
                  name: element.keys.toList()[loop ?? 0],
                  value: element[element.keys.toList()[loop ?? 0]],
                );
              }
              if (element[element.keys.toList()[loop ?? 0]]
                  is CameraController) {
                variable = VariableObject(
                  name: element.keys.toList()[loop ?? 0],
                  type: VariableType.cameraController,
                  controller: element[element.keys.toList()[loop ?? 0]]
                      as CameraController,
                );
              }
              if (element[element.keys.toList()[loop ?? 0]] is AudioPlayer) {
                variable = VariableObject(
                  name: element.keys.toList()[loop ?? 0],
                  type: VariableType.audioController,
                  audioController:
                      element[element.keys.toList()[loop ?? 0]] as AudioPlayer,
                );
              }
              if (element[element.keys.toList()[loop ?? 0]] is XFile) {
                variable = VariableObject(
                  name: element.keys.toList()[loop ?? 0],
                  type: VariableType.file,
                  file: element[element.keys.toList()[loop ?? 0]] as XFile,
                );
              }
            }
          }
        } else {
          final el = selectedDataset!['map'] as List<Map<String, dynamic>>;
          final map = el[loop ?? 0];
          for (final key in map.keys) {
            if (key == paramsToSend?[e.id]?['label']) {
              variable = VariableObject(name: key, value: map[key]);
            }
          }
        }
        if (variable != null) {
          e
            ..value = variable.get
            ..file = variable.file
            ..controller = variable.controller;
        }
      }
      return e;
    }
    return e;
  }).toList();
}
