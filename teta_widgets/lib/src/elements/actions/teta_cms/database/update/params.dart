import 'package:teta_models/teta_models.dart';

import '../../../../../core/teta_action/action_options/teta_action_params.dart';
import '../../../../features/text_type_input.dart';

class TATetaCMSUpdateParams implements TetaActionParams {
  const TATetaCMSUpdateParams({
    required this.documentId,
    required this.collectionId,
    required this.dbData,
  });

  const TATetaCMSUpdateParams.empty()
      : documentId = null,
        collectionId = null,
        dbData = null;

  TATetaCMSUpdateParams.fromJson(final Map<String, dynamic> json)
      : documentId =
            FTextTypeInput.fromJson(json['sFrom'] as Map<String, dynamic>?),
        collectionId = json['cmsCId'] as String?,
        dbData = (json['sData'] as List<dynamic>? ?? <dynamic>[])
            .map(
              (final dynamic e) => MapElement.fromJson(
                e as Map<String, dynamic>,
              ),
            )
            .toList();

  final FTextTypeInput? documentId;
  final String? collectionId;
  final List<MapElement>? dbData;

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'cmsCId': collectionId,
        'sData': dbData?.map((final e) => e.toJson()).toList(),
        'sFrom': documentId?.toJson(),
      };

  TATetaCMSUpdateParams copyWith({
    final FTextTypeInput? documentId,
    final String? collectionId,
    final List<MapElement>? dbData,
  }) {
    return TATetaCMSUpdateParams(
      documentId: documentId ?? this.documentId,
      collectionId: collectionId ?? this.collectionId,
      dbData: dbData ?? this.dbData,
    );
  }
}
