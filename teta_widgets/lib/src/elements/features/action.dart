// Flutter imports:
// Package imports:
// ignore_for_file: public_member_api_docs, must_be_immutable

// Package imports:
import 'package:equatable/equatable.dart';
// Project imports:
import 'package:teta_widgets/src/elements/features/actions/element.dart';

class FAction extends Equatable {
  /// Constructor
  FAction({this.actions}) {
    actions ??= <FActionElement>[];
  }

  /// Instantiate [FAction] object from json
  FAction.fromJson(final Map<String, dynamic> doc) {
    final actions = <FActionElement>[];
    if (doc['acts'] != null) {
      for (final e in doc['acts'] as List<dynamic>) {
        actions.add(FActionElement.fromJson(e as Map<String, dynamic>));
      }
    }
    this.actions = actions;
  }

  /// List of action
  List<FActionElement>? actions;

  /// Transform [FAction] to json
  Map<String, dynamic> toJson() {
    final actionsMap = <Map<String, dynamic>>[];
    for (final e in actions ?? <FActionElement>[]) {
      actionsMap.add(e.toJson());
    }
    return <String, dynamic>{
      'acts': actionsMap,
    }..removeWhere((final String key, final dynamic value) => value == null);
  }

  @override
  String toString() => 'FAction { acts: $actions }';

  @override
  List<Object?> get props => [actions];

  /*String toCode(BuildContext context, CNode node, String value) {
    String actionsString = "";
    if (actions != null) {
      actions!.forEach((element) {
        actionsString += "${element.toCode(context, node)},";
      });
    }
    return """
      FAction(
        actions: [
          $actionsString
        ],
      )
    """;
  }*/
}
