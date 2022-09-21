import 'package:flutter/widgets.dart';
import 'package:teta_widgets/src/elements/code/templates/ad_mob_banner_ad_template.dart';
import 'package:teta_widgets/src/elements/code/templates/align.dart';
import 'package:teta_widgets/src/elements/code/templates/animations/anim_config_grid.dart';
import 'package:teta_widgets/src/elements/code/templates/animations/anim_config_list.dart';
import 'package:teta_widgets/src/elements/code/templates/animations/fade_in.dart';
import 'package:teta_widgets/src/elements/code/templates/animations/scale.dart';
import 'package:teta_widgets/src/elements/code/templates/animations/slide.dart';
import 'package:teta_widgets/src/elements/code/templates/aspect_ratio.dart';
import 'package:teta_widgets/src/elements/code/templates/badge.dart';
import 'package:teta_widgets/src/elements/code/templates/card.dart';
import 'package:teta_widgets/src/elements/code/templates/checkbox.dart';
import 'package:teta_widgets/src/elements/code/templates/circular_progress_indicator.dart';
import 'package:teta_widgets/src/elements/code/templates/column.dart';
import 'package:teta_widgets/src/elements/code/templates/container.dart';
import 'package:teta_widgets/src/elements/code/templates/decoratedbox.dart';
import 'package:teta_widgets/src/elements/code/templates/future_builder.dart';
import 'package:teta_widgets/src/elements/code/templates/stream_builder.dart';
import 'package:teta_widgets/src/elements/code/templates/video.dart';
import 'package:teta_widgets/src/elements/code/templates/visibility.dart';
import 'package:teta_widgets/src/elements/code/templates/web_view_x_template.dart';
import 'package:teta_widgets/src/elements/code/templates/wrap.dart';

///Not sure this will be a thing right now... but it can be usefull to test at
///runtime what default widget code is broken
class RuntimeTest {
  static Future<void> runRuntimeTest(final BuildContext context) async {
    //AdMob
    await AdMobBannerAdTemplate.runtimeTestDefaultCode(context);
    //Align
    await AlignCodeTemplate.runtimeTestDefaultCode(context);
    //Animation Config Grid
    await AnimConfigGridCodeTemplate.runtimeTestDefaultCode(context);
    //Animation Config List
    await AnimConfigListCodeTemplate.runtimeTestDefaultCode(context);
    //AspectRatio
    await AspectRatioCodeTemplate.runtimeTestDefaultCode(context);
    //so the problem is that we run this tests
    //Badge
    await BadgeCodeTemplate.runtimeTestDefaultCode(context);
    //Card
    await CardCodeTemplate.runtimeTestDefaultCode(context);
    //Checkbox
    await CheckBoxCodeTemplate.runtimeTestDefaultCode(context);
    //CircularProgressIndicator
    await CircularProgressIndicatorCodeTemplate.runtimeTestDefaultCode(context);
    //Column
    await ColumnCodeTemplate.runtimeTestDefaultCode(context);
    //Container
    await ContainerCodeTemplate.runtimeTestDefaultCode(context);
    //DecoratedBox
    await DecoratedBoxCodeTemplate.runtimeTestDefaultCode(context);
    //Fade in Animation
    await FadeInCodeTemplate.runtimeTestDefaultCode(context);
    //Supabase Future Builder
    await SupabaseFutureBuilderCodeTemplate.runtimeTestDefaultCode(context);
    //Supabase Stream Builder
    await StreamBuilderCodeTemplate.runtimeTestDefaultCode(context);
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
