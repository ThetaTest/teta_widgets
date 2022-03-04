// Flutter imports:
// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars

import 'package:flutter/material.dart';

///
class FTextAlign {
  /// Set of funcs to use TextAlign to Teta
  FTextAlign({
    TextAlign align = TextAlign.left,
  }) : _align = align;

  TextAlign _align;

  /// Get actual value
  TextAlign get get => _align;

  static FTextAlign fromJson(String? json) {
    if (json != null) {
      return FTextAlign(
        align: _convertJsonToValue(json),
      );
    } else {
      return FTextAlign();
    }
  }

  String toJson() => _convertValueToJson(_align);

  static TextAlign _convertJsonToValue(String key) {
    if (key == 'c') return TextAlign.center;
    if (key == 'r') return TextAlign.right;
    return TextAlign.left;
  }

  static String _convertValueToJson(TextAlign value) {
    if (value == TextAlign.center) return 'c';
    if (value == TextAlign.right) return 'r';
    return 'l';
  }

  void update({required String value, required BuildContext context}) =>
      _align = _convertJsonToValue(value);

  static String _convertValueToCode(TextAlign? value) {
    var result = 'TextAlign.left';
    if (value == TextAlign.center) result = 'TextAlign.center';
    if (value == TextAlign.right) result = 'TextAlign.right';
    return result;
  }

  String toCode() => _convertValueToCode(_align);

  /*String toCode() =>
      "FTextAlign(textAligns: [${convertValueToCode(textAligns?[0])},${convertValueToCode(textAligns?[1])},${convertValueToCode(textAligns?[2])},],)";*/
}
