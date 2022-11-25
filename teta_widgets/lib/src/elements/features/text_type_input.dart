// Flutter imports:
// Project imports:
// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars, avoid_escaping_inner_quotes

// Package imports:
import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:collection/collection.dart';
import 'package:device_frame/device_frame.dart';
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
    this.valueTablet,
    this.valueDesktop,
    this.paramName,
    this.stateName,
    this.datasetName,
    this.datasetAttr,
    this.datasetSubListData,
    this.datasetSubMapData,
    this.datasetLength,
    this.keyTranslator,
    this.file,
    this.mapKey,
    this.combination,
    this.resultType = ResultTypeEnum.string,
    this.typeDateTimeFormat,
  }) {
    valueTablet ??= '';
    valueDesktop ??= '';
  }

  FTextTypeEnum? type;
  String? value;
  String? valueTablet;
  String? valueDesktop;
  String? paramName;
  String? stateName;
  String? datasetName;
  String? datasetLength;
  String? datasetAttr;
  String? datasetSubListData;
  String? datasetSubMapData;
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
      Map<String, dynamic>? db = <String, dynamic>{};
      var dbLength = dataset
          .firstWhereOrNull((final element) => element.getName == datasetName)
          ?.getMap
          .length;
      if (dbLength == 1) {
        db = dataset
            .firstWhereOrNull((final element) => element.getName == datasetName)
            ?.getMap[0];
      } else {
        db = dataset
            .firstWhereOrNull((final element) => element.getName == datasetName)
            ?.getMap[loop ?? 0];
      }

      if (db != null) {
        if (db[datasetAttr] is Map) {
          return '${db[datasetAttr][datasetSubMapData]}';
        } else if (db[datasetAttr] is List) {
          return '${db[datasetAttr][loop ?? 0][datasetSubListData]}';
        } else {
          return '${db[datasetAttr]}';
        }
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
    final device = BlocProvider.of<DeviceModeCubit>(context).state;
    if (device.identifier.type == DeviceType.phone) {
      return value ?? '';
    } else if (device.identifier.type == DeviceType.tablet) {
      return valueTablet != '' ? valueTablet ?? value ?? '' : value ?? '';
    } else {
      return valueDesktop != '' ? valueDesktop ?? value ?? '' : value ?? '';
    }
  }

  String getValue(final BuildContext context) {
    final device = BlocProvider.of<DeviceModeCubit>(context).state;
    if (device.identifier.type == DeviceType.phone) {
      return value ?? '';
    } else if (device.identifier.type == DeviceType.tablet) {
      return valueTablet != '' ? valueTablet ?? value ?? '' : value ?? '';
    } else {
      return valueDesktop != '' ? valueDesktop ?? value ?? '' : value ?? '';
    }
  }

  void updateValue(final String val, final BuildContext context) {
    final device = BlocProvider.of<DeviceModeCubit>(context).state;
    if (device.identifier.type == DeviceType.phone) {
      value = val;
    } else if (device.identifier.type == DeviceType.tablet) {
      valueTablet = val;
    } else {
      valueDesktop = val;
    }
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
        valueTablet: json?['vt'] as String?,
        valueDesktop: json?['vd'] as String?,
        paramName: json?['pN'] as String?,
        stateName: json?['sN'] as String?,
        datasetName: json?['dN'] as String?,
        datasetAttr: json?['dA'] as String?,
        datasetSubListData: json?['dAO'] as String?,
        datasetSubMapData: json?['dAT'] as String?,
        datasetLength: json?['dL'] as String?,
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
        'vt': valueTablet,
        'vd': valueDesktop,
        'pN': paramName,
        'sN': stateName,
        'dN': datasetName,
        'dA': datasetAttr,
        'dAO': datasetSubListData,
        'dAT': datasetSubMapData,
        'dL': datasetLength,
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

  String _calcStringType(final String? value) {
    const ls = LineSplitter();
    final _masForUsing = ls.convert(value ?? '');
    if (_masForUsing.length == 1) {
      if ((value ?? '').contains("'")) {
        return '"$value"';
      }
      return "'$value'";
    } else {
      if ((value ?? '').contains("'''")) {
        return '"""$value"""';
      }
      return "'''$value'''";
    }
  }

  String getRawToCode(
    final int? loop, {
    required final ResultTypeEnum resultType,
    final String? defaultValue,
  }) {
    // The value is a hard coded text
    if (type == FTextTypeEnum.text) {
      final v = (value?.replaceAll(' ', '').isNotEmpty ?? false)
          ? value
          : (defaultValue ?? '0');
      final vT = valueTablet != null && valueTablet != ''
          ? (valueTablet?.replaceAll(' ', '').isNotEmpty ?? false)
              ? valueTablet
              : v ?? (defaultValue ?? '0')
          : (value?.replaceAll(' ', '').isNotEmpty ?? false)
              ? value
              : v ?? (defaultValue ?? '0');
      final vD = valueDesktop != null && valueDesktop != ''
          ? (valueDesktop?.replaceAll(' ', '').isNotEmpty ?? false)
              ? valueDesktop
              : v ?? (defaultValue ?? '0')
          : (value?.replaceAll(' ', '').isNotEmpty ?? false)
              ? value
              : v ?? (defaultValue ?? '0');

      if (resultType == ResultTypeEnum.string) {
        final type = defaultValue != 'null' && defaultValue != null
            ? 'String'
            : 'String?';
        if (v == vT && v == vD) {
          return _calcStringType(v);
        }
        return '''
getValueForScreenType<$type>(
  context: context,
  mobile: ${_calcStringType(v)},
  tablet: ${_calcStringType(vT)},
  desktop: ${_calcStringType(vD)},
)''';
      } else if (resultType == ResultTypeEnum.int) {
        final type =
            defaultValue != 'null' && defaultValue != null ? 'int' : 'int?';
        if (v == vT && v == vD) {
          return int.tryParse('$v') != null ? '$v' : (defaultValue ?? '1');
        }
        return """
getValueForScreenType<$type>(
  context: context,
  mobile:  ${int.tryParse('$v') != null ? '$v' : (defaultValue ?? '1')},
  tablet: ${int.tryParse('$vT') != null ? '$vT' : (defaultValue ?? '1')},
  desktop: ${int.tryParse('$vD') != null ? '$vD' : (defaultValue ?? '1')},
)""";
      } else if (resultType == ResultTypeEnum.double) {
        final type = defaultValue != 'null' && defaultValue != null
            ? 'double'
            : 'double?';
        if (v == vT && v == vD) {
          return double.tryParse('$v') != null ? '$v' : (defaultValue ?? '1');
        }
        return """
getValueForScreenType<double>(
  context: context,
  mobile: ${double.tryParse('$v') != null ? '$v' : (defaultValue ?? '1')},
  tablet: ${double.tryParse('$vT') != null ? '$vT' : (defaultValue ?? '1')},
  desktop: ${double.tryParse('$vD') != null ? '$vD' : (defaultValue ?? '1')},
)""";
      } else if (resultType == ResultTypeEnum.bool) {
        final type =
            defaultValue != 'null' && defaultValue != null ? 'bool' : 'bool?';
        if (v == vT && v == vD) {
          return '$v'.toLowerCase() == 'true' || '$v'.toLowerCase() == 'false'
              ? '$v'.toLowerCase()
              : "'$v' == 'true'".toLowerCase();
        }
        return """
getValueForScreenType<$type>(
  context: context,
  mobile: ${'$v'.toLowerCase() == 'true' || '$v'.toLowerCase() == 'false' ? '$v'.toLowerCase() : "'$v' == 'true'".toLowerCase()},
  tablet: ${'$vT'.toLowerCase() == 'true' || '$vT'.toLowerCase() == 'false' ? '$vT'.toLowerCase() : "'$vT' == 'true'".toLowerCase()},
  desktop: ${'$vD'.toLowerCase() == 'true' || '$vD'.toLowerCase() == 'false' ? '$vD'.toLowerCase() : "'$vD' == 'true'".toLowerCase()},
)""";
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
        return "'\${${state.camelCase}}'";
      } else if (resultType == ResultTypeEnum.int) {
        return "int.tryParse('\${${state.camelCase}}') ?? ${defaultValue ?? '0'}";
      } else if (resultType == ResultTypeEnum.double) {
        return "double.tryParse('\${${state.camelCase}}') ?? ${defaultValue ?? '0.0'}";
      } else if (resultType == ResultTypeEnum.bool) {
        return "'\${${state.camelCase}}' == 'true'";
      } else {
        return '\$${state.camelCase}';
      }
    }
    // The value is a dataset
    if (type == FTextTypeEnum.dataset) {
      if (resultType == ResultTypeEnum.string) {
        if (datasetSubListData != null && datasetSubListData != '') {
          //Dataset->List->Data
          return "this.datasets[${_calcStringType(datasetName)}]?[${'0'}]?[${_calcStringType(datasetAttr)}]?[${'index'}]?[${_calcStringType(datasetSubListData)}]?.toString() ?? ''";
        } else if (datasetSubMapData != null && datasetSubMapData != '') {
          //Dataset->Map->Data
          return "this.datasets[${_calcStringType(datasetName)}]?[${'0'}]?[${_calcStringType(datasetAttr)}]?[${_calcStringType(datasetSubMapData)}]?.toString() ?? ''";
        } else {
          //this dataset has one element
          if (datasetLength == '1') {
            return "this.datasets[${_calcStringType(datasetName)}]?[${0}]?[${_calcStringType(datasetAttr)}]?.toString() ?? ''";
          } else {
            //this dataset has one then more element
            //Dataset->Data
            return "this.datasets[${_calcStringType(datasetName)}]?[${datasetName == 'Teta Auth User' ? '0' : 'index'}]?[${_calcStringType(datasetAttr)}]?.toString() ?? ''";
          }
        }
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
