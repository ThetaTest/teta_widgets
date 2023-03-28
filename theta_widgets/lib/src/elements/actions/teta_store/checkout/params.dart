import 'package:teta_widgets/src/core/teta_action/action_options/teta_action_params.dart';

class TATetaStoreCheckoutParams extends TetaActionParams {
  final String? stateName;

  TATetaStoreCheckoutParams({required this.stateName});

  const TATetaStoreCheckoutParams.empty() : stateName = null;

  TATetaStoreCheckoutParams.fromJson(Map<String, dynamic> json)
      : stateName = json['sN'] as String?;

  @override
  Map<String, dynamic> toJson() => {
        'sN': stateName,
      };
}
