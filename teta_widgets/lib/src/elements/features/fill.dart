// Flutter imports:
// ignore_for_file: public_member_api_docs, unrelated_type_equality_checks, lines_longer_than_80_chars

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/features/box_fit.dart';

/// Types of a FFill
enum FFillType {
  solid,
  linearGradient,
  radialGradient,
  style,
  image,
  none,
}

/// Make easier including colors, gradients and images in Teta
class FFillElement {
  /// Constructor
  FFillElement({
    required this.color,
    required this.stop,
    this.opacity = 1,
  });

  /// Hex [String] (6 chars)
  String color;

  double? opacity;

  /// [int] value for gradients
  double stop;

  static FFillElement fromJson({required final Map<String, dynamic> json}) {
    return FFillElement(
      color: json['color'] as String,
      stop: double.tryParse('${json['stop']}') ?? 0,
      opacity: (json['opacity'] as num? ?? 1).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'color': color,
        'stop': stop,
        'opacity': opacity,
      };
}

/// Class to use solid colors, gradients, images inside Teta
class FFill {
  /// Constructor
  FFill({
    this.type,
    this.levels,
    this.begin,
    this.end,
    this.center,
    this.radius,
    this.boxFit,
    this.paletteStyle,
  }) {
    levels ??= [FFillElement(color: '000000', stop: 0)];
    type ??= FFillType.solid;
  }

  List<FFillElement>? levels;
  FFillType? type;
  Alignment? begin;
  Alignment? end;
  Alignment? center;
  double? radius;
  FBoxFit? boxFit;
  dynamic paletteStyle;
  AssetFile? file;

  FFill get(final BuildContext context) {
    if (paletteStyle == null) {
      return FFill(
        levels: levels,
        type: type,
        begin: begin,
        end: end,
        center: center,
        radius: radius,
        boxFit: boxFit,
        paletteStyle: paletteStyle,
      );
    } else {
      final isLight = BlocProvider.of<PaletteDarkLightCubit>(context).state;
      PaletteModel? model;
      BlocProvider.of<ColorStylesCubit>(context).state.forEach((final element) {
        if (element.id == paletteStyle) model = element;
        if (element.name == paletteStyle) model = element;
      });
      if (model != null) {
        return isLight ? model!.light! : model!.fill!;
      } else {
        return FFill().ready(FFillType.solid);
      }
    }
  }

  /// Get Hex String value.
  /// Includes PaletteStyle checks.
  /// String is uppercased.
  String getHexColor(final BuildContext context) {
    FFill fill;
    if (paletteStyle == null) {
      fill = FFill(
        levels: levels,
        type: type,
        begin: begin,
        end: end,
        center: center,
        radius: radius,
        boxFit: boxFit,
      );
    } else {
      PaletteModel? model;
      BlocProvider.of<ColorStylesCubit>(context).state.forEach((final element) {
        if (element.id == paletteStyle) model = element;
        if (element.name == paletteStyle) model = element;
      });
      fill = (model != null) ? model!.fill! : FFill().ready(FFillType.solid);
    }
    return fill.levels!.first.color.toUpperCase();
  }

