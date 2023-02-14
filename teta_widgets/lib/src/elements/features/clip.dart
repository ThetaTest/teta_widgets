// Flutter imports:
// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

/// [FClip] is a set of functions to save use Clip within Teta
class FClip extends Equatable {
  /// Constructor
  const FClip({
    this.clip = Clip.hardEdge,
  });

  /// The value in [Clip] of [FClip]
  final Clip? clip;

  @override
  List<Object?> get props => [clip];

  /// Get a [Clip] value
  /// Includes optionality checks
  Clip get get => clip ?? Clip.hardEdge;

  String getStringForDropDown() => _convertValueToDropDown(get);

  FClip setFromString(final String value) {
    return copyWith(clip: _convertDropDownToValue(value));
  }

  FClip fromJson(final String json) {
    try {
      return FClip(
        clip: _convertJsonToValue(json),
      );
    } catch (e) {
      return this;
    }
  }

  String toJson() => _convertValueToJson(get);

  FClip clone() => FClip(clip: clip);

  FClip copyWith({final Clip? clip}) => FClip(clip: clip ?? this.clip);

  Clip _convertJsonToValue(final String key) {
    if (key == 'a') return Clip.antiAlias;
    if (key == 'b') return Clip.antiAliasWithSaveLayer;
    if (key == 'n') return Clip.none;
    return Clip.hardEdge;
  }

  Clip _convertDropDownToValue(final String key) {
    if (key == 'Anti Alias') return Clip.antiAlias;
    if (key == 'Anti Alias With Save Layer') return Clip.antiAliasWithSaveLayer;
    if (key == 'None') return Clip.none;
    return Clip.hardEdge;
  }

  String _convertValueToDropDown(final Clip key) {
    if (key == Clip.antiAlias) return 'Anti Alias';
    if (key == Clip.antiAliasWithSaveLayer) return 'Anti Alias With Save Layer';
    if (key == Clip.none) return 'None';
    return 'Hard Edge';
  }

  String _convertValueToJson(final Clip value) {
    if (value == Clip.antiAlias) return 'a';
    if (value == Clip.antiAliasWithSaveLayer) return 'b';
    if (value == Clip.none) return 'n';
    return 'h';
  }

  String _convertValueToCode(final Clip value) {
    switch (value) {
      case Clip.antiAlias:
        return 'Clip.antiAlias';
      case Clip.antiAliasWithSaveLayer:
        return 'Clip.antiAliasWithSaveLayer';
      case Clip.none:
        return 'Clip.none';
      case Clip.hardEdge:
        return 'Clip.hardEdge';
    }
  }

  String toCode() => _convertValueToCode(get);

  /*toCode() =>
      "FAlign(aligns: [${convertValueToCode(aligns?[0])},${convertValueToCode(aligns?[1])},${convertValueToCode(aligns?[2])}])";*/
}
