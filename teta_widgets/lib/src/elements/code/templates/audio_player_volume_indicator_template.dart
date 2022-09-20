// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';
import 'package:teta_widgets/src/elements/nodes/enum.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Generates the code for Audio Player Volume Indicator widget
class AudioPlayerVolumeIndicatorTemplate {
  static Future<String> toCode({
    required final BuildContext context,
    required final String audioPlayerName,
  }) async {
    final code = '''
StreamBuilder<Map<String, Object>>(
        stream: Rx.combineLatest3<Duration, Duration, double,
                Map<String, Object>>(
            $audioPlayerName!.positionStream,
            $audioPlayerName!.bufferedPositionStream,
            $audioPlayerName!.volumeStream,
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
                    $audioPlayerName!.setVolume(value);
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
    final res = FormatterTest.format(code);
    if (res) {
      return code;
    } else {
      return 'const SizedBox()';
    }
  }

  static void testCode() {
    group('AudioPlayerVolumeIndicatorTemplate toCode test', () {
      test(
        'AudioPlayerVolumeIndicatorTemplate: default code',
        () {
          final body = NodeBody.get(NType.audioPlayerVolumeIndicator);
          const audioPlayerName = 'Player';
          expect(
            FormatterTest.format('''
              StreamBuilder<Map<String, Object>>(
        stream: Rx.combineLatest3<Duration, Duration, double,
                Map<String, Object>>(
            $audioPlayerName!.positionStream,
            $audioPlayerName!.bufferedPositionStream,
            $audioPlayerName!.volumeStream,
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
                    $audioPlayerName!.setVolume(value);
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
            '''),
            true,
          );
        },
      );
    });
  }
}
