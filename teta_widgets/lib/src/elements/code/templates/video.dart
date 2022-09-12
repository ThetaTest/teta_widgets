// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';
// Project imports:
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_widgets/src/elements/nodes/enum.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Generates the code for Video widget
class VideoCodeTemplate {
  static Future<String> toCode(
    final BuildContext context,
    final NodeBody body,
    final int? loop,
  ) async {
    final abstract = body.attributes[DBKeys.value] as FTextTypeInput;
    final value = abstract.toCode(loop);
    final startAt = body.attributes[DBKeys.startAt] as int? ?? 0;
    final showControls = body.attributes[DBKeys.showControls] as bool? ?? false;
    final showFullScreen =
        body.attributes[DBKeys.isFullWidth] as bool? ?? false;
    final loopVideo = body.attributes[DBKeys.loopVideo] as bool? ?? false;
    final code = """
  YoutubePlayerIFrame(
    controller: YoutubePlayerController(
      initialVideoId: ${value.contains('widget') ? value : "r$value"},
      params: YoutubePlayerParams(
        startAt: Duration(seconds: $startAt),
        showControls: $showControls,
        showFullscreenButton: $showFullScreen,
        loop: $loopVideo,
      ),
    ),
  )
  """;
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
    return FormatterTest.format(
      await toCode(
        context,
        NodeBody.get(NType.video),
        0,
      ),
    );
  }

  static void testCode() {
    group('Video toCode test', () {
      test(
        'Video: default code',
        () {
          final body = NodeBody.get(NType.video);
          final abstract = body.attributes[DBKeys.value] as FTextTypeInput;
          final value = abstract.toCode(0);
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
      initialVideoId: ${value.contains('widget') ? value : "r$value"},
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
