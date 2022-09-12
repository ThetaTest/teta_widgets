import 'package:flutter/widgets.dart';
import 'package:teta_core/teta_core.dart';
import 'package:teta_widgets/src/elements/code/templates/tooltip.dart';
import 'package:teta_widgets/src/elements/code/templates/video.dart';
import 'package:teta_widgets/src/elements/code/templates/visibility.dart';
import 'package:teta_widgets/src/elements/code/templates/web_view_x_template.dart';
import 'package:teta_widgets/src/elements/code/templates/wrap.dart';

///Not sure this will be a thing right now... but it can be usefull to test at
///runtime what default widget code is broken
class RuntimeTest {
  static Future<void> runRuntimeTest(final BuildContext context) async {
    //?Text
    // Logger.printMessage(
    //   'Text: ${await TextCodeTemplate.runtimeTestDefaultCode(context)}',
    // );
    //?TextField
    //Tooltip
    Logger.printMessage(
      'Tooltip: ${await TooltipCodeTemplate.runtimeTestDefaultCode(context)}',
    );
    // //?Twitter
    //Video
    Logger.printMessage(
      'Video: ${await VideoCodeTemplate.runtimeTestDefaultCode(context)}',
    );
    //Visibility
    Logger.printMessage(
      'Visibility: ${await VisibilityCodeTemplate.runtimeTestDefaultCode(context)}',
    );
    //WebView
    Logger.printMessage(
      'WebviewX: ${await WebViewXTemplate.runtimeTestDefaultCode(context)}',
    );
    //Wrap
    Logger.printMessage(
      'Wrap: ${await WrapCodeTemplate.runtimeTestDefaultCode(context)}',
    );
  }
}
