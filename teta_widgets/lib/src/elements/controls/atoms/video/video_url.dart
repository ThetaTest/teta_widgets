// Flutter imports:
// ignore_for_file: public_member_api_docs

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teta_core/src/design_system/textfield/textfield.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/controls/key_constants.dart';
import 'package:teta_widgets/src/elements/features/text_type_input.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class VideoUrlControl extends StatefulWidget {
  const VideoUrlControl({
    required this.value,
    required this.callBack,
    final Key? key,
  }) : super(key: key);

  final FTextTypeInput value;
  final Function(FTextTypeInput, FTextTypeInput) callBack;

  @override
  PaddingsState createState() => PaddingsState();
}

class PaddingsState extends State<VideoUrlControl> {
  String? text;
  TextEditingController controller = TextEditingController();
  CNode? tempNode;
  bool errore = false;
  String? urlState;
  YoutubePlayerController? controllerVideo;
  String? tempUrl;

  @override
  void initState() {
    final pageState = BlocProvider.of<PageCubit>(context).state as PageLoaded;
    text = 'https://www.youtube.com/watch?v=${widget.value.get(
      pageState.params,
      pageState.states,
      pageState.datasets,
      false,
      null,
      context,
    )}';
    controller.text = text!;
    urlState = widget.value.get(
      pageState.params,
      pageState.states,
      pageState.datasets,
      false,
      null,
      context,
    );
    final nodes = BlocProvider.of<FocusBloc>(context).state;
    if (nodes.isNotEmpty) {
      controllerVideo = YoutubePlayerController(
        initialVideoId: urlState!,
        params: YoutubePlayerParams(
          startAt: Duration(
            seconds: nodes.first.body.attributes[DBKeys.startAt] as int,
          ),
          showControls:
              nodes.first.body.attributes[DBKeys.showControls] as bool,
          showFullscreenButton:
              nodes.first.body.attributes[DBKeys.isFullWidth] as bool,
          mute: true,
        ),
      );
    }
    super.initState();
  }

  @override
  Widget build(final BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (urlState != '')
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: YoutubePlayerIFrame(
              controller: controllerVideo,
            ),
          ),
        const TParagraph(
          'URL Video',
        ),
        CTextField(
          text: text,
          controller: controller,
          placeholder: 'insert the link',
          callBack: (final value) {
            if (tempUrl == null) {
              tempUrl = value;
            } else if (value != tempUrl) {
              tempUrl = value;
              try {
                final videoId = value.substring(32, 43);

                setState(() {
                  errore = false;
                });

                controllerVideo!.load(videoId);
                final old = widget.value;
                final newValue = widget.value..value = videoId;
                widget.callBack(newValue, old);
              } catch (error) {
                setState(() {
                  errore = true;
                });
                controllerVideo!.load(value);
              }
            }
          },
        ),
        if (errore)
          const TDetailLabel(
            'Error: any video founded',
          ),
      ],
    );
  }
}
