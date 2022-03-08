// Flutter imports:
// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars

// Flutter imports:
import 'package:flutter/material.dart';

class FTextDecoration {
  /// Set of funcs to use TextDecoration within Teta
  FTextDecoration({
    this.textDecoration = TextDecoration.none,
  });

  TextDecoration textDecoration;

  TextDecoration get get => textDecoration;

  // ignore: use_setters_to_change_properties
  void set(final TextDecoration decoration) => textDecoration = decoration;

  static FTextDecoration fromJson(final String json) {
    try {
      return FTextDecoration(textDecoration: _convertJsonToValue(json));
    } catch (e) {
      return FTextDecoration();
    }
  }

  String toJson() => _convertValueToJson(textDecoration);

  static TextDecoration _convertJsonToValue(final String key) {
    var decoration = TextDecoration.none;
    if (key == 'n') decoration = TextDecoration.none;
    if (key == 'u') decoration = TextDecoration.underline;
    if (key == 'l') decoration = TextDecoration.lineThrough;
    if (key == 'o') decoration = TextDecoration.overline;
    return decoration;
  }

  static String _convertValueToJson(final TextDecoration value) {
    var decoration = 'n';
    if (value == TextDecoration.none) decoration = 'n';
    if (value == TextDecoration.underline) decoration = 'u';
    if (value == TextDecoration.lineThrough) decoration = 'l';
    if (value == TextDecoration.overline) decoration = 'o';
    return decoration;
  }

  static String _convertValueToCode(final TextDecoration? value) {
    var decoration = 'TextDecoration.none';
    if (value == TextDecoration.none) decoration = 'TextDecoration.none';
    if (value == TextDecoration.underline) {
      decoration = 'TextDecoration.underline';
    }
    if (value == TextDecoration.lineThrough) {
      decoration = 'TextDecoration.lineThrough';
    }
    if (value == TextDecoration.overline) {
      decoration = 'TextDecoration.overline';
    }
    return decoration;
  }

  String toCode() => _convertValueToCode(textDecoration);

  /*String toCode() =>
      "FTextDecoration(textDecorations: [${convertValueToCode(textDecorations?[0])},${convertValueToCode(textDecorations?[1])},${convertValueToCode(textDecorations?[2])},],)";*/
}
