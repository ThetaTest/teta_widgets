import 'package:flutter/widgets.dart';
import 'package:teta_widgets/src/elements/code/templates/animations/anim_config_grid.dart';
import 'package:teta_widgets/src/elements/code/templates/animations/anim_config_list.dart';
import 'package:teta_widgets/src/elements/code/templates/animations/fade_in.dart';
import 'package:teta_widgets/src/elements/code/templates/animations/scale.dart';
import 'package:teta_widgets/src/elements/code/templates/animations/slide.dart';
import 'package:teta_widgets/src/elements/code/templates/video.dart';
import 'package:teta_widgets/src/elements/code/templates/visibility.dart';
import 'package:teta_widgets/src/elements/code/templates/web_view_x_template.dart';
import 'package:teta_widgets/src/elements/code/templates/wrap.dart';

///Not sure this will be a thing right now... but it can be usefull to test at
///runtime what default widget code is broken
class RuntimeTest {
  static Future<void> runRuntimeTest(final BuildContext context) async {
    //Animation Config Grid
    await AnimConfigGridCodeTemplate.runtimeTestDefaultCode(context);
    //Animation Config List
    await AnimConfigListCodeTemplate.runtimeTestDefaultCode(context);
    //Fade in Animation
    await FadeInCodeTemplate.runtimeTestDefaultCode(context);
    //Scale Animation
    await ScaleCodeTemplate.runtimeTestDefaultCode(context);
    //Slide Animation
    await SlideCodeTemplate.runtimeTestDefaultCode(context);
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
