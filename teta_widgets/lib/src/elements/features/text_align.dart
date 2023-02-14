// Flutter imports:
// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars

import 'package:equatable/equatable.dart';
// Flutter imports:
import 'package:flutter/material.dart';

///
class FTextAlign extends Equatable {
  /// Set of funcs to use TextAlign to Teta
  FTextAlign({
    final TextAlign align = TextAlign.left,
  }) : _align = align;

  TextAlign _align;

  @override
  List<Object?> get props => [_align];

  /// Get actual value
  TextAlign get get => _align;

  static FTextAlign fromJson(final String? json) {
    if (json != null) {
      return FTextAlign(
        align: _convertJsonToValue(json),
      );
    } else {
      return FTextAlign();
    }
  }

  String toJson() => _convertValueToJson(_align);

  static TextAlign _convertJsonToValue(final String key) {
    if (key == 'c') return TextAlign.center;
    if (key == 'r') return TextAlign.right;
    return TextAlign.left;
  }

  static String _convertValueToJson(final TextAlign value) {
    if (value == TextAlign.center) return 'c';
    if (value == TextAlign.right) return 'r';
    return 'l';
  }

  void update({
    required final String value,
    required final BuildContext context,
  }) =>
      _align = _convertJsonToValue(value);

  static String _convertValueToCode(final TextAlign? value) {
    var result = 'TextAlign.left';
    if (value == TextAlign.center) result = 'TextAlign.center';
    if (value == TextAlign.right) result = 'TextAlign.right';
    return result;
  }

  String toCode() => _convertValueToCode(_align);

  /*String toCode() =>
      "FTextAlign(textAligns: [${convertValueToCode(textAligns?[0])},${convertValueToCode(textAligns?[1])},${convertValueToCode(textAligns?[2])},],)";*/
}
