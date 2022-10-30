// Flutter imports:
// Project imports:
// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars, avoid_escaping_inner_quotes

// Package imports:
import 'package:camera/camera.dart';
import 'package:collection/collection.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:recase/recase.dart';
import 'package:teta_core/teta_core.dart';

enum FTextTypeEnum {
  text,
  imageUrl,
  param,
  state,
  dataset,
  asset,
  combined,
  languages
}

enum ResultTypeEnum {
  string,
  dateTime,
  int,
  double,
  bool,
  audioPlayer,
  webviewController,
  mapController,
  googleMapsController,
}

enum TypeDateTimeFormat {
  dateWithTime,
  dateWithoutTime,
}

class FTextTypeInput {
  /// Set of func to use text string in Teta's widgets
  FTextTypeInput({
    this.type = FTextTypeEnum.text,
    this.value = '',
    this.paramName,
    this.stateName,
    this.datasetName,
    this.datasetAttr,
    this.keyTranslator,
    this.file,
    this.mapKey,
    this.combination,
    this.resultType = ResultTypeEnum.string,
    this.typeDateTimeFormat,
  });

  FTextTypeEnum? type;
  FTextTypeEnum? typeTablet;
  FTextTypeEnum? typeDesktop;
  String? value;
  String? paramName;
  String? stateName;
  String? datasetName;
  String? datasetAttr;
  String? keyTranslator;
  AssetFile? file;
  String? mapKey;
  List<FTextTypeInput>? combination;
  ResultTypeEnum resultType;
  TypeDateTimeFormat? typeDateTimeFormat;

  /// Returns value for texts
  String get(
    final List<VariableObject> params,
    final List<VariableObject> states,
    final List<DatasetObject> dataset,
    final bool forPlay,
    final int? loop,
    final BuildContext context,
  ) =>
      '${calc(params, states, dataset, forPlay, loop, datasetAttr ?? '', context)}';

  String getStateValue(
    final List<VariableObject> states,
  ) {
    if (type == FTextTypeEnum.state) {
      final state =
          states.firstWhereOrNull((final element) => element.name == stateName);
      if (state?.type == VariableType.file) {
        return '${state?.file}';
      }
      return '${state?.get}';
    } else {
      return 'null';
    }
  }

  /// Returns value for images
  dynamic getForImages(
    final List<VariableObject> params,
    final List<VariableObject> states,
    final List<DatasetObject> dataset,
    final int? loop, {
    required final bool forPlay,
    required final BuildContext context,
  }) =>
      calc(
        params,
        states,
        dataset,
        forPlay,
        loop,
        'https://source.unsplash.com/random',
        context,
      );

  /// Returns the value calculated based on params, states and dataset
  dynamic calc(
    final List<VariableObject> params,
    final List<VariableObject> states,
    final List<DatasetObject> dataset,
    final bool forPlay,
    final int? loop,
    final String placeholder,
    final BuildContext context,
  ) {
    final dynamic result = getRaw(
      params,
      states,
      dataset,
      forPlay,
      loop,
      placeholder,
      context,
    );
    if (result.runtimeType == XFile) {
      return result;
    } else if (result.runtimeType == String) {
      switch (resultType) {
        case ResultTypeEnum.string:
          return result;
        case ResultTypeEnum.int:
          return int.tryParse(result as String) ??
              'Impossible to convert to int type';
        case ResultTypeEnum.double:
          return double.tryParse(result as String) ??
              'Impossible to convert to double type';
        case ResultTypeEnum.bool:
          return (result as String?) == 'true'
              ? true
              : result == 'false'
                  ? false
                  : 'Impossible to convert to double type';
        case ResultTypeEnum.dateTime:
          final date = DateTime.tryParse(result as String);
          if (date != null) {
            if (typeDateTimeFormat == TypeDateTimeFormat.dateWithoutTime) {
              return DateFormat('yyyy-MM-dd').format(date);
            }
            if (typeDateTimeFormat == TypeDateTimeFormat.dateWithTime) {
              return DateFormat('yyyy-MM-dd hh:mm:ss').format(date);
            }
          }
          return 'Impossible to convert to DateTime type';
      }
    }
  }

