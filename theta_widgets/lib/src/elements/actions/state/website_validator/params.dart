import '../state_validator_params.dart';

class TAStateWebsiteValidatorParams extends StateValidatorParams {
  TAStateWebsiteValidatorParams({
    required super.stateName,
    required super.stateName2,
  });

  TAStateWebsiteValidatorParams.empty()
      : super(stateName: null, stateName2: null);

  TAStateWebsiteValidatorParams.fromJson(final Map<String, dynamic> json)
      : super(
          stateName: json['sN'] as String?,
          stateName2: json['sN2'] as String?,
        );

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'sN': stateName,
        'sN2': stateName2,
      };
}
