import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_core/teta_core.dart';
import 'package:theta_models/theta_models.dart';
import 'package:teta_front_end/teta_front_end.dart';

import '../../../../core/teta_action/index.dart';
import '../../../../core/teta_widget/index.dart';
import '../../../features/text_type_input.dart';
import 'params.dart';

class TAMixpanelSetUserId extends TetaAction {
  TAMixpanelSetUserId({
    required super.params,
    super.loop,
    super.condition,
    super.delay,
    super.id,
  });

  TAMixpanelSetUserId.fromJson(
    final Map<String, dynamic> json,
  ) : super(
          params: TAMixpanelSetUserIdParams.fromJson(
            json['params'] as Map<String, dynamic>,
          ),
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
  TAMixpanelSetUserIdParams get params =>
      super.params as TAMixpanelSetUserIdParams;

  @override
  TetaActionType get type => TetaActionType.mixpanelSetUserId;

  @override
  Future<void> execute(
    final BuildContext context,
    final TetaWidgetState state, {
    final String? runtimeValue,
  }) async {
    await showDialog<void>(
      context: context,
      builder: (final context) {
        return const AlertDialog(
          title: TAlertTitle('Mixpanel'),
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 20,
          ),
          backgroundColor: Color(0xFF333333),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          content: SizedBox(
            width: 400,
            height: 400,
            child: Text(
              'Mixpanel will be activated in your released app.',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  String getActionCode(
    final BuildContext context,
    final int pageId,
    final int loop,
  ) {
    final configCubit = BlocProvider.of<ConfigCubit>(context);
    ProjectConfigModel? projectConfig;
    if (configCubit.state is ConfigStateLoaded) {
      projectConfig = (configCubit.state as ConfigStateLoaded).config;
    }

    if (projectConfig?.mixpanel is MixpanelConfigModelInitialized) {
      final userId = params.userIdValue?.toCode(
            0,
            resultType: ResultTypeEnum.string,
            defaultValue: '',
          ) ??
          '';
      return '''
        MixpanelService.instance.client.identify($userId);
      ''';
    } else {
      return '';
    }
  }
}
