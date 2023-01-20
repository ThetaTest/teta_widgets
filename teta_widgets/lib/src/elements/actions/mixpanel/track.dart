// Flutter imports:
// Package imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

class FAMixpanelTrack {
  static Future action(
    final BuildContext context,
    final FTextTypeInput? supabaseFrom,
    final List<MapElement>? body,
    final List<VariableObject> params,
    final List<VariableObject> states,
    final List<DatasetObject> dataset,
    final int? loop,
  ) async {
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

  static String toCode(
    final BuildContext context,
    final FTextTypeInput? eventName,
    final List<MapElement>? props,
  ) {
    final config =
        (BlocProvider.of<ConfigCubit>(context).state as ConfigStateLoaded)
            .config;
    if (config.mixpanel is MixpanelConfigModelInitialized) {
      //props
      final mapBody = <String, dynamic>{};
      for (final e in props ?? <MapElement>[]) {
        mapBody[e.key] = e.value
            .toCode(
              0,
              resultType: ResultTypeEnum.string,
            )
            .replaceAll("'", '')
            .replaceAll(' ', '');
      }

      final mapBodyString = StringBuffer()..write('{');
      for (final key in mapBody.keys) {
        mapBodyString.write("'$key': '${mapBody[key]}',");
      }
      mapBodyString.write('}');
      final name = eventName?.toCode(
            0,
            resultType: ResultTypeEnum.string,
            defaultValue: '',
          ) ??
          '';
      return '''
        MixpanelService.instance.client.track(
          $name, 
          properties: <String, String>$mapBodyString,
        );
      ''';
    } else {
      return '';
    }
  }
}
