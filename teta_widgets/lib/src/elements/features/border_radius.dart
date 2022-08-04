// Flutter imports:

import 'package:flutter/material.dart';

/// [FBorderRadius] is a set of functions to use [BorderRadius]
/// in widgets in Teta
class FBorderRadius {
  /// Constructor
  FBorderRadius({
    this.radius,
  }) {
    radius ??= [0, 0, 0, 0];
  }

  /// The value of [FBorderRadius], used to display BorderRadius
  List<double>? radius;

  /// Convert [radius] to [BorderRadius]
  BorderRadius get get => BorderRadius.only(
        topLeft: Radius.circular(radius![0]),
        topRight: Radius.circular(radius![1]),
        bottomRight: Radius.circular(radius![2]),
        bottomLeft: Radius.circular(radius![3]),
      );

  /// Instantiate [FBorderRadius] from Json
  static FBorderRadius fromJson(final List<dynamic> json) {
    try {
      return FBorderRadius(
        radius: json.map((final dynamic e) => double.parse('$e')).toList(),
      );
    } catch (e) {
      return FBorderRadius();
    }
  }

  /// Convert [FBorderRadius] to Json
  List<double> toJson() {
    return radius!;
  }

  /// Change the value of [value] (List<double>)
  List<double> update({
    required final List<double> value,
  }) {
    return value;
  }

  /// Convert [FBorderRadius] to code String
  String toCode() =>
      radius![0] == 0 && radius![1] == 0 && radius![2] == 0 && radius![3] == 0
          ? ''
          : '''
    BorderRadius.only(
      topLeft: Radius.circular(${radius![0]}),
      topRight: Radius.circular(${radius![1]}),
      bottomRight: Radius.circular(${radius![2]}),
      bottomLeft: Radius.circular(${radius![3]}),
    )
  ''';
}
