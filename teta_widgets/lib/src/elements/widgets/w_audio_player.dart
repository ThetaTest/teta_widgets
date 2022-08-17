// Flutter imports:
// Package imports:
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';

// ignore_for_file: public_member_api_docs

class WAudioPlayer extends StatefulWidget {
  /// Returns a [WAudioPlayer] widget in Teta
  const WAudioPlayer(
    final Key? key, {
    required this.node,
    required this.controller,
    required this.forPlay,
    required this.params,
    required this.states,
    required this.dataset,
    required this.selectedDataset,
    this.child,
    this.loop,
  }) : super(key: key);

  final CNode node;
  final CNode? child;
  final FTextTypeInput controller;
  final bool forPlay;
  final int? loop;
  final FDataset selectedDataset;
  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

  @override
  State<WAudioPlayer> createState() => _WAudioPlayerState();
}

class _WAudioPlayerState extends State<WAudioPlayer> {
  bool isInitialized = false;
  AudioPlayer? ap;
  VariableObject? variable;
  DatasetObject _map = DatasetObject(
    name: '',
    map: [<String, dynamic>{}],
  );

  Future<void> initAudioPlayer() async {
    try {
      final page = BlocProvider.of<FocusPageBloc>(context).state;

      _map = DatasetObject(
        name: widget.node.name ?? widget.node.intrinsicState.displayName,
        map: [<String, dynamic>{}],
      );

      if (widget.controller.type == FTextTypeEnum.param) {
        variable = page.params.firstWhereOrNull(
          (final e) => e.name == widget.controller.paramName,
        );
      } else {
        variable = page.states.firstWhereOrNull(
          (final e) => e.name == widget.controller.stateName,
        );
      }
      await variable?.audioController?.dispose();

      variable?.audioController = AudioPlayer();

      final audioPlayer = variable!.audioController!;

      final audioList = <AudioSource>[];

      final audioPlayerDataset = widget.dataset
          .firstWhere(
            (final element) =>
                element.getName == widget.selectedDataset.datasetName,
          )
          .getMap;
      for (final element in audioPlayerDataset) {
        final url =
            element['${widget.selectedDataset.datasetAttrName}'] as String?;
        if (url != null) {
          audioList.add(
            AudioSource.uri(Uri.parse(url)),
          );
        }
      }
      // Add list to audioPlayer
      final playlist = ConcatenatingAudioSource(
        // Customise the shuffle algorithm
        shuffleOrder: DefaultShuffleOrder(),
        // Specify the playlist items
        children: audioList,
      );

      await audioPlayer.setShuffleModeEnabled(false);

      await audioPlayer.setAudioSource(
        playlist,
        initialIndex: 0,
        initialPosition: Duration.zero,
        preload: false,
      );

      setState(() {
        ap = audioPlayer;
        isInitialized = true;
      });
    } catch (e) {
      print('WAudioPlayer.initAudioPlayer.error -> $e');
      throw Exception(e);
    }
  }

  @override
  void initState() {
    super.initState();
    initAudioPlayer();
  }

  @override
  Widget build(final BuildContext context) {
    if (isInitialized && ap != null) {
      return StreamBuilder(
        stream: ap!.currentIndexStream,
        builder: (final context, final snapshot) {
          if (!snapshot.hasData) {
            // has data is negative
            _map = _map.copyWith(
              name: widget.node.name ?? widget.node.intrinsicState.displayName,
              map: [
                <String, dynamic>{
                  'is playing': ap!.playing.toString(),
                },
              ],
            );
          } else {
            _map = _map.copyWith(
              name: widget.node.name ?? widget.node.intrinsicState.displayName,
              map: [
                <String, dynamic>{
                  ...getCurrentSongAttribute(),
                },
              ],
            );
          }
          final datasets = addDataset(context, widget.dataset, _map);

          return ChildConditionBuilder(
            ValueKey('${widget.node.nid} ${widget.loop}'),
            name: widget.node.intrinsicState.displayName,
            node: widget.node,
            child: widget.child,
            params: widget.params,
            states: widget.states,
            dataset: widget.dataset.isEmpty ? datasets : widget.dataset,
            forPlay: widget.forPlay,
            loop: widget.loop,
          );
        },
      );
    } else {
      if (ap == null) {
        initAudioPlayer();
      }
      return const THeadline3(
        'AudioPlayerWidget Audio Controller is not initialized, yet. Or Audio Player is null.',
      );
    }
  }

  Map<String, dynamic> getCurrentSongAttribute() {
    final audioPlayerDataset = widget.dataset.firstWhere(
      (final element) => element.getName == widget.selectedDataset.datasetName,
    );
    return audioPlayerDataset
        .getMap[variable?.audioController?.currentIndex ?? 0];
  }
}
