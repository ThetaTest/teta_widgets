// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';

class FAlign {
  FAlign({
    this.align = Alignment.topLeft,
  });

  final Alignment? align;

  static List<String> get dropdownList => [
        'Top Left',
        'Top Center',
        'Top Right',
        'Center Left',
        'Center',
        'Center Right',
        'Bottom Left',
        'Bottom Center',
        'Bottom Right'
      ];

  Alignment get(final BuildContext context) {
    return align!;
  }

  String getStringForDropDown(final BuildContext context) {
    return convertValueToDropDown(align!);
  }

  static FAlign fromJson(final String json) {
    try {
      return FAlign(
        align: convertJsonToValue(json),
      );
    } catch (e) {
      return FAlign();
    }
  }

  String toJson() {
    return convertValueToJson(align!);
  }

  FAlign clone() => FAlign(align: align);

  FAlign copyWith({final Alignment? align}) =>
      FAlign(align: align ?? this.align);

  static Alignment convertJsonToValue(final String key) {
    var align = Alignment.topLeft;
    if (key == 'tL') align = Alignment.topLeft;
    if (key == 'tC') align = Alignment.topCenter;
    if (key == 'tR') align = Alignment.topRight;
    if (key == 'cL') align = Alignment.centerLeft;
    if (key == 'c') align = Alignment.center;
    if (key == 'cR') align = Alignment.centerRight;
    if (key == 'bL') align = Alignment.bottomLeft;
    if (key == 'bC') align = Alignment.bottomCenter;
    if (key == 'bR') align = Alignment.bottomRight;
    return align;
  }

  static Alignment convertDropDownToValue(final String key) {
    var align = Alignment.topLeft;
    if (key == 'Top Center') align = Alignment.topCenter;
    if (key == 'Top Right') align = Alignment.topRight;
    if (key == 'Center Left') align = Alignment.centerLeft;
    if (key == 'Center') align = Alignment.center;
    if (key == 'Center Right') align = Alignment.centerRight;
    if (key == 'Bottom Left') align = Alignment.bottomLeft;
    if (key == 'Bottom Center') align = Alignment.bottomCenter;
    if (key == 'Bottom Right') align = Alignment.bottomRight;
    return align;
  }

  static String convertValueToDropDown(final Alignment key) {
    var align = 'Top Left';
    if (key == Alignment.topCenter) align = 'Top Center';
    if (key == Alignment.topRight) align = 'Top Right';
    if (key == Alignment.centerLeft) align = 'Center Left';
    if (key == Alignment.center) align = 'Center';
    if (key == Alignment.centerRight) align = 'Center Right';
    if (key == Alignment.bottomLeft) align = 'Bottom Left';
    if (key == Alignment.bottomCenter) align = 'Bottom Center';
    if (key == Alignment.bottomRight) align = 'Bottom Right';
    return align;
  }

  static String convertValueToJson(final Alignment value) {
    var result = 'tL';
    if (value == Alignment.topCenter) result = 'tC';
    if (value == Alignment.topRight) result = 'tR';
    if (value == Alignment.centerLeft) result = 'cL';
    if (value == Alignment.center) result = 'c';
    if (value == Alignment.centerRight) result = 'cR';
    if (value == Alignment.bottomLeft) result = 'bL';
    if (value == Alignment.bottomCenter) result = 'bC';
    if (value == Alignment.bottomRight) result = 'bR';
    return result;
  }

  static String convertValueToCode(final Alignment? value) {
    var result = 'Alignment.topLeft';
    if (value == Alignment.topCenter) result = 'Alignment.topCenter';
    if (value == Alignment.topRight) result = 'Alignment.topRight';
    if (value == Alignment.centerLeft) result = 'Alignment.centerLeft';
    if (value == Alignment.center) result = 'Alignment.center';
    if (value == Alignment.centerRight) result = 'Alignment.centerRight';
    if (value == Alignment.bottomLeft) result = 'Alignment.bottomLeft';
    if (value == Alignment.bottomCenter) result = 'Alignment.bottomCenter';
    if (value == Alignment.bottomRight) result = 'Alignment.bottomRight';
    return result;
  }

  /// Converts the Alignment value to code.
  ///
  /// e.g. it returns:
  /// ```dart
  /// Alignment.topLeft
  /// ```
  String toCode() => 'FAlign(align: ${convertValueToCode(align)})';
}


/// ma ora a noi ci serve
/// FAlign(align: ${convertValueToCode(align)})
