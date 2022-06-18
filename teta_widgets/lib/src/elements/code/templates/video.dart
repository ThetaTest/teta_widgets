// Flutter imports:
import 'package:flutter/material.dart';
// Project imports:
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Generates the code for Padding widget
String videoCodeTemplate(
  final BuildContext context,
  final NodeBody body,
  final int? loop,
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
}
