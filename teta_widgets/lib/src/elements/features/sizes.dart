// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// Package imports:
import 'package:sizer/sizer.dart';
import 'package:teta_core/src/utils/expression/expression.dart';

enum SizeUnit {
  pixel,
  percent,
  width,
  height,
}

class FSize {
  FSize({
    this.size,
    this.unit,
  });

  String? size;
  SizeUnit? unit;

  static FSize ready() => FSize(size: '0', unit: SizeUnit.pixel);

  double? get({
    required final BuildContext context,
    required final bool isWidth,
  }) {
    double? value = 0;
    if (size != null) {
      if (unit == SizeUnit.pixel &&
          (size!.toLowerCase() == 'max' ||
              size!.toLowerCase() == 'inf' ||
              size!.toLowerCase() == '100%')) {
        value = double.maxFinite;
      } else {
        if (size!.toLowerCase() == 'null' || size!.toLowerCase() == 'auto') {
          value = null;
        } else {
          final exp = MathExpression.parse(
            context: context,
            expression: size!.replaceAll('%', ''),
          );
          if (double.tryParse(exp) != null) {
            value = double.parse(exp);
          }
        }
      }
      if (value != null && unit == SizeUnit.percent) {
        /*final screen =
            BlocProvider.of<DeviceModeCubit>(context).state.screenSize;
        value = isWidth ? screen.width : screen.height * (value / 100);*/
        value = isWidth ? value.w : value.h;
      }
      if (value != null && unit == SizeUnit.width) {
        value = isWidth ? value.w : value.h;
      }
    }
    return value;
  }

  static FSize fromJson(final Map<String, dynamic> json) {
    try {
      return FSize(
        size: json['s'] as String?,
        unit: json['u'] == 'i' ? SizeUnit.pixel : SizeUnit.percent,
      );
    } catch (e) {
      if (kDebugMode) {
        // ignore: avoid_print
        print('Error in FSize fromJson: $e');
      }
      return FSize();
    }
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        's': size,
        'u': unit == SizeUnit.percent ? 'e' : 'i',
      }..removeWhere((final String key, final dynamic value) => value == null);

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
    String? value;
    if (size != null) {
      if (unit == SizeUnit.pixel &&
          (size!.toLowerCase() == 'max' ||
              size!.toLowerCase() == 'inf' ||
              size!.toLowerCase() == '100%')) {
        value = 'double.maxFinite';
      } else {
        if (size!.toLowerCase() == 'null' || size!.toLowerCase() == 'auto') {
          value = null;
        } else {
          final exp = MathExpression.parse(
            context: context,
            expression: size!.replaceAll('%', ''),
          );
          if (double.tryParse(exp) != null) {
            value = size!.replaceAll('%', '');
          }
        }
      }
      if (value != null && unit == SizeUnit.percent) {
        var finalString = '';
        finalString +=
            '${(size ?? '16').replaceAll('%', '')}${isWidth ? '.w' : '.h'}';
        return finalString;
      }
    }
    return value;
  }

  @override
  String toString() => 'FSize { size: $size, unit: $unit }';
}
