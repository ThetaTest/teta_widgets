import 'package:flutter/material.dart';
import 'package:teta_front_end/teta_front_end.dart';

import '../../../../core/teta_action/index.dart';
import '../../../../core/teta_widget/index.dart';
import '../../../features/text_type_input.dart';
import 'params.dart';

class TANavigationShare extends TetaAction {
  TANavigationShare({
    required super.params,
    super.loop,
    super.condition,
    super.delay,
    super.id,
  });

  TANavigationShare.fromJson(
    final Map<String, dynamic> json,
  ) : super(
          params: TANavigationShareParams.fromJson(
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
  TANavigationShareParams get params => super.params as TANavigationShareParams;

  @override
  TetaActionType get type => TetaActionType.navigationShare;

  @override
  Future<void> execute(
    final BuildContext context,
    final TetaWidgetState state, {
    final String? runtimeValue,
  }) async {
    await showDialog<void>(
      context: context,
      builder: (final context) {
        return AlertDialog(
          title: const TAlertTitle('Share'),
          backgroundColor: Palette.bgDialog,
          content: const TParagraph(
            'Share panel will be activated in your released app.',
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
    if (params.value == null) return '';
    final code = params.value?.toCode(
      loop,
      resultType: ResultTypeEnum.string,
    );
    return '''
    await Share.share($code);
    ''';
  }
}
