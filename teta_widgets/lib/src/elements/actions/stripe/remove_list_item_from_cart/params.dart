import '../../../../core/teta_action/action_options/teta_action_params.dart';

class TAStripeRemoveProductsListItemFromCartParams extends TetaActionParams {
  const TAStripeRemoveProductsListItemFromCartParams({
    required this.stateName,
  });

  const TAStripeRemoveProductsListItemFromCartParams.empty() : stateName = null;

  TAStripeRemoveProductsListItemFromCartParams.fromJson(
    final Map<String, dynamic> json,
  ) : stateName = json['sN'] as String?;

  final String? stateName;

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'sN': stateName,
      };
}
