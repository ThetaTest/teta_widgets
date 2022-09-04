// Flutter imports:
import 'package:flutter/material.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';
// Project imports:

/// Generates the code for Align widget
class AudioPlayerProgressIndicatorTemplate {
  static Future<String> toCode({
    required final BuildContext context,
    required final String audioPlayerName,
  }) async {
    final code = '''
    StreamBuilder<Map<String, dynamic>>(
        stream: Rx.combineLatest3<Duration, Duration, Duration?, Map<String, dynamic>>(
            $audioPlayerName!.positionStream,
            $audioPlayerName!.bufferedPositionStream,
            $audioPlayerName!.durationStream,
                (position, bufferedPosition, duration) => {
              'position': position,
              'bufferedPosition': bufferedPosition,
              'duration': duration ?? Duration.zero
            }),
        builder: (context, snapshot) {
          final positionData = snapshot.data;
          final Duration duration = positionData?['duration'] ?? Duration.zero;
          final Duration position = positionData?['position'] ?? Duration.zero;
          final Duration bufferedPosition =
              positionData?['bufferedPosition'] ?? Duration.zero;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Slider.adaptive(
                  min: 0,
                  max: duration.inSeconds.toDouble(),
                  value: position.inSeconds.toDouble(),
                  onChanged: (value) {
                    $audioPlayerName?.seek(Duration(seconds: value.toInt()));
                  }),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('\${position.toString().split('.').first.padLeft(8, "0")}', style: TextStyle(color: Colors.white),),
                    Text('\${duration.toString().split('.').first.padLeft(8, "0")}', style: TextStyle(color: Colors.white),)
                  ],
                ),
              )
            ],
          );
        },
      )
    ''';
    final res = FormatterTest.format(code);
    if (res) {
      return code;
    } else {
      return 'const SizedBox()';
    }
  }
}
