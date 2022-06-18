// ignore_for_file: public_member_api_docs

import 'package:enum_to_string/enum_to_string.dart';
import 'package:sizer/sizer.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/index.dart';

class FFontSize {
  /// Constructor
  FFontSize({
    this.size = 16,
    this.unit = SizeUnit.pixel,
  });

  /// Value of [size] of [FFontSize]
  double size;

  SizeUnit unit;

  /// Get current value of [size]
  double get() {
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

  /// Instantiates [FFontSize] from Json
  FFontSize fromJson(final dynamic json) {
    Logger.printWarning('$json');
    Logger.printWarning('${double.tryParse('$json')}');
    try {
      var size = 16.0;
      if (double.tryParse('$json') != null) {
        size = double.tryParse('$json') ?? 16;
      } else {
        size = json['s'] as double? ?? 16;
      }
      return FFontSize(
        size: size,
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
        'u': EnumToString.convertToString(unit),
      };

  /// Returns double for code
  String toCode() {
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
}
