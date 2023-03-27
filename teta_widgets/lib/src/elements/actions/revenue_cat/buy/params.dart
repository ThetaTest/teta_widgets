import '../../../../core/teta_action/action_options/teta_action_params.dart';

import '../../../features/text_type_input.dart';

class TARevenueCatBuyParams extends TetaActionParams {
  const TARevenueCatBuyParams({
    required this.productIdentifier,
    required this.stateName,
  });

  const TARevenueCatBuyParams.empty()
      : productIdentifier = null,
        stateName = null;

  TARevenueCatBuyParams.fromJson(final Map<String, dynamic> json)
      : productIdentifier = FTextTypeInput.fromJson(
          json['revenueCatProdId'] as Map<String, dynamic>?,
        ),
        stateName = json['sN'] as String?;

  final FTextTypeInput? productIdentifier;
  final String? stateName;

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'revenueCatProdId': productIdentifier?.toJson(),
        'sN': stateName,
      };
}
