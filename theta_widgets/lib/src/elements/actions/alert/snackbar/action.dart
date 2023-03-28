import 'package:another_flushbar/flushbar.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:teta_front_end/teta_front_end.dart';

// Teta imports:
import 'package:theta_widgets/teta_widgets.dart';
import 'package:theta_widgets/src/elements/packages.dart';
import 'package:theta_models/theta_models.dart';

import '../../../../core/teta_action/index.dart';
import '../../../../core/teta_widget/index.dart';
import '../../../features/index.dart';
import 'params.dart';

class TAAlertSnackbar extends TetaAction {
  TAAlertSnackbar({
    required super.params,
    super.loop,
    super.condition,
    super.delay,
    super.id,
  });

  TAAlertSnackbar.fromJson(
    final Map<String, dynamic> json,
  ) : super(
          params: TAAlertSnackbarParams.fromJson(
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
  TAAlertSnackbarParams get params => super.params as TAAlertSnackbarParams;

  @override
  TetaActionType get type => TetaActionType.alertShowSnackbar;

  @override
  Future<void> execute(
    final BuildContext context,
    final TetaWidgetState state, {
    final String? runtimeValue,
  }) async {
    // //! fill icon color!
    ColorStyleModel? iconModel;
    Color _getIconColor(
      final ColorStyleModel? model,
    ) {
      final tempOpacity = params.fill?.levels?.first.opacity ?? 1;
      if (iconModel != null) {
        return HexColor(iconModel.fill.levels!.first.color);
      } else {
        return HexColor(params.fill!.levels!.first.color)
            .withOpacity(tempOpacity);
      }
    }

    TextStyleModel? model;
    final titleTextStyle = params.textStyle?.get(
      context,
      true,
      model,
    );
    final messageTextStyle = params.textStyle2?.get(
      context,
      true,
      model,
    );
    final snackBarTitle = params.snackbarTitle?.get(
          state.params,
          state.states,
          state.dataset,
          true,
          state.loop,
          context,
        ) ??
        '';
    final snackBarMessage = params.snackbarMessage?.get(
          state.params,
          state.states,
          state.dataset,
          true,
          state.loop,
          context,
        ) ??
        '';

    final iconS = params.icon != null
        ? Icon(
            FeatherIconsMap[params.icon],
            size: 28,
            color: _getIconColor(
              iconModel,
            ),
          )
        : null;

    var flushbarStyle = FlushbarStyle.FLOATING;
    switch (params.dropdownItem) {
      case 'FLOATING':
        flushbarStyle = FlushbarStyle.FLOATING;
        break;
      case 'GROUNDED':
        flushbarStyle = FlushbarStyle.GROUNDED;
        break;
      default:
        flushbarStyle = FlushbarStyle.FLOATING;
        break;
    }
    var flushbarPosition = FlushbarPosition.BOTTOM;
    switch (params.dropdownItem2) {
      case 'BOTTOM':
        flushbarPosition = FlushbarPosition.BOTTOM;
        break;
      case 'TOP':
        flushbarPosition = FlushbarPosition.TOP;
        break;
      default:
        flushbarPosition = FlushbarPosition.BOTTOM;
        break;
    }

    /// Snackbar
    await Flushbar<dynamic>(
      margin:
          params.margin?.get(context, forPlay: true) ?? const EdgeInsets.all(0),
      borderRadius: params.borderRadius?.get(context, forPlay: true),
      flushbarStyle: flushbarStyle,
      flushbarPosition: flushbarPosition,
      backgroundColor: HexColor(params.fill2!.levels!.first.color),
      maxWidth: params.width?.get(
        context: context,
        isWidth: true,
        forPlay: true,
      ),
      titleText: snackBarTitle.isNotEmpty
          ? Text(
              snackBarTitle,
              style: titleTextStyle,
            )
          : null,
      messageText: Text(snackBarMessage, style: messageTextStyle),
      duration: params.duration != null
          ? Duration(
              milliseconds: int.tryParse(
                    params.duration!.get(
                      state.params,
                      state.states,
                      state.dataset,
                      true,
                      state.loop,
                      context,
                    ),
                  ) ??
                  3000,
            )
          : const Duration(seconds: 3),
      icon: (params.addIcon != null)
          ? params.addIcon == true
              ? iconS
              : null
          : null,
    ).show(context);
  }

  @override
  String getActionCode(
    final BuildContext context,
    final int pageId,
    final int loop,
  ) {
    final textStyleX = params.textStyle?.toCode(context);
    final textStyle2X = params.textStyle2?.toCode(context);

    final snackbarTitleX = params.snackbarTitle?.toCode(
      loop,
      resultType: ResultTypeEnum.string,
      defaultValue: '',
    );

    final snackbarMessageX = (params.snackbarMessage as FTextTypeInput).toCode(
      loop,
      resultType: ResultTypeEnum.string,
      defaultValue: '',
    );
    final fillX = params.fill != null
        ? FFill.toCode(
            params.fill!,
            context,
            flagConst: false,
          )
        : null;
    final fill2X = params.fill2 != null
        ? FFill.toCode(
            params.fill2!,
            context,
            flagConst: false,
          )?.replaceAll('color:', '')
        : null;
    final borderRadiusX = params.borderRadius?.toCode();
    final withX = params.width?.toCode(
      context: context,
      isWidth: true,
    );
    final durationeX = params.duration?.toCode(
      loop,
      resultType: ResultTypeEnum.int,
    );
    final marginX = params.margin?.toCode(context);

    var flushbarStyle = FlushbarStyle.FLOATING;
    switch (params.dropdownItem) {
      case 'FLOATING':
        flushbarStyle = FlushbarStyle.FLOATING;
        break;
      case 'GROUNDED':
        flushbarStyle = FlushbarStyle.GROUNDED;
        break;
      default:
        flushbarStyle = FlushbarStyle.FLOATING;
        break;
    }
    var flushbarPosition = FlushbarPosition.BOTTOM;
    switch (params.dropdownItem2) {
      case 'BOTTOM':
        flushbarPosition = FlushbarPosition.BOTTOM;
        break;
      case 'TOP':
        flushbarPosition = FlushbarPosition.TOP;
        break;
      default:
        flushbarPosition = FlushbarPosition.BOTTOM;
        break;
    }
    var snackbarText = '''
''';
    if ((params.addTitle != null && params.addTitle == true) &&
        snackbarTitleX != null) {
      snackbarText = '''titleText:Text(
      $snackbarTitleX,
      $textStyleX
    ),''';
    }

    var iconX = '''
''';
    if (params.addIcon != null && params.addIcon == true) {
      iconX = '''
    icon: Icon (
      FeatherIconsMap['${params.icon}'],
      size: 28.0,
      $fillX
    ),
  ''';
    }

    return '''
    await Flushbar<dynamic>( 
    margin: $marginX,
    borderRadius: $borderRadiusX,
    flushbarStyle: $flushbarStyle,
    flushbarPosition: $flushbarPosition,
    backgroundColor: $fill2X
    maxWidth: $withX,
    $snackbarText
    messageText: Text($snackbarMessageX,$textStyle2X),
    duration: Duration(
              milliseconds: $durationeX,
            ),
    $iconX
    ).show(context);
''';
  }
}
