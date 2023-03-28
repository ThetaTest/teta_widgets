// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:teta_widgets/src/elements/code/formatter_test.dart';
// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/nodes/enum.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Generates the code for Audio Player widget
class AudioPlayerTemplate {
  static Future<String> toCode({
    required final BuildContext context,
    required final NodeBody body,
    required final CNode? child,
    required final String songsDataSetToCode,
    required final String urlKey,
    required final String audioPlayerName,
    required final String currentSongDatasetName,
  }) async {
    final childString = await CS.child(context, child, comma: true);
    final code = '''
    FutureBuilder<bool>(
      future: Future.delayed(Duration(milliseconds: 0), () async {
                            if($audioPlayerName!.currentIndex == null) {

        final List<AudioSource> audioList = [];
        final songsDts = ((datasets['$songsDataSetToCode'] as List<dynamic>?) ?? <dynamic>[]);

        for (final element in ((datasets['$songsDataSetToCode'] as List<dynamic>?) ?? <dynamic>[])) {
           final url = element['$urlKey'] as String?;
           if( url != null) {
           audioList.add(AudioSource.uri(Uri.parse(url)),);
         }
       }

        // Add list to audioPlayer
        final playlist = ConcatenatingAudioSource(
        // Start loading next item just before reaching it
          useLazyPreparation: true,
        // Customise the shuffle algorithm
          shuffleOrder: DefaultShuffleOrder(),
        // Specify the playlist items
          children: audioList,
        );
        await $audioPlayerName?.setShuffleModeEnabled(false);
        await $audioPlayerName?.setAudioSource(playlist, initialIndex: 0, initialPosition: Duration.zero);
        
                                this.datasets['$currentSongDatasetName'] = songsDts;

                        $audioPlayerName?.currentIndexStream.listen((
                            final int? position) {
                          if (position != null && position < songsDts.length) {
                            if (this.index != position) {
                              setState((){
                              this.index = position;
                              });
                            }
                          }
                        });
                        }
        return true;
      }),
      builder: (context, songs) {
        return Container(
            $childString
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
    group('AudioPlayerTemplate toCode test', () {
      test(
        'AudioPlayerTemplate: default code',
        () {
          final body = NodeBody.get(NType.audioPlayer);
          const audioPlayerName = 'Player';
          const childString = 'const SizedBox()';
          expect(
            FormatterTest.format('''
              FutureBuilder<bool>(
      future: Future.delayed(Duration(milliseconds: 0), () async {
                            if($audioPlayerName!.currentIndex == null) {

        final List<AudioSource> audioList = [];
        final songsDts = ((datasets['Songs'] as List<dynamic>?) ?? <dynamic>[]);

        for (final element in ((datasets['Songs'] as List<dynamic>?) ?? <dynamic>[])) {
           final url = element['Song_Url'] as String?;
           if(url != null) {
           audioList.add(AudioSource.uri(Uri.parse(url)),);
         }
       }

        // Add list to audioPlayer
        final playlist = ConcatenatingAudioSource(
        // Start loading next item just before reaching it
          useLazyPreparation: true,
        // Customise the shuffle algorithm
          shuffleOrder: DefaultShuffleOrder(),
        // Specify the playlist items
          children: audioList,
        );
        await $audioPlayerName?.setShuffleModeEnabled(false);
        await $audioPlayerName?.setAudioSource(playlist, initialIndex: 0, initialPosition: Duration.zero);
                                this.datasets['Song'] = songsDts;
                        $audioPlayerName?.currentIndexStream.listen((
                            final int? position) {
                          if (position != null && position < songsDts.length) {
                            if (this.index != position) {
                              setState((){
                              this.index = position;
                              });
                            }
                          }
                        });
                        }
        return true;
      }),
      builder: (context, songs) {
        return Container(
            $childString
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
