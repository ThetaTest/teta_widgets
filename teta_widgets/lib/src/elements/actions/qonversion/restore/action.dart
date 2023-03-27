import 'package:flutter/material.dart';
import 'package:recase/recase.dart';
import 'package:teta_front_end/teta_front_end.dart';

import '../../../../core/teta_action/index.dart';
import '../../../../core/teta_widget/index.dart';
import '../../snippets/get_page_on_code.dart';
import '../../snippets/take_state_from.dart';
import 'params.dart';

class TAQonversionRestore extends TetaAction {
  TAQonversionRestore({
    required super.params,
    super.loop,
    super.condition,
    super.delay,
    super.id,
  });

  TAQonversionRestore.fromJson(
    final Map<String, dynamic> json,
  ) : super(
          params: TAQonversionRestoreParams.fromJson(
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
  TAQonversionRestoreParams get params =>
      super.params as TAQonversionRestoreParams;

  @override
  TetaActionType get type => TetaActionType.qonversionRestore;

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
          title: TAlertTitle('Qonversion'),
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
              'Qonversion will be activated in your released app.',
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
    if (params.stateName == null) return '';

    final page = getPageOnToCode(pageId, context);
    if (page == null) return '';
    final variable = takeStateFrom(page, params.stateName!);
    if (variable == null) return '';

    final varName = ReCase(params.stateName!).camelCase;

    return '''
    try {
        final Map<String, QPermission> permissions = await Qonversion.restore();
        setState(() {
          $varName = permissions.entries.isNotEmpty ? 'Success' : 'Failed';
        });
      } catch (e) {
        // Error restoring purchases
        print('\$e');
      }
    ''';
  }
}
