// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Teta imports:
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/teta_widgets.dart';
import 'package:teta_widgets/src/elements/packages.dart';

class FActionAlertSnackbar {
  //list of packages needed for this action
  static List<PackageModel> packages = [pAnotherFlushbar, pFeatherIcons];

  static Future action(
    final BuildContext context,
    final List<VariableObject> params,
    final List<VariableObject> states,
    final List<DatasetObject> dataset,
    final int? loop,
    final FTextStyle? textStyle,
    final FTextStyle? textStyle2,
    final FTextTypeInput? snackbarTitle,
    final FTextTypeInput? snackbarMessage,
    final String? icon,
    final bool? addIcon,
    final bool? addTitle,
    final FFill? fill,
    final FFill? fill2,
    final FFill? bgFill,
    final FBorderRadius? borderRadius,
    final FSize? width,
    final String? dropdownItem,
    final String? dropdownItem2,
    final FTextTypeInput? duration,
    final FMargins? margin,
  ) async {
    // //! fill icon color!
    ColorStyleModel? iconModel;
    Color _getIconColor(
      final ColorStyleModel? model,
    ) {
      final tempOpacity = fill?.levels?.first.opacity ?? 1;
      if (iconModel != null) {
        return HexColor(iconModel.fill.levels!.first.color);
      } else {
        return HexColor(fill!.levels!.first.color).withOpacity(tempOpacity);
      }
    }

    TextStyleModel? model;
    final titleTextStyle = textStyle?.get(
      context,
      true,
      model,
    );
    final messageTextStyle = textStyle2?.get(
      context,
      true,
      model,
    );
    final snackBarTitle =
        snackbarTitle?.get(params, states, dataset, true, loop, context) ?? '';
    final snackBarMessage =
        snackbarMessage?.get(params, states, dataset, true, loop, context) ??
            '';

    final iconS = icon != null
        ? Icon(
            FeatherIconsMap[icon],
            size: 28.0,
            color: _getIconColor(
              iconModel,
            ),
          )
        : null;

    FlushbarStyle flushbarStyle = FlushbarStyle.FLOATING;
    switch (dropdownItem) {
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
    FlushbarPosition flushbarPosition = FlushbarPosition.BOTTOM;
    switch (dropdownItem2) {
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
      margin: margin?.get(context, forPlay: true) ?? const EdgeInsets.all(0),
      borderRadius: borderRadius?.get(context, forPlay: true),
      flushbarStyle: flushbarStyle,
      flushbarPosition: flushbarPosition,
      backgroundColor: HexColor(fill2!.levels!.first.color),
      maxWidth: width?.get(
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
      duration: duration != null
          ? Duration(
              milliseconds: int.tryParse(
                    duration.get(
                      params,
                      states,
                      dataset,
                      true,
                      loop,
                      context,
                    ),
                  ) ??
                  3000,
            )
          : Duration(seconds: 3),
      icon: (addIcon != null)
          ? addIcon == true
              ? iconS
              : null
          : null,
    ).show(context);
  }

  static String toCode(
    final BuildContext context,
    final int? loop,
    final FTextStyle? textStyle,
    final FTextStyle? textStyle2,
    final FTextTypeInput? snackbarTitle,
    final FTextTypeInput? snackbarMessage,
    final String? icon,
    final bool? addIcon,
    final bool? addTitle,
    final FFill? fill,
    final FFill? fill2,
    final FFill? bgFill,
    final FBorderRadius? borderRadius,
    final FSize? width,
    final String? dropdownItem,
    final String? dropdownItem2,
    final FTextTypeInput? duration,
    final FMargins? margin,
  ) {
    
    final textStyleX = textStyle != null ? textStyle.toCode(context) : null;
    final textStyle2X = textStyle2 != null ? textStyle2.toCode(context) : null;

    final snackbarTitleX = snackbarTitle != null
        ? snackbarTitle.toCode(
            loop,
            resultType: ResultTypeEnum.string,
            defaultValue: '',
          )
        : null;

    final snackbarMessageX = (snackbarMessage as FTextTypeInput).toCode(
      loop,
      resultType: ResultTypeEnum.string,
      defaultValue: '',
    );
    final fillX = fill != null
        ? FFill.toCode(
            fill as FFill,
            context,
            flagConst: false,
          )
        : null;
    final fill2X = fill2 != null
        ? FFill.toCode(
            fill2 as FFill,
            context,
            flagConst: false,
          )?.replaceAll('color:', '')
        : null;
    final borderRadiusX = borderRadius != null ? borderRadius.toCode() : null;
    final withX =
        width != null ? width.toCode(context: context, isWidth: true) : null;
    final durationeX = duration != null
        ? duration.toCode(loop, resultType: ResultTypeEnum.int)
        : null;
    final marginX = margin != null ? margin.toCode(context) : null;

    FlushbarStyle flushbarStyle = FlushbarStyle.FLOATING;
    switch (dropdownItem) {
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
    FlushbarPosition flushbarPosition = FlushbarPosition.BOTTOM;
    switch (dropdownItem2) {
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
    String snackbarText = '''
''';
    if ((addTitle != null && addTitle == true) && snackbarTitleX != null) {
      snackbarText = '''titleText:Text(
      $snackbarTitleX,
      $textStyleX
    ),''';
    }

    var iconX = '''
''';
    if (addIcon != null && addIcon == true) {
      iconX = '''
    icon: Icon (
      FeatherIconsMap['$icon'],
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
