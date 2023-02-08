// Flutter imports:
// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars

// Flutter imports:
import 'package:device_frame/device_frame.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';
// Package imports:
import 'package:teta_core/src/utils/expression/expression.dart';
import 'package:teta_core/teta_core.dart';

class FMargins {
  FMargins({
    this.margins,
    this.marginsTablet,
    this.marginsDesktop,
  }) {
    margins ??= ['0', '0', '0', '0'];
    marginsTablet ??= margins;
    marginsDesktop ??= margins;
  }

  List<String>? margins;
  List<String>? marginsTablet;
  List<String>? marginsDesktop;

  EdgeInsets _getValue(
    final BuildContext context, {
    required final List<String> values,
  }) =>
      EdgeInsets.only(
        left: double.tryParse(values[0]) != null
            ? double.parse(values[0]).abs()
            : 0,
        top: double.tryParse(values[1]) != null
            ? double.parse(values[1]).abs()
            : 0,
        right: double.tryParse(values[2]) != null
            ? double.parse(values[2]).abs()
            : 0,
        bottom: double.tryParse(values[3]) != null
            ? double.parse(values[3]).abs()
            : 0,
      );

  EdgeInsets get(
    final BuildContext context, {
    required final bool forPlay,
  }) =>
      getValueForScreenType<EdgeInsets>(
        context: context,
        mobile: _getValue(context, values: margins!),
        tablet: _getValue(context, values: marginsTablet ?? margins!),
        desktop: _getValue(context, values: marginsDesktop ?? margins!),
      );

  List<String> getList(
    final BuildContext context, {
    required final bool forPlay,
  }) {
    if (forPlay) {
      final width = MediaQuery.of(context).size.width;
      if (width < 600) {
        return margins!;
      } else if (width < 1000) {
        return marginsTablet!;
      } else {
        return marginsDesktop!;
      }
    } else {
      final device = BlocProvider.of<DeviceModeCubit>(context).state;
      if (device.info.identifier.type == DeviceType.phone) {
        return margins!;
      } else if (device.info.identifier.type == DeviceType.tablet) {
        return marginsTablet!;
      } else {
        return marginsDesktop!;
      }
    }
  }

  static FMargins fromJson(final dynamic json) {
    if (json is List<dynamic>) {
      return FMargins(
        margins: json.map((final dynamic e) => '$e').toList(),
      );
    }
    try {
      return FMargins(
        margins: (json['m'] as List<dynamic>)
            .map((final dynamic e) => '$e')
            .toList(),
        marginsTablet: (json['t'] as List<dynamic>)
            .map((final dynamic e) => '$e')
            .toList(),
        marginsDesktop: (json['d'] as List<dynamic>)
            .map((final dynamic e) => '$e')
            .toList(),
      );
    } catch (e) {
      print('Error converting FMargins, error: $e');
      return FMargins();
    }
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'm': margins,
      't': marginsTablet,
      'd': marginsDesktop,
    };
  }

  Map<String, dynamic> update({
    required final List<String> value,
    required final BuildContext context,
  }) {
    final device = BlocProvider.of<DeviceModeCubit>(context).state;
    if (device.info.identifier.type == DeviceType.phone) {
      margins = value;
    } else if (device.info.identifier.type == DeviceType.tablet) {
      marginsTablet = value;
    } else {
      marginsDesktop = value;
    }
    return toJson();
  }

  static String convertToCode(final List<String>? list) {
    return '["${list?[0]}","${list?[1]}","${list?[2]}","${list?[3]}"]';
  }

  String toCode(final BuildContext context) {
    String valueToCode(final List<String> margins) {
      final left =
          MathExpression.parse(context: context, expression: margins[0]);
      final top =
          MathExpression.parse(context: context, expression: margins[1]);
      final right =
          MathExpression.parse(context: context, expression: margins[2]);
      final bottom =
          MathExpression.parse(context: context, expression: margins[3]);
      if (double.tryParse(left) == null &&
          double.tryParse(top) == null &&
          double.tryParse(right) == null &&
          double.tryParse(bottom) == null) return '';
      if (double.tryParse(left) == 0 &&
          double.tryParse(top) == 0 &&
          double.tryParse(right) == 0 &&
          double.tryParse(bottom) == 0) {
        return 'EdgeInsets.zero';
      }
      return '''
    const EdgeInsets.only(
      ${double.tryParse(left) != null && double.tryParse(left) != 0 ? "left: ${double.parse(margins[0]).abs()}," : ""}
      ${double.tryParse(top) != null && double.tryParse(top) != 0 ? "top: ${double.parse(margins[1]).abs()}," : ""}
      ${double.tryParse(right) != null && double.tryParse(right) != 0 ? "right: ${double.parse(margins[2]).abs()}," : ""}
      ${double.tryParse(bottom) != null && double.tryParse(bottom) != 0 ? "bottom: ${double.parse(margins[3]).abs()}," : ""}
    )''';
    }

    if (margins! == (marginsTablet ?? margins!) &&
        margins! == (marginsDesktop ?? margins!)) {
      return valueToCode(margins!);
    }

    return '''
getValueForScreenType<EdgeInsets>(
  context: context,
  mobile: ${valueToCode(margins!)},
  tablet: ${valueToCode(marginsTablet ?? margins!)},
  desktop: ${valueToCode(marginsDesktop ?? margins!)},
)''';
  }

  String toCodeForTests() {
    final left = margins![0];
    final top = margins![1];
    final right = margins![2];
    final bottom = margins![3];

    if (double.tryParse(left) == 0 &&
        double.tryParse(top) == 0 &&
        double.tryParse(right) == 0 &&
        double.tryParse(bottom) == 0) {
      return 'EdgeInsets.zero';
    }
    return '''
    const EdgeInsets.only(
      ${double.tryParse(left) != null && double.tryParse(left) != 0 ? "left: ${double.parse(margins![0]).abs()}," : ""}
      ${double.tryParse(top) != null && double.tryParse(top) != 0 ? "top: ${double.parse(margins![1]).abs()}," : ""}
      ${double.tryParse(right) != null && double.tryParse(right) != 0 ? "right: ${double.parse(margins![2]).abs()}," : ""}
      ${double.tryParse(bottom) != null && double.tryParse(bottom) != 0 ? "bottom: ${double.parse(margins![3]).abs()}," : ""}
    )''';
  }
}
