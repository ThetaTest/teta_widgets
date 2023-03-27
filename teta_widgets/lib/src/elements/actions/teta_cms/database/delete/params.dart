import '../../../../../core/teta_action/action_options/teta_action_params.dart';
import '../../../../features/text_type_input.dart';

class TATetaCMSDeleteParams implements TetaActionParams {
  const TATetaCMSDeleteParams({
    required this.documentId,
    required this.collectionId,
  });

  const TATetaCMSDeleteParams.empty()
      : documentId = null,
        collectionId = null;

  TATetaCMSDeleteParams.fromJson(final Map<String, dynamic> json)
      : documentId =
            FTextTypeInput.fromJson(json['sFrom'] as Map<String, dynamic>?),
        collectionId = json['cmsCId'] as String?;

  final FTextTypeInput? documentId;
  final String? collectionId;

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'cmsCId': collectionId,
        'sFrom': documentId?.toJson(),
      };

  TATetaCMSDeleteParams copyWith({
    final FTextTypeInput? documentId,
    final String? collectionId,
  }) {
    return TATetaCMSDeleteParams(
      documentId: documentId ?? this.documentId,
      collectionId: collectionId ?? this.collectionId,
    );
  }
}
