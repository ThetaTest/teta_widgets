import 'package:theta_widgets/src/core/teta_action/action_options/teta_action_params.dart';

import '../../../features/index.dart';

class TAAlertSnackbarParams extends TetaActionParams {
  TAAlertSnackbarParams({
    required this.snackbarTitle,
    required this.snackbarMessage,
    required this.icon,
    required this.addIcon,
    required this.addTitle,
    required this.fill,
    required this.fill2,
    required this.bgFill,
    required this.borderRadius,
    required this.width,
    required this.dropdownItem,
    required this.dropdownItem2,
    required this.duration,
    required this.margin,
    required this.textStyle,
    required this.textStyle2,
  });

  const TAAlertSnackbarParams.empty()
      : snackbarTitle = null,
        snackbarMessage = null,
        icon = null,
        addIcon = null,
        addTitle = null,
        fill = null,
        fill2 = null,
        bgFill = null,
        borderRadius = null,
        width = null,
        dropdownItem = null,
        dropdownItem2 = null,
        duration = null,
        margin = null,
        textStyle = null,
        textStyle2 = null;

  TAAlertSnackbarParams.fromJson(Map<String, dynamic> json)
      : textStyle = FTextStyle.fromJson(
          json['sTxtStl'] as Map<String, dynamic>? ?? {},
        ),
        textStyle2 = FTextStyle.fromJson(
          json['sTxtStl2'] as Map<String, dynamic>? ?? {},
        ),
        fill = FFill().fromJson(
          json['sFill'] as Map<String, dynamic>? ?? {},
        ),
        fill2 = FFill().fromJson(
          json['sFill2'] as Map<String, dynamic>? ?? {},
        ),
        bgFill = FFill().fromJson(
          json['sBgFill'] as Map<String, dynamic>? ?? {},
        ),
        borderRadius = FBorderRadius.fromJson(json['sBrdrR'] as dynamic),
        width = FSize.fromJson(
          json['sWidth'] as Map<String, dynamic>? ?? {},
        ),
        dropdownItem = json['sDrpdownI'] as String?,
        dropdownItem2 = json['sDrpdownI2'] as String?,
        duration = FTextTypeInput.fromJson(
          json['sDuration'] as Map<String, dynamic>?,
        ),
        margin = FMargins.fromJson(json['sMargin'] as dynamic),
        snackbarTitle = FTextTypeInput.fromJson(
          json['sSnackbarTitle'] as Map<String, dynamic>?,
        ),
        snackbarMessage = FTextTypeInput.fromJson(
          json['sSnackbarMessage'] as Map<String, dynamic>?,
        ),
        icon = json['sIcon'] as String?,
        addIcon = json['sAddIcon'] != null
            ? json['sAddIcon'] as bool? ?? false
            : false,
        addTitle = json['sAddTitle'] != null
            ? json['sAddTitle'] as bool? ?? false
            : false;

  final FTextStyle? textStyle;
  final FTextStyle? textStyle2;
  final FTextTypeInput? snackbarTitle;
  final FTextTypeInput? snackbarMessage;
  final String? icon;
  final bool? addIcon;
  final bool? addTitle;
  final FFill? fill;
  final FFill? fill2;
  final FFill? bgFill;
  final FBorderRadius? borderRadius;
  final FSize? width;
  final String? dropdownItem;
  final String? dropdownItem2;
  final FTextTypeInput? duration;
  final FMargins? margin;

  @override
  Map<String, dynamic> toJson() => {
        'sTxtStl': textStyle?.toJson(),
        'sTxtStl2': textStyle2?.toJson(),
        'sSnackbarTitle': snackbarTitle?.toJson(),
        'sSnackbarMessage': snackbarMessage?.toJson(),
        'sIcon': icon,
        'sAddIcon': addIcon,
        'sAddTitle': addTitle,
        'sFill': fill?.toJson(),
        'sFill2': fill2?.toJson(),
        'sBgFill': bgFill?.toJson(),
        'sBrdrR': borderRadius?.toJson(),
        'sWidth': width?.toJson(),
        'sDrpdownI': dropdownItem,
        'sDrpdownI2': dropdownItem2,
        'sDuration': duration?.toJson(),
        'sMargin': margin?.toJson(),
      };
}
