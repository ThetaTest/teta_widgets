// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:device_frame/device_frame.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_core/teta_core.dart';

class FAlign {
  FAlign({
    this.align = Alignment.topLeft,
    this.alignTablet,
    this.alignDesktop,
  });

  final Alignment? align;
  final Alignment? alignTablet;
  final Alignment? alignDesktop;

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
    final device = BlocProvider.of<DeviceModeCubit>(context).state;
    if (device.identifier.type == DeviceType.phone) {
      return align!;
    } else if (device.identifier.type == DeviceType.tablet) {
      return alignTablet ?? align!;
    } else {
      return alignDesktop ?? align!;
    }
  }

  String getStringForDropDown(final BuildContext context) {
    final device = BlocProvider.of<DeviceModeCubit>(context).state;
    Logger.printMessage('getStringForDropDown: ${device.identifier.type}');
    if (device.identifier.type == DeviceType.phone) {
      return convertValueToDropDown(align!);
    } else if (device.identifier.type == DeviceType.tablet) {
      return convertValueToDropDown(alignTablet ?? align!);
    } else {
      return convertValueToDropDown(alignDesktop ?? align!);
    }
  }

  static FAlign fromJson(final dynamic json) {
    if (json is String) {
      return FAlign(
        align: convertJsonToValue(json),
      );
    } else {
      try {
        return FAlign(
          align: convertJsonToValue(json['m'] as String? ?? ''),
          alignTablet: convertDropDownToValue(json['t'] as String? ?? ''),
          alignDesktop: convertDropDownToValue(json['d'] as String? ?? ''),
        );
      } catch (e) {
        return FAlign();
      }
    }
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'm': convertValueToJson(align!),
      't': convertValueToJson(alignTablet ?? align!),
      'd': convertValueToJson(alignDesktop ?? align!),
    };
  }

  FAlign clone() => FAlign(
        align: align,
        alignTablet: alignTablet,
        alignDesktop: alignDesktop,
      );

  FAlign copyWith({
    final Alignment? align,
    final Alignment? alignTablet,
    final Alignment? alignDesktop,
  }) =>
      FAlign(
        align: align ?? this.align,
        alignTablet: alignTablet ?? this.alignTablet,
        alignDesktop: alignDesktop ?? this.alignDesktop,
      );

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
  String toCode() =>
      align == (alignTablet ?? align) && align == (alignDesktop ?? align)
          ? convertValueToCode(align)
          : '''
  getValueForScreenType<Alignment>(
    context: context,
    mobile: ${convertValueToCode(align)},
    tablet: ${convertValueToCode(alignTablet ?? align)},
    desktop: ${convertValueToCode(alignDesktop ?? align)},
  )
  ''';
}


/// ma ora a noi ci serve
/// FAlign(align: ${convertValueToCode(align)})
