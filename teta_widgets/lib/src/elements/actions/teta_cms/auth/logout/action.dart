import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_cms/teta_cms.dart';
import 'package:teta_core/src/services/track_service.dart';
import 'package:teta_core/teta_core.dart';

import '../../../../../core/teta_action/index.dart';
import '../../../../../core/teta_widget/index.dart';
import 'params.dart';

class TATetaCMSLogout extends TetaAction {
  TATetaCMSLogout({
    required super.params,
    super.loop,
    super.condition,
    super.delay,
    super.id,
  });

  TATetaCMSLogout.fromJson(
    final Map<String, dynamic> json,
  ) : super(
          params: const TATetaCMSLogoutParams.empty(),
          loop: json['loop'] != null
              ? TetaActionLoop.fromJson(json['loop'] as Map<String, dynamic>)
              : null,
          condition: json['condition'] != null
              ? TetaActionCondition.fromJson(
                  json['condition'] as Map<String, dynamic>,
                )
              : null,
          delay: json['delay'] as int? ?? 0,
        );

  @override
  TATetaCMSLogoutParams get params => super.params as TATetaCMSLogoutParams;

  @override
  TetaActionType get type => TetaActionType.tetaCmsAuthLogout;

  @override
  Future<void> execute(
    final BuildContext context,
    final TetaWidgetState state, {
    final String? runtimeValue,
  }) async {
    final prjId = BlocProvider.of<FocusProjectCubit>(context).state!.id;
    TrackService.instance.track(
      eventName: 'Teta Auth: logout in Teta',
      prjId: prjId,
    );
    await TetaCMS.instance.auth.signOut();
  }

  @override
  String getActionCode(
    final BuildContext context,
    final int pageId,
    final int loop,
  ) {
    return '''
      await TetaCMS.instance.auth.signOut();
    ''';
  }
}
