import 'package:dart_airtable/dart_airtable.dart';
import 'package:flutter/widgets.dart';
import 'package:teta_core/teta_core.dart';

import '../../core/teta_action/teta_action.dart';
import '../../core/teta_action/teta_action_executor.dart';
import '../../core/teta_action/teta_action_factory.dart';
import '../../core/teta_widget/teta_widget_state.dart';
import 'actions/enums/gestures.dart';

class _ActionGestureElement {
  const _ActionGestureElement({
    required this.gesture,
    required this.action,
  });

  final ActionGesture gesture;
  final TetaAction action;
}

class NodeGestureActions {
  NodeGestureActions.empty() : actions = <_ActionGestureElement>[];

  NodeGestureActions._(this.actions);

  factory NodeGestureActions.fromJson(
    final Map<String, dynamic> json,
  ) {
    final acts = (json['acts'] as List<dynamic>).cast<Map<String, dynamic>>();
    final actions = <_ActionGestureElement>[];

    for (final jsonAction in acts) {
      late final ActionGesture gesture;
      late final TetaAction? action;

      if (jsonAction.containsKey('action') &&
          jsonAction.containsKey('gesture')) {
        gesture = ActionGesture.values.firstWhere(
          (final e) => e.gestureName == jsonAction['gesture'],
        );
        action = TetaActionFactory.fromJson(
          jsonAction['action'] as Map<String, dynamic>,
        );
      } else {
        // Legacy actions support
        gesture = ActionGesture.values.firstWhere(
          (final e) =>
              e.gestureName.toLowerCase() ==
              (jsonAction['g'] as String).toLowerCase(),
        );
        action = TetaActionFactory.fromJson(jsonAction, legacyAction: true);
      }

      if (action != null) {
        actions.add(_ActionGestureElement(gesture: gesture, action: action));
      }
    }

    return NodeGestureActions._(actions);
  }

  /// The list of actions.
  final List<_ActionGestureElement> actions;

  /// Adds the given action with the given gesture.
  void add(final ActionGesture gesture, final TetaAction action) =>
      actions.add(_ActionGestureElement(gesture: gesture, action: action));

  /// Replaces the given action with the new one.
  void replace(final TetaAction newAction, final TetaAction oldAction) {
    final index = actions.indexWhere((final e) => e.action.id == oldAction.id);

    if (index != -1) {
      actions[index] = _ActionGestureElement(
        gesture: actions[index].gesture,
        action: newAction,
      );
    }
  }

  void deleteAction(final String id) =>
      actions.removeWhere((final e) => e.action.id == id);

  /// Executes all the actions associated with the given gesture.
  Future<void> execute(
    final BuildContext context,
    final ActionGesture gesture,
    final TetaWidgetState state,
    final String? dynamicValue,
  ) async {
    for (final actionElement in actions.where((e) => e.gesture == gesture)) {
      await TetaActionExecutor.executeAction(
        context,
        actionElement.action,
        state,
        dynamicValue,
      );
      Logger.printSuccess(
        'Action ${actionElement.action.type} '
        'with id ${actionElement.action.id} executed',
      );
    }
  }

  /// Returns the code for the action with the given gesture.
  String toCode(
    final BuildContext context,
    final ActionGesture gesture,
    final int pageId,
    final int loop,
  ) {
    final actionGestureElement = actions.firstWhereOrNull(
      (final e) => e.gesture == gesture,
    );

    return actionGestureElement?.action.toCode(context, pageId, loop) ?? '';
  }

  /// Returns the json object for the current [NodeGestureActions] instance.
  Map<String, dynamic> toJson() => <String, dynamic>{
        'acts': actions
            .map(
              (final e) => {
                'gesture': e.gesture.gestureName,
                'action': e.action.toJson(),
              },
            )
            .toList()
      };

  @override
  String toString() => 'FAction: ${toJson()}';
}
