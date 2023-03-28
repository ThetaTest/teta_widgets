import '../../../../core/teta_action/action_options/teta_action_params.dart';

import '../../../features/text_type_input.dart';

class TAWebViewNavigateToParams extends TetaActionParams {
  const TAWebViewNavigateToParams({
    required this.stateName,
    required this.url,
  });

  TAWebViewNavigateToParams.empty()
      : stateName = null,
        url = null;

  TAWebViewNavigateToParams.fromJson(final Map<String, dynamic> json)
      : stateName = json['sN'] as String?,
        url = json['vTTI'] != null
            ? FTextTypeInput.fromJson(json['vTTI'] as Map<String, dynamic>)
            : FTextTypeInput();

  final String? stateName;
  final FTextTypeInput? url;

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'sN': stateName,
        'vTTI': url?.toJson(),
      };
}
