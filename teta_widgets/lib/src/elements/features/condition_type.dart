// Flutter imports:
// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars

import 'package:equatable/equatable.dart';
// Flutter imports:
import 'package:flutter/material.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_models/teta_models.dart';

class FConditionType extends Equatable {
  /// Constructor
  FConditionType({
    this.value = ConditionType.equal,
  });

  /// The value in [ConditionType] of [FConditionType]
  ConditionType? value;

  @override
  List<Object?> get props => [value];

  /// Get a [ConditionType] value
  /// Includes optionality checks
  ConditionType get get => value ?? ConditionType.equal;

  String getString(final BuildContext context) => _convertValueToDropDown(get);

  void set(final String value) => _convertDropDownToValue(value);

  FConditionType fromJson(final String? json) {
    if (json != null) {
      return FConditionType(
        value: _convertJsonToValue(json),
      );
    } else {
      return FConditionType();
    }
  }

  String toJson() => _convertValueToJson(get);

  FConditionType clone() => FConditionType(value: value);

  FConditionType copyWith({final ConditionType? value}) =>
      FConditionType(value: value ?? this.value);

  ConditionType _convertJsonToValue(final String key) {
    switch (key) {
      case 'equal':
        return ConditionType.equal;
      case 'notEqual':
        return ConditionType.notEqual;
      case 'isNull':
        return ConditionType.isNull;
      case 'notNull':
        return ConditionType.notNull;
      case 'greaterThan':
        return ConditionType.greaterThan;
      case 'greaterOrEqualThan':
        return ConditionType.greaterOrEqualThan;
      case 'lessThan':
        return ConditionType.lessThan;
      case 'lessOrEqualThan':
        return ConditionType.lessOrEqualThan;
      case 'contains':
        return ConditionType.contains;
      case 'endsWith':
        return ConditionType.endsWith;
      case 'startsWith':
        return ConditionType.startsWith;
      default:
        return ConditionType.equal;
    }
  }

  String _convertValueToJson(final ConditionType value) {
    switch (value) {
      case ConditionType.equal:
        return 'equal';
      case ConditionType.notEqual:
        return 'notEqual';
      case ConditionType.isNull:
        return 'isNull';
      case ConditionType.notNull:
        return 'notNull';
      case ConditionType.greaterThan:
        return 'greaterThan';
      case ConditionType.greaterOrEqualThan:
        return 'greaterOrEqualThan';
      case ConditionType.lessThan:
        return 'lessThan';
      case ConditionType.lessOrEqualThan:
        return 'lessOrEqualThan';
      case ConditionType.contains:
        return 'contains';
      case ConditionType.startsWith:
        return 'startsWith';
      case ConditionType.endsWith:
        return 'endsWith';
    }
  }

  String _convertValueToDropDown(final ConditionType value) {
    switch (value) {
      case ConditionType.equal:
        return 'Equal';
      case ConditionType.notEqual:
        return 'Not equal';
      case ConditionType.isNull:
        return 'Is null';
      case ConditionType.notNull:
        return 'Not null';
      case ConditionType.greaterThan:
        return 'Greater than';
      case ConditionType.greaterOrEqualThan:
        return 'Greater or equal than';
      case ConditionType.lessThan:
        return 'Less than';
      case ConditionType.lessOrEqualThan:
        return 'Less or equal than';
      case ConditionType.contains:
        return 'Contains';
      case ConditionType.startsWith:
        return 'Starts with';
      case ConditionType.endsWith:
        return 'Ends with';
    }
  }

  void _convertDropDownToValue(final String newValue) {
    switch (newValue) {
      case 'Equal':
        value = ConditionType.equal;
        break;
      case 'Not equal':
        value = ConditionType.notEqual;
        break;
      case 'Is null':
        value = ConditionType.isNull;
        break;
      case 'Not null':
        value = ConditionType.notNull;
        break;
      case 'Greater than':
        value = ConditionType.greaterThan;
        break;
      case 'Greater or equal than':
        value = ConditionType.greaterOrEqualThan;
        break;
      case 'Less than':
        value = ConditionType.lessThan;
        break;
      case 'Less or equal than':
        value = ConditionType.lessOrEqualThan;
        break;
      case 'Contains':
        value = ConditionType.contains;
        break;
      case 'Ends with':
        value = ConditionType.endsWith;
        break;
      case 'Starts with':
        value = ConditionType.startsWith;
        break;
      default:
        value = ConditionType.equal;
        break;
    }
  }
}
