// Flutter imports:
// Project imports:
// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars

// Package imports:
import 'package:teta_core/src/models/dataset.dart';
import 'package:teta_core/src/models/variable.dart';

class FDataset {
  /// Set of func to use text string in Teta's widgets
  FDataset({
    this.datasetName,
    this.datasetAttrName,
  });

  String? datasetName;
  String? datasetAttrName;

  /// Returns value for texts
  String get(
    List<VariableObject> params,
    List<VariableObject> states,
    List<DatasetObject> dataset,
    int? loop, {
    required bool forPlay,
  }) =>
      datasetName ?? '';

  static FDataset fromJson(Map<String, dynamic>? json) {
    try {
      return FDataset(
        datasetName: json?['dN'] as String?,
        datasetAttrName: json?['dAN'] as String?,
      );
    } catch (e) {
      return FDataset();
    }
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'dN': datasetName,
        'dAN': datasetAttrName
      }..removeWhere((String key, dynamic value) => value == null);

  /*String toCode(
          BuildContext context,
          List<VariableObject> params,
          List<VariableObject> states,
          List<DatasetObject> dataset,
          bool forPlay,
          int? loop,) =>
      calc(params, states, dataset, forPlay, loop, '');*/

  String toCode(
    int? loop,
  ) =>
      "dataset['$datasetName'].getMap[${loop ?? 0}][[datasetAttr]] as String? ?? ''";
}
