import 'package:flutter/widgets.dart';
import 'package:uuid/uuid.dart';

import '../../elements/actions/condition.dart';
import '../../elements/actions/delay.dart';
import '../../elements/actions/loop.dart';
import '../teta_widget/index.dart';
import 'action_options/teta_action_condition.dart';
import 'action_options/teta_action_loop.dart';
import 'action_options/teta_action_params.dart';
import 'action_types/types.dart';

abstract class TetaAction {
  /// Creates a new [TetaAction] instance.
  TetaAction({
    required this.params,
    this.loop,
    this.condition,
    this.delay = 0,
    final String? id,
  }) : id = id ?? const Uuid().v4();

  final String id;
  final TetaActionParams params;
  final TetaActionCondition? condition;
  final TetaActionLoop? loop;
  final int delay;

  /// Returns the [TetaActionType] of this [TetaAction].
  TetaActionType get type;

  /// Executes this [TetaAction].
  Future<void> execute(
    final BuildContext context,
    final TetaWidgetState state, {
    final String? runtimeValue,
  });

  /// Returns the Flutter code of this [TetaAction].
  /// For example, the code of Airtable delete action is:
  /// ```
  /// context<AirtableCubit>.read().delete(
  ///  recordName: $airtableRecordNameCode,
  ///  record: $record,
  /// );
  /// ```
  /// NOTE: This method does NOT apply the [FCondition], [FDelay] and [FLoop].
  /// It directly executes the action.
  @protected
  String getActionCode(
    final BuildContext context,
    final int pageId,
    final int loop,
  );

  /// Converts this [TetaAction] into a <String, dynamic> map.
  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'type': type.toString(),
        'params': params.toJson(),
        'loop': loop?.toJson(),
        'condition': condition?.toJson(),
        'delay': delay,
      };

  /// Converts this [TetaAction] into Flutter code.
  /// This method applies the [FCondition], [FDelay] and [FLoop] to the action.
  String toCode(final BuildContext context, final int pageId, final int loop) {
    return FCondition.toCode(
      condition?.condition,
      condition?.valueOfCondition,
      FDelay.toCode(delay) +
          FLoop.toCode(
            this.loop != null ? this.loop!.interval : 0,
            getActionCode(context, pageId, loop),
            withLoop: this.loop != null,
          ),
      withCondition: condition != null,
    );
  }
}
