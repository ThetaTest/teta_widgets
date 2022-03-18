// Flutter imports:
// ignore_for_file: public_member_api_docs

// Package imports:
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
// Flutter imports:
import 'package:flutter/material.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class WVideo extends StatelessWidget {
  /// Returns a Video widget in Teta
  const WVideo(
    final Key? key, {
    required this.node,
    required this.value,
    required this.startAt,
    required this.showControls,
    required this.showFullScreen,
    required this.forPlay,
    required this.params,
    required this.states,
    required this.loopVideo,
    required this.dataset,
    this.loop,
  }) : super(key: key);

  final CNode node;
  final FTextTypeInput value;
  final int startAt;
  final bool showControls;
  final bool showFullScreen;
  final bool loopVideo;
  final bool forPlay;
  final int? loop;

  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

  @override
  Widget build(final BuildContext context) {
    return NodeSelectionBuilder(
      node: node,
      forPlay: forPlay,
      child: _body(context),
    );
  }

  Widget _body(final BuildContext context) {
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
      initialVideoId: value.get(params, states, dataset, forPlay, loop),
      params: YoutubePlayerParams(
        startAt: Duration(seconds: startAt),
        showControls: showControls,
        showFullscreenButton: showFullScreen,
        loop: loopVideo,
      ),
    );
    return forPlay
        ? YoutubePlayerIFrame(
            controller: controller,
          )
        : AspectRatio(
            aspectRatio: 16 / 9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.play_arrow,
                  size: 48,
                  color: Colors.white,
                ),
                THeadline3(
                  'Play to watch',
                ),
              ],
            ),
          );
  }
}
