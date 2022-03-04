// Flutter imports:
import 'package:flutter/material.dart';
import 'package:teta_core/src/elements/controls/key_constants.dart';
import 'package:teta_core/src/elements/features/text_type_input.dart';
import 'package:teta_core/src/elements/nodes/node_body.dart';

/// Generates the code for Padding widget
String videoCodeTemplate(
  BuildContext context,
  NodeBody body,
  int? loop,
) {
  final abstract = body.attributes[DBKeys.value] as FTextTypeInput;
  final value = abstract.toCode(loop);
  final startAt = body.attributes[DBKeys.startAt] as int? ?? 0;
  final showControls = body.attributes[DBKeys.showControls] as bool? ?? false;
  final showFullScreen = body.attributes[DBKeys.isFullWidth] as bool? ?? false;
  final loopVideo = body.attributes[DBKeys.loopVideo] as bool? ?? false;
  return """
  YoutubePlayerIFrame(
    controller: YoutubePlayerController(
      initialVideoId: r'''$value''',
      params: YoutubePlayerParams(
        startAt: Duration(seconds: $startAt),
        showControls: $showControls,
        showFullscreenButton: $showFullScreen,
        loop: $loopVideo,
      ),
    ),
  )
  """;
}
