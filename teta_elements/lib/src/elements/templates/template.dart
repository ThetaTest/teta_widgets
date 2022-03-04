// Package imports:
import 'package:equatable/equatable.dart';

/// This class is for group of nodes
/// e.g. a completed form with textfield, input widgets and button.
//ignore: must_be_immutable
abstract class CTemplate extends Equatable {
  /// Constructor
  CTemplate({
    this.name,
    this.type,
  });

  /// name of the template
  String? name;

  /// type of the template
  String? type;

  @override
  String toString() => 'Default Template { }';

  @override
  List<Object?> get props => [
        name,
      ];

  /// Transform nodes to json
  Map<String, dynamic> toJson() => <String, dynamic>{};
}
