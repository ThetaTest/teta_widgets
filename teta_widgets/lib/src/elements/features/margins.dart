// Flutter imports:
// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars

// Flutter imports:
import 'package:device_frame/device_frame.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// Package imports:
import 'package:teta_core/src/utils/expression/expression.dart';
import 'package:teta_core/teta_core.dart';

class FMargins {
  FMargins({
    this.margins,
  }) {
    margins ??= ['0', '0', '0', '0'];
  }

  List<String>? margins;
  List<String>? marginsTablet;
  List<String>? marginsDesktop;

  EdgeInsets get(final BuildContext context) {
    var temp = marginsDesktop!;
    final device = BlocProvider.of<DeviceModeCubit>(context).state;
    if (device.identifier.type == DeviceType.phone) {
      temp = margins!;
    } else if (device.identifier.type == DeviceType.tablet) {
      temp = marginsTablet!;
    }
    final left = MathExpression.parse(context: context, expression: temp[0]);
    final top = MathExpression.parse(context: context, expression: temp[1]);
    final right = MathExpression.parse(context: context, expression: temp[2]);
    final bottom = MathExpression.parse(context: context, expression: temp[3]);
    return EdgeInsets.only(
      left: double.tryParse(left) != null ? double.parse(left).abs() : 0,
      top: double.tryParse(top) != null ? double.parse(top).abs() : 0,
      right: double.tryParse(right) != null ? double.parse(right).abs() : 0,
      bottom: double.tryParse(bottom) != null ? double.parse(bottom).abs() : 0,
    );
  }

  List<String> getList(final BuildContext context) {
    final device = BlocProvider.of<DeviceModeCubit>(context).state;
    if (device.identifier.type == DeviceType.phone) {
      return margins!;
    } else if (device.identifier.type == DeviceType.tablet) {
      return marginsTablet!;
    } else {
      return marginsDesktop!;
    }
  }

  static FMargins fromJson(final List<dynamic> json) {
    try {
      return FMargins(
        margins: json.map((final dynamic e) => '$e').toList(),
      );
    } catch (e) {
      return FMargins();
    }
  }

  List<String> toJson() {
    return margins!;
  }

  List<String> update({
    required final List<String> value,
    required final BuildContext context,
  }) {
    return value;
  }

  static String convertToCode(final List<String>? list) {
    return '["${list?[0]}","${list?[1]}","${list?[2]}","${list?[3]}"]';
  }

  String toCode(final BuildContext context) {
    final left =
        MathExpression.parse(context: context, expression: margins![0]);
    final top = MathExpression.parse(context: context, expression: margins![1]);
    final right =
        MathExpression.parse(context: context, expression: margins![2]);
    final bottom =
        MathExpression.parse(context: context, expression: margins![3]);
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
      ${double.tryParse(left) != null && double.tryParse(left) != 0 ? "left: ${double.parse(margins![0]).abs()}," : ""}
      ${double.tryParse(top) != null && double.tryParse(top) != 0 ? "top: ${double.parse(margins![1]).abs()}," : ""}
      ${double.tryParse(right) != null && double.tryParse(right) != 0 ? "right: ${double.parse(margins![2]).abs()}," : ""}
      ${double.tryParse(bottom) != null && double.tryParse(bottom) != 0 ? "bottom: ${double.parse(margins![3]).abs()}," : ""}
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
