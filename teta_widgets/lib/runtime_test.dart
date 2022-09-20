import 'package:flutter/widgets.dart';
import 'package:teta_widgets/src/elements/code/templates/video.dart';
import 'package:teta_widgets/src/elements/code/templates/visibility.dart';
import 'package:teta_widgets/src/elements/code/templates/web_view_x_template.dart';
import 'package:teta_widgets/src/elements/code/templates/wrap.dart';

///Not sure this will be a thing right now... but it can be usefull to test at
///runtime what default widget code is broken
class RuntimeTest {
  static Future<void> runRuntimeTest(final BuildContext context) async {
    //Tooltip
    // await TooltipCodeTemplate.runtimeTestDefaultCode(context);
    //Video
    await VideoCodeTemplate.runtimeTestDefaultCode(context);
    //Visibility
    await VisibilityCodeTemplate.runtimeTestDefaultCode(context);
    //WebView
    await WebViewXTemplate.runtimeTestDefaultCode(context);
    //Wrap
    await WrapCodeTemplate.runtimeTestDefaultCode(context);
  }
}