  /// Set of FFill ready to be used
  FFill ready(final FFillType type) {
    if (type == FFillType.none) {
      return FFill(
        levels: [
          FFillElement(
            color: '000000',
            stop: 0,
          ),
        ],
        type: type,
      );
    } else if (type == FFillType.radialGradient) {
      return FFill(
        levels: [
          FFillElement(
            color: 'ffffff',
            stop: 0,
          ),
          FFillElement(
            color: '000000',
            stop: 1,
          ),
        ],
        center: Alignment.center,
        type: type,
        radius: 1,
      );
    } else if (type == FFillType.linearGradient) {
      return FFill(
        levels: [
          FFillElement(
            color: 'ffffff',
            stop: 0,
          ),
          FFillElement(
            color: '000000',
            stop: 1,
          ),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        type: type,
      );
    } else if (type == FFillType.solid) {
      return FFill(
        levels: [
          FFillElement(
            color: '000000',
            stop: 0,
          ),
        ],
        type: type,
      );
    } else {
      return FFill(
        levels: [
          FFillElement(
            color: 'https://source.unsplash.com/random',
            stop: 0,
          ),
        ],
        boxFit: FBoxFit(),
        type: type,
      );
    }
  }

  FFill fromJson(final Map<String, dynamic> json) {
    if (json['pltt'] == null) {
      final levels = <FFillElement>[];
      var type = FFillType.solid;
      Alignment? begin, end, center;
      if (json['l'] != null) {
        for (final e in json['l'] as List<dynamic>) {
          levels.add(FFillElement.fromJson(json: e as Map<String, dynamic>));
        }
      }
      if (json['t'] != null) {
        if (json['t'] == 's') type = FFillType.solid;
        if (json['t'] == 'l') type = FFillType.linearGradient;
        if (json['t'] == 'r') type = FFillType.radialGradient;
        if (json['t'] == 'i') type = FFillType.image;
        if (json['t'] == 'n') type = FFillType.none;
      } else {
        type = FFillType.solid;
      }
      if (json['b'] != null) begin = alignFromJson(json, 'b');
      if (json['e'] != null) end = alignFromJson(json, 'e');
      if (json['c'] != null) center = alignFromJson(json, 'c');
      return FFill(
        levels: levels,
        type: type,
        begin: begin,
        end: end,
        center: center,
        radius: double.tryParse('${json['r']}') ?? 0,
        boxFit: FBoxFit.fromJson(json['bF'] as String),
      );
    } else {
      return FFill(
        paletteStyle: json['pltt'],
      );
    }
  }

  Map<String, dynamic> toJson() {
    if (paletteStyle == null) {
      String? typeString;
      if (type == FFillType.solid) typeString = 's';
      if (type == FFillType.linearGradient) typeString = 'l';
      if (type == FFillType.radialGradient) typeString = 'r';
      if (type == FFillType.image) typeString = 'i';
      if (type == FFillType.none) typeString = 'n';
      final levelsMap = <Map<String, dynamic>>[];
      for (final e in levels!) {
        levelsMap.add(e.toJson());
      }
      return <String, dynamic>{
        'l': levelsMap,
        't': typeString,
        'b': alignToJson(begin),
        'e': alignToJson(end),
        'c': alignToJson(center),
        'r': radius,
        'pltt': paletteStyle,
        'bF': (boxFit != null) ? boxFit!.toJson() : FBoxFit().toJson(),
      }..removeWhere((final String key, final dynamic value) => value == null);
    } else {
      return <String, dynamic>{
        'pltt': paletteStyle,
      };
    }
  }

  Alignment? alignFromJson(final Map<String, dynamic> json, final String key) {
    if (json[key] == 'bC') return Alignment.bottomCenter;
    if (json[key] == 'bL') return Alignment.bottomLeft;
    if (json[key] == 'bR') return Alignment.bottomRight;
    if (json[key] == 'c') return Alignment.center;
    if (json[key] == 'cL') return Alignment.centerLeft;
    if (json[key] == 'cR') return Alignment.centerRight;
    if (json[key] == 'tC') return Alignment.topCenter;
    if (json[key] == 'tL') return Alignment.topLeft;
    if (json[key] == 'tR') return Alignment.topRight;
    return null;
  }

  String? alignToJson(final Alignment? value) {
    if (value == Alignment.bottomCenter) return 'bC';
    if (value == Alignment.bottomLeft) return 'bL';
    if (value == Alignment.bottomRight) return 'bR';
    if (value == Alignment.center) return 'c';
    if (value == Alignment.centerLeft) return 'cL';
    if (value == Alignment.centerRight) return 'cR';
    if (value == Alignment.topCenter) return 'tC';
    if (value == Alignment.topLeft) return 'tL';
    if (value == Alignment.topRight) return 'tR';
    return null;
  }

  String alignToCode(final Alignment? value) {
    if (value == Alignment.bottomCenter) return 'Alignment.bottomCenter';
    if (value == Alignment.bottomLeft) return 'Alignment.bottomLeft';
    if (value == Alignment.bottomRight) return 'Alignment.bottomRight';
    if (value == Alignment.center) return 'Alignment.center';
    if (value == Alignment.centerLeft) return 'Alignment.centerLeft';
    if (value == Alignment.centerRight) return 'Alignment.centerRight';
    if (value == Alignment.topCenter) return 'Alignment.topCenter';
    if (value == Alignment.topLeft) return 'Alignment.topLeft';
    if (value == Alignment.topRight) return 'Alignment.topRight';
    return 'null';
  }

  String typeToCode(final FFillType? type) {
    if (type == FFillType.solid) return 'FFillType.solid';
    if (type == FFillType.linearGradient) return 'FFillType.linearGradient';
    if (type == FFillType.radialGradient) return 'FFillType.radialGradient';
    if (type == FFillType.image) return 'FFillType.image';
    if (type == FFillType.none) return 'FFillType.none';
    return 'null';
  }

  static String? toCode(
    final FFill fill,
    final BuildContext context, {
    final bool? flagConst,
  }) {
    final state = BlocProvider.of<ColorStylesCubit>(context).state;
    PaletteModel? currentPaletteElement;
    if (state.isNotEmpty) {
      for (final e in state) {
        if (e.id == fill.paletteStyle || e.name == fill.paletteStyle) {
          currentPaletteElement = e;
        }
      }
    }

    if (fill.type == FFillType.none) return null;

    if (fill.paletteStyle != null) {
      if (currentPaletteElement != null) {
        return "color: context.watch<ThemeCubit>().state ? TetaThemes.lightTheme['${currentPaletteElement.name}'] as Color : TetaThemes.darkTheme['${currentPaletteElement.name}'] as Color,";
      } else {
        return 'color: Colors.black,';
      }
    }

    if (fill.type == FFillType.solid) {
      return 'color: ${flagConst ?? false ? 'const' : ''} Color(0xFF${fill.getHexColor(context)}).withOpacity(${fill.levels!.first.opacity}),';
    }
    if (fill.type == FFillType.linearGradient) {
      return '''
      gradient: LinearGradient(
        begin: ${fill.begin},
        end: ${fill.end},
        colors: <Color>${fill.levels!.map((final e) => 'Color(0xFF${e.color.toUpperCase()}).withOpacity(${e.opacity})').toList()},
        stops: ${fill.levels!.map((final e) => e.stop).toList()},
      ),''';
    }
    if (fill.type == FFillType.radialGradient) {
      return '''
      gradient: RadialGradient(
        center: ${fill.center},
        radius: ${fill.radius},
        colors: <Color>${fill.levels!.map((final e) => 'Color(0xFF${e.color.toUpperCase()}).withOpacity(${e.opacity})').toList()},
        stops: ${fill.levels!.map((final e) => e.stop).toList()},
      ),''';
    }
    if (fill.type == FFillType.image) {
      return '''
        image: DecorationImage(
          image: NetworkImage(${fill.levels!.first.color}), 
          fit: ${fill.boxFit!.toCode()}
        )
      ''';
    }
    return null;
  }

  static String? toCodeTests(
    final FFill fill,
  ) {
    if (fill.type == FFillType.none) return null;
    if (fill.type == FFillType.solid) {
      return 'color: Color(0xFF${fill.levels!.first.color}).withOpacity(${fill.levels!.first.opacity}),';
    }
    if (fill.type == FFillType.linearGradient) {
      return '''
      gradient: LinearGradient(
        begin: ${fill.begin},
        end: ${fill.end},
        colors: <Color>${fill.levels!.map((final e) => 'Color(0xFF${e.color.toUpperCase()}).withOpacity(${e.opacity})').toList()},
        stops: ${fill.levels!.map((final e) => e.stop).toList()},
      ),''';
    }
    if (fill.type == FFillType.radialGradient) {
      return '''
      gradient: RadialGradient(
        center: ${fill.center},
        radius: ${fill.radius},
        colors: <Color>${fill.levels!.map((final e) => 'Color(0xFF${e.color.toUpperCase()}).withOpacity(${e.opacity})').toList()},
        stops: ${fill.levels!.map((final e) => e.stop).toList()},
      ),''';
    }
    if (fill.type == FFillType.image) {
      return '''
        image: DecorationImage(
          image: NetworkImage('${fill.levels!.first.color}'), 
          fit: ${fill.boxFit!.toCode()}
        ),
      ''';
    }
    return null;
  }

  @override
  String toString() => 'FFill { levels: $levels, type: $type }';
}
