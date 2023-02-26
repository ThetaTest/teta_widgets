// Flutter imports:

import 'package:device_frame/device_frame.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:teta_core/teta_core.dart';

/// [FBorderRadius] is a set of functions to use [BorderRadius]
/// in widgets in Teta
class FBorderRadius extends Equatable {
  /// Constructor
  FBorderRadius({
    this.radius,
    this.radiusTablet,
    this.radiusDesktop,
  }) {
    radius ??= [0, 0, 0, 0];
    radiusTablet ??= radius;
    radiusDesktop ??= radius;
  }

  /// The value of [FBorderRadius], used to display BorderRadius
  List<double>? radius;
  List<double>? radiusTablet;
  List<double>? radiusDesktop;

  @override
  List<Object?> get props => [
        radius,
        radiusTablet,
        radiusDesktop,
      ];

  /// Convert [radius] to [BorderRadius]
  BorderRadius get(
    final BuildContext context, {
    required final bool forPlay,
  }) {
    if (forPlay) {
      return getValueForScreenType(
        context: context,
        mobile: BorderRadius.only(
          topLeft: Radius.circular(radius![0]),
          topRight: Radius.circular(radius![1]),
          bottomRight: Radius.circular(radius![2]),
          bottomLeft: Radius.circular(radius![3]),
        ),
        tablet: BorderRadius.only(
          topLeft: Radius.circular(radiusTablet?[0] ?? radius![0]),
          topRight: Radius.circular(radiusTablet?[1] ?? radius![1]),
          bottomRight: Radius.circular(radiusTablet?[2] ?? radius![2]),
          bottomLeft: Radius.circular(radiusTablet?[3] ?? radius![3]),
        ),
        desktop: BorderRadius.only(
          topLeft: Radius.circular(radiusDesktop?[0] ?? radius![0]),
          topRight: Radius.circular(radiusDesktop?[1] ?? radius![1]),
          bottomRight: Radius.circular(radiusDesktop?[2] ?? radius![2]),
          bottomLeft: Radius.circular(radiusDesktop?[3] ?? radius![3]),
        ),
      );
    } else {
      final device = context.read<DeviceModeCubit>().state;
      if (device.type == DeviceType.phone) {
        return BorderRadius.only(
          topLeft: Radius.circular(radius![0]),
          topRight: Radius.circular(radius![1]),
          bottomRight: Radius.circular(radius![2]),
          bottomLeft: Radius.circular(radius![3]),
        );
      } else if (device.type == DeviceType.tablet) {
        return BorderRadius.only(
          topLeft: Radius.circular(radiusTablet?[0] ?? radius![0]),
          topRight: Radius.circular(radiusTablet?[1] ?? radius![1]),
          bottomRight: Radius.circular(radiusTablet?[2] ?? radius![2]),
          bottomLeft: Radius.circular(radiusTablet?[3] ?? radius![3]),
        );
      } else {
        return BorderRadius.only(
          topLeft: Radius.circular(radiusDesktop?[0] ?? radius![0]),
          topRight: Radius.circular(radiusDesktop?[1] ?? radius![1]),
          bottomRight: Radius.circular(radiusDesktop?[2] ?? radius![2]),
          bottomLeft: Radius.circular(radiusDesktop?[3] ?? radius![3]),
        );
      }
    }
  }

  /// Instantiate [FBorderRadius] from Json
  static FBorderRadius fromJson(final dynamic json) {
    if (json is List<dynamic>) {
      return FBorderRadius(
        radius: json.map((final dynamic e) => double.parse('$e')).toList(),
      );
    } else {
      try {
        return FBorderRadius(
          radius: (json['m'] as List<dynamic>)
              .map((final dynamic e) => double.parse('$e'))
              .toList(),
          radiusTablet: (json['t'] as List<dynamic>)
              .map((final dynamic e) => double.parse('$e'))
              .toList(),
          radiusDesktop: (json['d'] as List<dynamic>)
              .map((final dynamic e) => double.parse('$e'))
              .toList(),
        );
      } catch (e) {
        return FBorderRadius();
      }
    }
  }

  /// Convert [FBorderRadius] to Json
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'm': radius,
      't': radiusTablet,
      'd': radiusDesktop,
    };
  }

  /// Change the value of [value] (List<double>)
  Map<String, dynamic> update({
    required final BuildContext context,
    required final List<double> value,
  }) {
    final device = BlocProvider.of<DeviceModeCubit>(context).state;
    if (device.info.identifier.type == DeviceType.phone) {
      radius = value;
    } else if (device.info.identifier.type == DeviceType.tablet) {
      radiusTablet = value;
    } else {
      radiusDesktop = value;
    }
    return toJson();
  }

  String convertValueToCode(final List<double> radius) {
    if (radius[0] == 0 && radius[1] == 0 && radius[2] == 0 && radius[3] == 0) {
      return 'BorderRadius.zero';
    }
    return '''
    BorderRadius.only(
      topLeft: Radius.circular(${radius[0]}),
      topRight: Radius.circular(${radius[1]}),
      bottomRight: Radius.circular(${radius[2]}),
      bottomLeft: Radius.circular(${radius[3]}),
    )''';
  }

  /// Convert [FBorderRadius] to code String
  String toCode() {
    final valueTablet = radiusTablet ?? radius;
    final valueDesktop = radiusDesktop ?? radius;
    if (listEquals(radius, valueTablet) && listEquals(radius, valueDesktop)) {
      return convertValueToCode(radius!);
    }

    return '''
getValueForScreenType<BorderRadius>(
  context: context,
  mobile: ${convertValueToCode(radius!)},
  tablet: ${convertValueToCode(radiusTablet ?? radius!)},
  desktop: ${convertValueToCode(radiusDesktop ?? radius!)},
)
''';
  }
}
