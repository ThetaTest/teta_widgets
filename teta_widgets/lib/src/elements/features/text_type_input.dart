// Flutter imports:
// Project imports:
// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars

// Package imports:
import 'package:collection/collection.dart';
import 'package:recase/recase.dart';
import 'package:teta_core/src/models/asset_file.dart';
import 'package:teta_core/src/models/dataset.dart';
import 'package:teta_core/src/models/variable.dart';

enum FTextTypeEnum { text, imageUrl, param, state, dataset, asset }

class FTextTypeInput {
  /// Set of func to use text string in Teta's widgets
  FTextTypeInput({
    this.type = FTextTypeEnum.text,
    this.value = '',
    this.paramName,
    this.stateName,
    this.datasetName,
    this.datasetAttr,
    this.file,
    this.mapKey,
  });

  FTextTypeEnum? type;
  String? value;
  String? paramName;
  String? stateName;
  String? datasetName;
  String? datasetAttr;
  AssetFile? file;
  String? mapKey;

  /// Returns value for texts
  String get(
    final List<VariableObject> params,
    final List<VariableObject> states,
    final List<DatasetObject> dataset,
    final bool forPlay,
    final int? loop,
  ) =>
      '${calc(params, states, dataset, forPlay, loop, datasetAttr ?? '')}';

  /// Returns value for images
  dynamic getForImages(
    final List<VariableObject> params,
    final List<VariableObject> states,
    final List<DatasetObject> dataset,
    final int? loop, {
    required final bool forPlay,
  }) =>
      calc(
        params,
        states,
        dataset,
        forPlay,
        loop,
        'https://source.unsplash.com/random',
      );

  /// Returns the value calculated based on params, states and dataset
  dynamic calc(
    final List<VariableObject> params,
    final List<VariableObject> states,
    final List<DatasetObject> dataset,
    final bool forPlay,
    final int? loop,
    final String placeholder,
  ) {
    if (type == FTextTypeEnum.param) {
      try {
        final param = params
            .firstWhereOrNull((final element) => element.name == paramName);
        if (param?.type == VariableType.file) {
          return param?.file;
        }
        return param?.get;
      } catch (_) {}
    }
    if (type == FTextTypeEnum.state) {
      final state =
          states.firstWhereOrNull((final element) => element.name == stateName);
      if (state?.type == VariableType.file) {
        return state?.file;
      }
      return state?.get;
    }
    if (type == FTextTypeEnum.dataset) {
      final db = dataset
          .firstWhereOrNull((final element) => element.getName == datasetName)
          ?.getMap[loop ?? 0];
      if (db != null) {
        return '${db[datasetAttr]}';
      } else {
        return placeholder;
      }
    }
    if (type == FTextTypeEnum.asset) {
      return file?.url ?? '';
    }
    return value ?? '';
  }

  static FTextTypeInput fromJson(final Map<String, dynamic>? json) {
    try {
      return FTextTypeInput(
        type: json?['t'] == 'text'
            ? FTextTypeEnum.text
            : json?['t'] == 'imageUrl'
                ? FTextTypeEnum.imageUrl
                : json?['t'] == 'param'
                    ? FTextTypeEnum.param
                    : json?['t'] == 'state'
                        ? FTextTypeEnum.state
                        : json?['t'] == 'dataset'
                            ? FTextTypeEnum.dataset
                            : json?['t'] == 'asset'
                                ? FTextTypeEnum.asset
                                : FTextTypeEnum.text,
        value: json?['v'] as String?,
        paramName: json?['pN'] as String?,
        stateName: json?['sN'] as String?,
        datasetName: json?['dN'] as String?,
        datasetAttr: json?['dA'] as String?,
        file: json?['f'] != null
            ? AssetFile.fromJson(json?['f'] as Map<String, dynamic>?)
            : null,
        mapKey: json?['mK'] as String?,
      );
    } catch (e) {
      return FTextTypeInput();
    }
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        't': type == FTextTypeEnum.asset
            ? 'asset'
            : type == FTextTypeEnum.dataset
                ? 'dataset'
                : type == FTextTypeEnum.param
                    ? 'param'
                    : type == FTextTypeEnum.state
                        ? 'state'
                        : type == FTextTypeEnum.imageUrl
                            ? 'imageUrl'
                            : 'text',
        'v': value,
        'pN': paramName,
        'sN': stateName,
        'dN': datasetName,
        'dA': datasetAttr,
        'mK': mapKey,
        if (file != null) 'f': file!.toJson(),
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
  ) {
    if (type == FTextTypeEnum.param) {
      final param = ReCase(paramName ?? '');
      return "'''\${widget.${param.camelCase}}'''";
    }
    if (type == FTextTypeEnum.state) {
      final state = ReCase(stateName ?? '');
      return "'''\${${state.camelCase}}'''";
    }
    if (type == FTextTypeEnum.dataset) {
      return "this.datasets['$datasetName']?[index]?['$datasetAttr']?.toString()";
    }
    if (type == FTextTypeEnum.asset) {
      return file?.url ?? '';
    }
    return value ?? '';
  }
}
