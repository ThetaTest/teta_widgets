// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:device_frame/device_frame.dart' as frame;
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// Package imports:
import 'package:teta_core/src/utils/expression/expression.dart';
import 'package:teta_core/teta_core.dart';

enum SizeUnit {
  pixel,
  percent,
  width,
  height,
}

class FSize extends Equatable {
  FSize({
    this.size,
    this.unit,
    this.sizeTablet,
    this.unitTablet,
    this.sizeDesktop,
    this.unitDesktop,
  }) {
    sizeTablet ??= size;
    sizeDesktop ??= size;
    unitTablet ??= unit;
    unitDesktop ??= unit;
  }

  String? size;
  String? sizeTablet;
  String? sizeDesktop;
  SizeUnit? unit;
  SizeUnit? unitTablet;
  SizeUnit? unitDesktop;

  @override
  List<Object?> get props => [
        size,
        sizeTablet,
        sizeDesktop,
        unit,
        unitTablet,
        unitDesktop,
      ];

  static FSize ready() => FSize(size: '0', unit: SizeUnit.pixel);

  double? get({
    required final BuildContext context,
    required final bool isWidth,
    required final bool forPlay,
  }) {
    Logger.printWarning(
      'FSize, size: $size, sizeTablet: $sizeTablet, sizeDesktop: $sizeDesktop',
    );
    String? sizeValue;
    SizeUnit? unitValue;
    if (forPlay) {
      final width = MediaQuery.of(context).size.width;
      if (width < 600) {
        sizeValue = size ?? '0';
        unitValue = unit;
      } else if (width < 1000) {
        sizeValue = sizeTablet ?? size ?? '0';
        unitValue = unitTablet ?? unit;
      } else {
        unitValue = unitDesktop ?? unit;
      }
    } else {
      final device = BlocProvider.of<DeviceModeCubit>(context).state;
      if (device.type == frame.DeviceType.phone) {
        sizeValue = size ?? '0';
        unitValue = unit;
      } else if (device.type == frame.DeviceType.tablet) {
        sizeValue = sizeTablet ?? size ?? '0';
        unitValue = unitTablet ?? unit;
      } else {
        sizeValue = sizeDesktop ?? size;
        unitValue = unitDesktop ?? unit;
      }
    }

    double? value = 0;
    if (sizeValue == null) {
      return null;
    } else if (sizeValue.toLowerCase() == 'max' ||
        sizeValue.toLowerCase() == 'inf' ||
        sizeValue.toLowerCase() == '100%') {
      return double.maxFinite;
    } else if (sizeValue.toLowerCase() == 'null' ||
        sizeValue.toLowerCase() == 'auto') {
      return null;
    }
    final temp = sizeValue.replaceAll('%', '');
    value = double.tryParse(temp) ?? 0;
    if (sizeValue.contains('%') || unit == SizeUnit.percent) {
      if (forPlay) {
        if (isWidth) {
          return MediaQuery.of(context).size.width * 100 / value;
        } else {
          return MediaQuery.of(context).size.height * 100 / value;
        }
      } else {
        final device = BlocProvider.of<DeviceModeCubit>(context).state;
        if (isWidth) {
          final side = device.type != frame.DeviceType.phone &&
                  device.type != frame.DeviceType.tablet
              ? 1920
              : device.info.screenSize.width;
          return side * (value / 100);
        } else {
          final side = device.type != frame.DeviceType.phone &&
                  device.type != frame.DeviceType.tablet
              ? 1080
              : device.info.screenSize.height;
          return side * (value / 100);
        }
      }
    }
    return value;
  }

  SizeUnit getUnit(final BuildContext context) {
    final device = BlocProvider.of<DeviceModeCubit>(context).state;
    if (device.type == frame.DeviceType.phone) {
      return unit!;
    } else if (device.type == frame.DeviceType.tablet) {
      return unitTablet ?? unit!;
    }
    return unitDesktop ?? unit!;
  }