  dynamic getRaw(
    final List<VariableObject> params,
    final List<VariableObject> states,
    final List<DatasetObject> dataset,
    final bool forPlay,
    final int? loop,
    final String placeholder,
    final BuildContext context,
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
    if (type == FTextTypeEnum.combined) {
      final string = StringBuffer();
      for (final element in combination ?? <FTextTypeInput>[]) {
        string.write(
          element.get(params, states, dataset, forPlay, loop, context),
        );
      }
      return string.toString();
    }
    if (type == FTextTypeEnum.languages) {
      if (keyTranslator != null) {
        return BlocProvider.of<TranslatorGeneratorCubit>(
          context,
        ).state.getString(keyTranslator!);
      }
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
                                : json?['t'] == 'combined'
                                    ? FTextTypeEnum.combined
                                    : json?['t'] == 'languages'
                                        ? FTextTypeEnum.languages
                                        : FTextTypeEnum.text,
        value: json?['v'] as String?,
        paramName: json?['pN'] as String?,
        stateName: json?['sN'] as String?,
        datasetName: json?['dN'] as String?,
        datasetAttr: json?['dA'] as String?,
        keyTranslator: json?['kTrans'] as String?,
        file: json?['f'] != null
            ? AssetFile.fromJson(json?['f'] as Map<String, dynamic>?)
            : null,
        mapKey: json?['mK'] as String?,
        combination: json?['cmb'] != null
            ? (json?['cmb'] as List<dynamic>)
                .map(
                  (final dynamic e) =>
                      FTextTypeInput.fromJson(e as Map<String, dynamic>),
                )
                .toList()
            : [],
        resultType: EnumToString.fromString(
              ResultTypeEnum.values,
              json?['rType'] as String? ?? 'string',
            ) ??
            ResultTypeEnum.string,
        typeDateTimeFormat: EnumToString.fromString(
              TypeDateTimeFormat.values,
              json?['tDateTime'] as String? ??
                  EnumToString.convertToString(TypeDateTimeFormat.dateWithTime),
            ) ??
            TypeDateTimeFormat.dateWithTime,
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
                            : type == FTextTypeEnum.combined
                                ? 'combined'
                                : type == FTextTypeEnum.languages
                                    ? 'languages'
                                    : 'text',
        'v': value,
        'pN': paramName,
        'sN': stateName,
        'dN': datasetName,
        'dA': datasetAttr,
        'kTrans': keyTranslator,
        'mK': mapKey,
        'cmb': combination?.map((final e) => e.toJson()).toList(),
        'rType': EnumToString.convertToString(resultType),
        'tDateTime': typeDateTimeFormat != null
            ? EnumToString.convertToString(typeDateTimeFormat)
            : EnumToString.convertToString(TypeDateTimeFormat.dateWithTime),
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
    final int? loop, {
    required final ResultTypeEnum resultType,
    final String? defaultValue,
    final bool? whiteSpace,
    final bool? wrapInString,
  }) {
    if (type == FTextTypeEnum.languages) {
      return "TranslatorGenerator.instance.getString('''$keyTranslator''')";
    }

    final code =
        getRawToCode(loop, resultType: resultType, defaultValue: defaultValue);

    if (type == FTextTypeEnum.combined || whiteSpace == false) {
      return code;
    }

    return convertType(code, resType: resultType);
  }

  String getRawToCode(
    final int? loop, {
    required final ResultTypeEnum resultType,
    final String? defaultValue,
  }) {
    // The value is a hard coded text
    if (type == FTextTypeEnum.text) {
      final v = (value?.replaceAll(' ', '').isNotEmpty ?? false)
          ? value?.replaceAll("'", '')
          : (defaultValue ?? 0);

      if (resultType == ResultTypeEnum.string) {
        return "'''$v'''";
      } else if (resultType == ResultTypeEnum.int) {
        return int.tryParse('$v') != null ? '$v' : (defaultValue ?? '1');
      } else if (resultType == ResultTypeEnum.double) {
        return double.tryParse('$v') != null ? '$v' : (defaultValue ?? '1');
      } else if (resultType == ResultTypeEnum.bool) {
        return '$v'.toLowerCase() == 'true' || '$v'.toLowerCase() == 'false'
            ? '$v'.toLowerCase()
            : "'$v' == 'true'".toLowerCase();
      }
    }
    // The value is a param
    if (type == FTextTypeEnum.param) {
      if (paramName?.isEmpty ?? true) return "''";
      final param = ReCase(paramName ?? '');
      if (resultType == ResultTypeEnum.string) {
        return "'''\${widget.${param.camelCase}}'''";
      } else if (resultType == ResultTypeEnum.int) {
        return "int.tryParse('\${widget.${param.camelCase}}') ?? ${defaultValue ?? '0'}";
      } else if (resultType == ResultTypeEnum.double) {
        return "double.tryParse('\${widget.${param.camelCase}}') ?? ${defaultValue ?? '0.0'}";
      } else if (resultType == ResultTypeEnum.bool) {
        return "'\${widget.${param.camelCase}}' == 'true'";
      } else {
        return "'''\${widget.${param.camelCase}}'''";
      }
    }
    // The value is a state
    if (type == FTextTypeEnum.state) {
      if (stateName?.isEmpty ?? true) return "''";
      final state = ReCase(stateName ?? '');
      if (resultType == ResultTypeEnum.string) {
        return "'''\${${state.camelCase}}'''";
      } else if (resultType == ResultTypeEnum.int) {
        return "int.tryParse('\${${state.camelCase}}') ?? ${defaultValue ?? '0'}";
      } else if (resultType == ResultTypeEnum.double) {
        return "double.tryParse('\${${state.camelCase}}') ?? ${defaultValue ?? '0.0'}";
      } else if (resultType == ResultTypeEnum.bool) {
        return "'\${${state.camelCase}}' == 'true'";
      } else {
        return "'''\${${state.camelCase}}'''";
      }
    }
    // The value is a dataset
    if (type == FTextTypeEnum.dataset) {
      if (resultType == ResultTypeEnum.string) {
        return "'''\${(this.datasets['$datasetName']?[${datasetName == 'Teta Auth User' ? '0' : 'index'}]?['$datasetAttr']?.toString() ?? '')}'''";
      } else if (resultType == ResultTypeEnum.int) {
        return '0';
      } else if (resultType == ResultTypeEnum.double) {
        return '0.0';
      } else if (resultType == ResultTypeEnum.bool) {
        return 'true';
      }
    }
    // The value is an asset
    if (type == FTextTypeEnum.asset) {
      return file?.url ?? '';
    }
    if (type == FTextTypeEnum.combined) {
      if (resultType == ResultTypeEnum.string) {
        final string = StringBuffer("'''");
        for (final element in combination ?? <FTextTypeInput>[]) {
          final code = convertType(
            element.toCode(loop, resultType: resultType).replaceAll("'''", ''),
            resType: resultType,
          ).replaceAll("'''", '');
          string.write(code);
        }
        string.write("'''");
        return string.toString();
      } else if (resultType == ResultTypeEnum.int) {
        return '0';
      } else if (resultType == ResultTypeEnum.double) {
        return '0.0';
      } else if (resultType == ResultTypeEnum.bool) {
        return 'true';
      }
    }
    return value ?? '';
  }

  String convertType(
    final String original, {
    required final ResultTypeEnum resType,
  }) {
    var code = original;
    if (original.contains("'")) {
      code = '$original ';
    }
    if (resultType == ResultTypeEnum.string) {
      switch (resultType) {
        case ResultTypeEnum.dateTime:
          if (typeDateTimeFormat == TypeDateTimeFormat.dateWithoutTime) {
            return "'\${DateFormat('yyyy-MM-dd').format(DateTime.tryParse($code) ?? DateTime.now())}'";
          }
          if (typeDateTimeFormat == TypeDateTimeFormat.dateWithTime) {
            return "'\${DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.tryParse($code) ?? DateTime.now())}'";
          }
      }
    }
    return code;
  }
}
