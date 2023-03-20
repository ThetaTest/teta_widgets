// ignore_for_file: public_member_api_docs

import 'package:device_frame/device_frame.dart' as frame;
import 'package:enum_to_string/enum_to_string.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/index.dart';
import 'package:teta_front_end/teta_front_end.dart';

class FFontSize extends Equatable {
  /// Constructor
  FFontSize({
    this.size = 16,
    this.unit = SizeUnit.pixel,
    this.sizeTablet = 16,
    this.sizeDesktop = 16,
  });

  /// Value of [size] of [FFontSize]
  double size;
  double sizeTablet;
  double sizeDesktop;

  SizeUnit unit;

  @override
  List<Object?> get props => [
        size,
        sizeTablet,
        sizeDesktop,
        unit,
      ];

  double _getValue(final double value) {
    return size;
  }

  /// Get current value of [size]
  double get(
    final BuildContext context, {
    required final bool forPlay,
  }) {
    if (forPlay) {
      return getValueForScreenType<double>(
        context: context,
        mobile: size,
        tablet: sizeTablet,
        desktop: sizeDesktop,
      );
    } else {
      final device = context.read<DeviceModeCubit>().state;
      if (device.type == frame.DeviceType.phone) {
        return size;
      } else if (device.type == frame.DeviceType.tablet) {
        return sizeTablet;
      } else {
        return sizeDesktop;
      }
    }
  }

  void update(final double value, final BuildContext context) {
    final device = BlocProvider.of<DeviceModeCubit>(context).state;
    if (device.info.identifier.type == frame.DeviceType.phone) {
      size = value;
    } else if (device.info.identifier.type == frame.DeviceType.tablet) {
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
        sizeTablet = size;
        sizeDesktop = size;
      } else {
        size = double.parse('${json['s']}');
        sizeTablet = double.tryParse('${json['st']}') ?? size;
        sizeDesktop = double.tryParse('${json['sd']}') ?? size;
      }
      return FFontSize(
        size: size,
        sizeTablet: sizeTablet,
        sizeDesktop: sizeDesktop,
      );
    } catch (e) {
      Logger.printError('Error fromJson in FFontSize, error: $e');
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

  FFontSize copyWith({
    final double? size,
    final double? sizeTablet,
    final double? sizeDesktop,
  }) {
    return FFontSize(
      size: size ?? this.size,
      sizeTablet: sizeTablet ?? this.sizeTablet,
      sizeDesktop: sizeDesktop ?? this.sizeDesktop,
    );
  }

  /// Returns double for code
  String toCode() {
    String _valueToCode(final double size) {
      return size.toString();
    }

    if (size == sizeTablet && size == sizeDesktop) {
      return _valueToCode(size);
    }

    return '''
getValueForScreenType<double>(
  context: context,
  mobile: ${_valueToCode(size)},
  tablet: ${_valueToCode(sizeTablet)},
  desktop: ${_valueToCode(sizeDesktop)},
)''';
  }
}
