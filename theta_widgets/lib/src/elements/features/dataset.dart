// Flutter imports:
// Project imports:
// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars

import 'package:equatable/equatable.dart';
// Package imports:
import 'package:theta_models/src/models/dataset.dart';
import 'package:theta_models/src/models/variable.dart';

class FDataset extends Equatable {
  /// Set of func to use text string in Teta's widgets
  FDataset({
    this.datasetName,
    this.datasetAttrName,
  });

  String? datasetName;
  String? datasetAttrName;

  @override
  List<Object?> get props => [datasetName, datasetAttrName];

  /// Returns value for texts
  String get(
    final List<VariableObject> params,
    final List<VariableObject> states,
    final List<DatasetObject> dataset,
    final int? loop, {
    required final bool forPlay,
  }) =>
      datasetName ?? '';

  static FDataset fromJson(final Map<String, dynamic>? json) {
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
      }..removeWhere((final String key, final dynamic value) => value == null);

  /*String toCode(
          BuildContext context,
          List<VariableObject> params,
          List<VariableObject> states,
          List<DatasetObject> dataset,
          bool forPlay,
          int? loop,) =>
      calc(params, states, dataset, forPlay, loop, '');*/

  String toCode(
    final int? loop,
  ) =>
      "dataset['$datasetName'].getMap[${loop ?? 0}][[datasetAttr]] as String? ?? ''";
}
