import '../../../../core/teta_action/action_options/teta_action_params.dart';

class TAStripeBuyAllCartParams extends TetaActionParams {
  const TAStripeBuyAllCartParams({
    required this.stateName,
    required this.email,
    required this.phone,
    required this.city,
    required this.state,
    required this.line,
    required this.postalCode,
    required this.country,
    required this.shippingId,
  });

  const TAStripeBuyAllCartParams.empty()
      : stateName = null,
        email = '',
        phone = '',
        city = '',
        state = '',
        line = '',
        postalCode = '',
        country = '',
        shippingId = '';

  TAStripeBuyAllCartParams.fromJson(final Map<String, dynamic> json)
      : stateName = json['sN'] as String?,
        email = json['stripeBillingInfoEmail'] as String,
        phone = json['stripeBillingInfoPhone'] as String,
        city = json['stripeBillingInfoCity'] as String,
        state = json['stripeBillingInfoState'] as String,
        line = json['stripeBillingInfoLine'] as String,
        postalCode = json['stripeBillingInfoPostalCode'] as String,
        country = json['stripeBillingInfoCountry'] as String,
        shippingId = json['stripeShippingId'] as String;

  final String? stateName;
  final String email;
  final String phone;
  final String city;
  final String state;
  final String line;
  final String postalCode;
  final String country;
  final String shippingId;

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'sN': stateName,
        'stripeBillingInfoPhone': phone,
        'stripeBillingInfoEmail': email,
        'stripeBillingInfoCity': city,
        'stripeBillingInfoState': state,
        'stripeBillingInfoLine': line,
        'stripeBillingInfoPostalCode': postalCode,
        'stripeBillingInfoCountry': country,
        'stripeShippingId': shippingId,
      };
}
