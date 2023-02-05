import 'package:camera/camera.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';

List<VariableObject> getVariableObjectsFromParams(final TetaWidgetState state,
    final PageObject page, final Map<String, dynamic>? paramsToSend) {
  return page.defaultParams.map((final e) {
    if (paramsToSend?[e.id] != null) {
      if (paramsToSend?[e.id]['dataset'] == 'Text') {
        e.value = paramsToSend?[e.id]['label'];
      } else {
        final list = <DatasetObject>[
          DatasetObject(
            name: 'Parameters',
            map: state.params
                .map((final e) => <String, dynamic>{e.name: e.get})
                .toList(),
          ),
          DatasetObject(
            name: 'States',
            map: state.states
                .map((final e) => <String, dynamic>{e.name: e.get})
                .toList(),
          ),
          ...state.dataset,
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
          for (final element in map) {
            if (element.keys.toList()[state.loop ?? 0] ==
                paramsToSend?[e.id]?['label']) {
              if (element[element.keys.toList()[state.loop ?? 0]] is String ||
                  element[element.keys.toList()[state.loop ?? 0]] is int ||
                  element[element.keys.toList()[state.loop ?? 0]] is double) {
                variable = VariableObject(
                  name: element.keys.toList()[state.loop ?? 0],
                  value: element[element.keys.toList()[state.loop ?? 0]],
                );
              }
              if (element[element.keys.toList()[state.loop ?? 0]]
                  is CameraController) {
                variable = VariableObject(
                  name: element.keys.toList()[state.loop ?? 0],
                  type: VariableType.cameraController,
                  controller: element[element.keys.toList()[state.loop ?? 0]]
                      as CameraController,
                );
              }
              if (element[element.keys.toList()[state.loop ?? 0]] is XFile) {
                variable = VariableObject(
                  name: element.keys.toList()[state.loop ?? 0],
                  type: VariableType.file,
                  file:
                      element[element.keys.toList()[state.loop ?? 0]] as XFile,
                );
              }
            }
          }
        } else {
          final el = selectedDataset!['map'] as List<Map<String, dynamic>>;
          final map = el[state.loop ?? 0];
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
    }
    return e;
  }).toList();
}
