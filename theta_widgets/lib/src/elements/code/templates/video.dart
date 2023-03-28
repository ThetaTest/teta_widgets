// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:teta_core/teta_core.dart';
import 'package:theta_widgets/src/elements/code/formatter_test.dart';
// Project imports:
import 'package:theta_widgets/src/elements/controls/key_constants.dart';
import 'package:theta_widgets/src/elements/features/text_type_input.dart';
import 'package:theta_widgets/src/elements/nodes/enum.dart';
import 'package:theta_widgets/src/elements/nodes/node_body.dart';

/// Generates the code for Video widget
class VideoCodeTemplate {
  static Future<String> toCode(
    final BuildContext context,
    final NodeBody body,
    final int? loop,
  ) async {
    final abstract = body.attributes[DBKeys.value] as FTextTypeInput;
    final value = abstract.toCode(
      loop,
      resultType: ResultTypeEnum.string,
    );
    final startAt = body.attributes[DBKeys.startAt] as int? ?? 0;
    final showControls = body.attributes[DBKeys.showControls] as bool? ?? false;
    final showFullScreen =
        body.attributes[DBKeys.isFullWidth] as bool? ?? false;
    final loopVideo = body.attributes[DBKeys.loopVideo] as bool? ?? false;
    final code = '''
  YoutubePlayerIFrame(
    controller: YoutubePlayerController(
      initialVideoId: $value,
      params: YoutubePlayerParams(
        startAt: Duration(seconds: $startAt),
        showControls: $showControls,
        showFullscreenButton: $showFullScreen,
        loop: $loopVideo,
      ),
    ),
  )
  ''';
    final res = FormatterTest.format(code);
    if (res) {
      return code;
    } else {
      final defaultCode = await toCode(
        context,
        NodeBody.get(NType.video),
        0,
      );
      return defaultCode;
    }
  }

  static Future<bool> runtimeTestDefaultCode(
    final BuildContext context,
  ) async {
    const name = 'Video';
    final nodeBody = NodeBody.get(NType.video);
    final codeToRun = await toCode(
      context,
      nodeBody,
      0,
    );
    final returnValue = FormatterTest.format(
      codeToRun,
    );
    if (!returnValue) {
      Logger.printError(
        'Runtime ToCode Default Error:\n$name\nThis was the code:\n',
      );
      Logger.printWarning(codeToRun);
      Logger.printMessage('\n-----------END-----------');
    } else {
      Logger.printSuccess('$name: Passed!');
    }
    return returnValue;
  }

  static void testCode() {
    group('Video toCode test', () {
      test(
        'Video: default code',
        () {
          final body = NodeBody.get(NType.video);
          final abstract = body.attributes[DBKeys.value] as FTextTypeInput;
          final value = abstract.toCode(
            0,
            resultType: ResultTypeEnum.string,
          );
          final startAt = body.attributes[DBKeys.startAt] as int? ?? 0;
          final showControls =
              body.attributes[DBKeys.showControls] as bool? ?? false;
          final showFullScreen =
              body.attributes[DBKeys.isFullWidth] as bool? ?? false;
          final loopVideo = body.attributes[DBKeys.loopVideo] as bool? ?? false;
          expect(
            FormatterTest.format('''
            YoutubePlayerIFrame(
    controller: YoutubePlayerController(
      initialVideoId: $value,
      params: YoutubePlayerParams(
        startAt: Duration(seconds: $startAt),
        showControls: $showControls,
        showFullscreenButton: $showFullScreen,
        loop: $loopVideo,
      ),
    ),
  )
            '''),
            true,
          );
        },
      );
    });
  }
}
