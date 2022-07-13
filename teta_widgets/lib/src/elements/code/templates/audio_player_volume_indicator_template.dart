// Flutter imports:
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Generates the code for Align widget
class AudioPlayerVolumeIndicatorTemplate {
  static String toCode({
    required final BuildContext context,
    required final String audioPlayerName,
  }) {

    return '''
StreamBuilder<Map<String, Object>>(
        stream: Rx.combineLatest3<Duration, Duration, double,
                Map<String, Object>>(
            ${audioPlayerName}!.positionStream,
            ${audioPlayerName}!.bufferedPositionStream,
            ${audioPlayerName}!.volumeStream,
            (final Duration position, final Duration bufferedPosition,
                    final double volume,) =>
                {
                  'position': position,
                  'bufferedPosition': bufferedPosition,
                  'volume': volume
                }),
        builder: (final context, final snapshot) {
          final positionData = snapshot.data;
          final volume =
              positionData?['volume'] ?? 0.5;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Slider(
                  min: 0,
                  max: 1,
                  value: volume as double,
                  onChanged: (final value) {
                    ${audioPlayerName}!.setVolume(value);
                  }),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Icon(Icons.volume_off, color: Colors.white,),
                    Icon(Icons.volume_up_rounded, color: Colors.white,)
                  ],
                ),
              )
            ],
          );
        },
      )
''';
  }
}