  void updateSize(
    final String newValue,
    final BuildContext context,
  ) {
    final device = BlocProvider.of<DeviceModeCubit>(context).state;
    if (device.info.identifier.type == frame.DeviceType.phone) {
      size = newValue;
    } else if (device.info.identifier.type == frame.DeviceType.tablet) {
      sizeTablet = newValue;
    } else {
      sizeDesktop = newValue;
    }
  }

  void updateUnit(
    final SizeUnit newUnit,
    final BuildContext context,
  ) {
    final device = BlocProvider.of<DeviceModeCubit>(context).state;
    if (device.type == frame.DeviceType.phone) {
      unit = newUnit;
    } else if (device.type == frame.DeviceType.tablet) {
      unitTablet = newUnit;
    } else {
      unitDesktop = newUnit;
    }
  }

  static FSize fromJson(final Map<String, dynamic> json) {
    try {
      return FSize(
        size: json['s'] as String? ?? '0',
        unit: json['u'] == 'i' ? SizeUnit.pixel : SizeUnit.percent,
        sizeTablet: json['t'] as String? ?? json['s'] as String? ?? '0',
        sizeDesktop: json['d'] as String? ?? json['s'] as String? ?? '0',
        unitTablet: json['ut'] == 'i' || json['u'] == 'i'
            ? SizeUnit.pixel
            : SizeUnit.percent,
        unitDesktop: json['ud'] == 'i' || json['u'] == 'i'
            ? SizeUnit.pixel
            : SizeUnit.percent,
      );
    } catch (e) {
      Logger.printError('Error in FSize fromJson: $e');
      return FSize();
    }
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        's': size ?? '0',
        'u': unit == SizeUnit.percent ? 'e' : 'i',
        't': sizeTablet ?? '0',
        'd': sizeDesktop ?? '0',
        'ut': unitTablet == SizeUnit.percent ? 'e' : 'i',
        'ud': unitDesktop == SizeUnit.percent ? 'e' : 'i',
      };

  static String convertListToCode(final String? value) {
    return value ?? '';
  }

  static String convertTypeToCode(final SizeUnit? unit) {
    if (unit == SizeUnit.pixel) return 'SizeUnit.pixel';
    return 'SizeUnit.percent';
  }

  String? toCode({
    required final BuildContext context,
    required final bool isWidth,
  }) {
    String _valueToCode(final String size, final SizeUnit unit) {
      String? value;
      if (unit == SizeUnit.pixel &&
          (size.toLowerCase() == 'max' ||
              size.toLowerCase() == 'inf' ||
              size.toLowerCase() == '100%')) {
        value = 'double.maxFinite';
      } else if (unit == SizeUnit.percent &&
          (size.toLowerCase() == 'max' ||
              size.toLowerCase() == 'inf' ||
              size.toLowerCase() == '100%')) {
        value = 'double.maxFinite';
      } else {
        if (size.toLowerCase() == 'null' || size.toLowerCase() == 'auto') {
          value = null;
        } else {
          final exp = MathExpression.parse(
            context: context,
            expression: size.replaceAll('%', ''),
          );
          if (double.tryParse(exp) != null) {
            value = size.replaceAll('%', '');
          }
        }
      }
      if (value != null && unit == SizeUnit.percent) {
        if (value != 'double.maxFinite') {
          var finalString = '';
          finalString += '${size.replaceAll('%', '')}${isWidth ? '.w' : '.h'}';
          return finalString;
        }
      }
      return value ?? 'null';
    }

    if (_valueToCode(size!, unit!) ==
            _valueToCode(sizeTablet ?? size!, unitTablet ?? unit!) &&
        _valueToCode(size!, unit!) ==
            _valueToCode(sizeDesktop ?? size!, unitDesktop ?? unit!)) {
      return _valueToCode(size!, unit!);
    }

    return '''
getValueForScreenType<double?>(
  context: context,
  mobile: ${_valueToCode(size!, unit!)},
  tablet: ${_valueToCode(sizeTablet ?? size!, unitTablet ?? unit!)},
  desktop: ${_valueToCode(sizeDesktop ?? size!, unitDesktop ?? unit!)},
)''';
  }

  @override
  String toString() => 'FSize { size: $size, unit: $unit }';
}
