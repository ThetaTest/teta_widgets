import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../../core/teta_action/index.dart';
import '../../../../core/teta_widget/index.dart';
import 'params.dart';

class TANavigationOpenDrawer extends TetaAction {
  TANavigationOpenDrawer({
    required super.params,
    super.loop,
    super.condition,
    super.delay,
    super.id,
  });

  TANavigationOpenDrawer.fromJson(
    final Map<String, dynamic> json,
  ) : super(
          params: const TANavigationOpenDrawerParams(),
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
  TANavigationOpenDrawerParams get params =>
      super.params as TANavigationOpenDrawerParams;

  @override
  TetaActionType get type => TetaActionType.navigationOpenDrawer;

  @override
  Future<void> execute(
    final BuildContext context,
    final TetaWidgetState state, {
    final String? runtimeValue,
  }) async {
    print(Scaffold.of(context).hasDrawer);
    if (!Scaffold.of(context).isDrawerOpen) Scaffold.of(context).openDrawer();
  }

  @override
  String getActionCode(
    final BuildContext context,
    final int pageId,
    final int loop,
  ) {
    return '''
    if (_scaffoldKey.currentState != null) {
      _scaffoldKey.currentState!.openDrawer();
    }
    ''';
  }
}
