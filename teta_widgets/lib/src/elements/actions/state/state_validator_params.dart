import '../../../core/teta_action/action_options/teta_action_params.dart';

abstract class StateValidatorParams extends TetaActionParams {
  StateValidatorParams({
    required this.stateName,
    required this.stateName2,
  });

  String? stateName;
  String? stateName2;
}
