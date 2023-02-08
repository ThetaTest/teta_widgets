// Flutter imports:
// ignore_for_file: public_member_api_docs

// Package imports:
import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
// Flutter imports:
import 'package:flutter/material.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/core/teta_widget/index.dart';
import 'package:teta_widgets/src/elements/index.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class WVideo extends StatefulWidget {
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
  State<WVideo> createState() => _WVideoState();
}

class _WVideoState extends State<WVideo> with AfterLayoutMixin {
  late final YoutubePlayerController controller;
  @override
  FutureOr<void> afterFirstLayout(final BuildContext context) {
    setState(() {
      controller = YoutubePlayerController(
        initialVideoId: widget.value.get(
          widget.state.params,
          widget.state.states,
          widget.state.dataset,
          widget.state.forPlay,
          widget.state.loop,
          context,
        ),
        params: YoutubePlayerParams(
          startAt: Duration(seconds: widget.startAt),
          showControls: widget.showControls,
          showFullscreenButton: widget.showFullScreen,
          loop: widget.loopVideo,
        ),
      );
    });
  }

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

    return TetaWidget(
      state: widget.state,
      child: YoutubePlayerIFrame(
        controller: controller,
      ),
    );
  }
}
