import '../state_validator_params.dart';

class TAStatePhoneValidatorParams extends StateValidatorParams {
  TAStatePhoneValidatorParams({
    required super.stateName,
    required super.stateName2,
  });

  TAStatePhoneValidatorParams.empty()
      : super(stateName: null, stateName2: null);

  TAStatePhoneValidatorParams.fromJson(final Map<String, dynamic> json)
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
