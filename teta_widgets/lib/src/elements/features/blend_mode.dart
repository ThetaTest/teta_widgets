// Flutter imports:
// Package imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:enum_to_string/enum_to_string.dart';

const nameAttr = 'BlendMode';

class FBlendMode {
  FBlendMode({
    this.mode = BlendMode.clear,
  });

  final BlendMode? mode;

  static List<String> get dropdownList => BlendMode.values
      .map((element) => EnumToString.convertToString(element, camelCase: true))
      .toList();

  BlendMode get() {
    return mode!;
  }

  String getStringForDropDown(BuildContext context) {
    return convertValueToDropDown(mode!);
  }

  static FBlendMode fromJson(String json) {
    try {
      return FBlendMode(
        mode: convertJsonToValue(json),
      );
    } catch (e) {
      return FBlendMode();
    }
  }

  String toJson() {
    return convertValueToJson(mode!);
  }

  FBlendMode clone() => FBlendMode(mode: mode);

  FBlendMode copyWith({BlendMode? mode}) => FBlendMode(mode: mode ?? this.mode);

  static BlendMode convertJsonToValue(String key) {
    return EnumToString.fromString(
          BlendMode.values,
          key,
        ) ??
        BlendMode.clear;
  }

  static BlendMode convertDropDownToValue(String key) =>
      EnumToString.fromString(BlendMode.values, key, camelCase: true) ??
      BlendMode.clear;

  static String convertValueToDropDown(BlendMode key) =>
      EnumToString.convertToString(key, camelCase: true);

  static String convertValueToJson(BlendMode value) =>
      EnumToString.convertToString(value);

  static String convertValueToCode(BlendMode? value) =>
      EnumToString.convertToString(value);

  String toCode() => 'FBlendMode(mode: BlendMode.${convertValueToCode(mode)})';
}

/// questo toCode printa BlendMode.qualche valore di BlendMode
/// Ma a noi serve in quest'altro modo: FBlendMode(mode: BlendMode.${convertValueToCode(mode)})
