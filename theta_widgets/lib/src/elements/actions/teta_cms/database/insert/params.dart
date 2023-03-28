import 'package:theta_models/theta_models.dart';

import '../../../../../core/teta_action/action_options/teta_action_params.dart';

class TATetaCMSInsertParams implements TetaActionParams {
  const TATetaCMSInsertParams({
    required this.collectionId,
    required this.dbData,
  });

  const TATetaCMSInsertParams.empty()
      : collectionId = null,
        dbData = null;

  TATetaCMSInsertParams.fromJson(final Map<String, dynamic> json)
      : collectionId = json['cmsCId'] as String?,
        dbData = (json['sData'] as List<dynamic>? ?? <dynamic>[])
            .map(
              (final dynamic e) => MapElement.fromJson(
                e as Map<String, dynamic>,
              ),
            )
            .toList();

  final String? collectionId;
  final List<MapElement>? dbData;

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'cmsCId': collectionId,
        'sData': dbData?.map((final e) => e.toJson()).toList(),
      };

  TATetaCMSInsertParams copyWith({
    final String? collectionId,
    final List<MapElement>? dbData,
  }) {
    return TATetaCMSInsertParams(
      collectionId: collectionId ?? this.collectionId,
      dbData: dbData ?? this.dbData,
    );
  }
}
