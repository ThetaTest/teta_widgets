// ignore_for_file: public_member_api_docs

import 'package:device_frame/device_frame.dart' as frame;
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/index.dart';

class FFontSize {
  /// Constructor
  FFontSize({
    this.size = 16,
    this.unit = SizeUnit.pixel,
    this.sizeTablet,
    this.sizeDesktop,
  }) {
    sizeTablet ??= size;
    sizeDesktop ??= size;
  }

  /// Value of [size] of [FFontSize]
  double size;
  double? sizeTablet;
  double? sizeDesktop;

  SizeUnit unit;

  /// Get current value of [size]
  double get(final BuildContext context) {
    final device = BlocProvider.of<DeviceModeCubit>(context).state;
    late double size;
    if (device.identifier.type == frame.DeviceType.phone) {
      size = this.size;
    } else if (device.identifier.type == frame.DeviceType.tablet) {
      size = sizeTablet ?? this.size;
    } else {
      size = sizeDesktop ?? this.size;
    }
    if (unit == SizeUnit.pixel) {
      return size;
    }
    if (unit == SizeUnit.width) {
      return size.w;
    }
    if (unit == SizeUnit.height) {
      return size.h;
    }
    return size;
  }

  void update(final double value, final BuildContext context) {
    final device = BlocProvider.of<DeviceModeCubit>(context).state;
    if (device.identifier.type == frame.DeviceType.phone) {
      size = value;
    } else if (device.identifier.type == frame.DeviceType.tablet) {
      sizeTablet = value;
    } else {
      sizeDesktop = value;
    }
  }

  /// Instantiates [FFontSize] from Json
  FFontSize fromJson(final dynamic json) {
    try {
      var size = 16.0;
      if (double.tryParse('$json') != null) {
        size = double.tryParse('$json') ?? 16;
      } else {
        size = double.parse('${json['s']}');
        sizeTablet = double.tryParse('${json['st']}') ?? size;
        sizeDesktop = double.tryParse('${json['sd']}') ?? size;
      }
      return FFontSize(
        size: size,
        sizeTablet: sizeTablet,
        sizeDesktop: sizeDesktop,
        unit: (json is Map<String, dynamic>)
            ? EnumToString.fromString(
                  SizeUnit.values,
                  json['u'] as String? ?? 'pixel',
                ) ??
                SizeUnit.pixel
            : SizeUnit.pixel,
      );
    } catch (e) {
      Logger.printError('$e');
      return this;
    }
  }

  /// Returns double to Json
  Map<String, dynamic> toJson() => <String, dynamic>{
        's': size,
        'st': sizeTablet,
        'sd': sizeDesktop,
        'u': EnumToString.convertToString(unit),
      };

  /// Returns double for code
  String toCode() {
    String _valueToCode(final double size) {
      if (unit == SizeUnit.pixel) {
        return size.toString();
      }
      if (unit == SizeUnit.width) {
        return '$size.w';
      }
      if (unit == SizeUnit.height) {
        return '$size.h';
      }
      return size.toString();
    }

    if (size == (sizeTablet ?? size) && size == (sizeDesktop ?? size)) {
      return _valueToCode(size);
    }

    return '''
getValueForScreenType<double>(
  context: context,
  mobile: ${_valueToCode(size)},
  tablet: ${_valueToCode(sizeTablet ?? size)},
  desktop: ${_valueToCode(sizeDesktop ?? size)},
)''';
  }
}
