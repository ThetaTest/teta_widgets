import '../../../../core/teta_action/action_options/teta_action_params.dart';

import '../../../features/text_type_input.dart';

class TAQonversionBuyParams extends TetaActionParams {
  const TAQonversionBuyParams({
    required this.productIdentifier,
    required this.stateName,
  });

  const TAQonversionBuyParams.empty()
      : productIdentifier = null,
        stateName = null;

  TAQonversionBuyParams.fromJson(final Map<String, dynamic> json)
      : productIdentifier = FTextTypeInput.fromJson(
          json['qonversionProdId'] as Map<String, dynamic>?,
        ),
        stateName = json['sN'] as String?;

  final FTextTypeInput? productIdentifier;
  final String? stateName;

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'qonversionProdId': productIdentifier?.toJson(),
        'sN': stateName,
      };
}
