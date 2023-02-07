import 'package:camera/camera.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/core/teta_widget/index.dart';

List<VariableObject> getVariableObjectsFromParams(
  final TetaWidgetState state,
  final PageObject page,
  final Map<String, dynamic>? paramsToSend,
) {
  final variables = <VariableObject>[];
  for (var i = 0; i < page.defaultParams.length; i++) {
    if (paramsToSend?[page.defaultParams[i].id] != null) {
      if (paramsToSend?[page.defaultParams[i].id]['dataset'] == 'Text') {
        variables.add(
          page.defaultParams[i].copyWith(
            value: paramsToSend?[page.defaultParams[i].id]['label'],
          ),
        );
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
          if (element.getName ==
              paramsToSend?[page.defaultParams[i].id]['dataset']) {
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
                paramsToSend?[page.defaultParams[i].id]?['label']) {
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
            if (key == paramsToSend?[page.defaultParams[i].id]?['label']) {
              variable = VariableObject(name: key, value: map[key]);
            }
          }
        }
        if (variable != null) {
          variables.add(
            page.defaultParams[i].copyWith(
              value: variable.get,
              file: variable.file,
              controller: variable.controller,
            ),
          );
        }
      }
    }
  }
  return variables;
}
