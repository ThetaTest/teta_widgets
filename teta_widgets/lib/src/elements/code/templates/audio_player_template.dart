// Flutter imports:
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

// Project imports:
import 'package:teta_widgets/src/elements/code/snippets.dart';
import 'package:teta_widgets/src/elements/nodes/node.dart';
import 'package:teta_widgets/src/elements/nodes/node_body.dart';

/// Generates the code for Align widget
class AudioPlayerTemplate {
  static String toCode({
    required final BuildContext context,
    required final NodeBody body,
    required final CNode? child,
    required final String songsDataSetToCode,
    required final String urlKey,
    required final String audioPlayerName,
    required final String currentSongDatasetName,
  }) {
    return '''
    FutureBuilder<bool>(
      future: Future.delayed(Duration(milliseconds: 0), () async {
                            if(audioController!.currentIndex == null) {

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

                        audioController?.currentIndexStream.listen((
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
            ${CS.child(context, child, comma: true)}
        );
      },
    )
  ''';
  }
}
