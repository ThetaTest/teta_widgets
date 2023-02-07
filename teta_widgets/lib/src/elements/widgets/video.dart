// Flutter imports:
// ignore_for_file: public_member_api_docs

// Package imports:
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
// Flutter imports:
import 'package:flutter/material.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/core/teta_widget/index.dart';
import 'package:teta_widgets/src/elements/index.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class WVideo extends StatelessWidget {
  /// Returns a Video widget in Teta
  const WVideo(
    final Key? key, {
    required this.state,
    required this.value,
    required this.startAt,
    required this.showControls,
    required this.showFullScreen,
    required this.loopVideo,
  }) : super(key: key);

  final TetaWidgetState state;
  final FTextTypeInput value;
  final int startAt;
  final bool showControls;
  final bool showFullScreen;
  final bool loopVideo;

  @override
  Widget build(final BuildContext context) {
    if (UniversalPlatform.isWindows) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              FluentIcons.warning_24_regular,
              size: 40,
              color: Colors.white,
            ),
            Padding(
              padding: EdgeInsets.only(top: 8),
              child: TParagraph(
                'Sorry, this node is not supported on Windows',
                isCentered: true,
              ),
            ),
          ],
        ),
      );
    }
    final controller = YoutubePlayerController(
      initialVideoId: value.get(
        state.params,
        state.states,
        state.dataset,
        state.forPlay,
        state.loop,
        context,
      ),
      params: YoutubePlayerParams(
        startAt: Duration(seconds: startAt),
        showControls: showControls,
        showFullscreenButton: showFullScreen,
        loop: loopVideo,
      ),
    );
    return TetaWidget(
      state: state,
      child: YoutubePlayerIFrame(
        controller: controller,
      ),
    );
  }
}
