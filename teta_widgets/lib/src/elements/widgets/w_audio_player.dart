// Flutter imports:
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:teta_core/teta_core.dart';
// Project imports:
import 'package:teta_widgets/src/core/teta_widget/teta_widget_state.dart';
import 'package:teta_widgets/src/elements/builder/gesture_detector_base.dart';
import 'package:teta_widgets/src/elements/index.dart';

// ignore_for_file: public_member_api_docs

class WAudioPlayer extends StatefulWidget {
  /// Returns a [WAudioPlayer] widget in Teta
  const WAudioPlayer(
    final Key? key, {
    required this.state,
    required this.controller,
    required this.selectedDataset,
    this.child,
  }) : super(key: key);

  final TetaWidgetState state;
  final CNode? child;
  final FTextTypeInput controller;
  final FDataset selectedDataset;

  @override
  State<WAudioPlayer> createState() => _WAudioPlayerState();
}

class _WAudioPlayerState extends State<WAudioPlayer> {
  bool isInitialized = false;
  AudioPlayer? ap;
  VariableObject? variable;
  DatasetObject _map = const DatasetObject(
    name: '',
    map: [<String, dynamic>{}],
  );

  Future<void> initAudioPlayer() async {
    try {
      final page = BlocProvider.of<PageCubit>(context).state as PageLoaded;

      _map = DatasetObject(
        name: widget.state.node.name ??
            widget.state.node.intrinsicState.displayName,
        map: const [<String, dynamic>{}],
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

      variable = variable!.copyWith(
        audioController: AudioPlayer(),
      );

      final audioPlayer = variable!.audioController!;

      final audioList = <AudioSource>[];

      final audioPlayerDataset = widget.state.dataset
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

      if (mounted) {
        setState(() {
          ap = audioPlayer;
          isInitialized = true;
        });
        // BlocProvider.of<RefreshCubit>(context).change();
      }
    } catch (e) {
      Logger.printError('WAudioPlayer.initAudioPlayer.error -> $e');
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
      return GestureBuilderBase.get(
        context: context,
        state: widget.state,
        child: StreamBuilder(
          stream: ap!.currentIndexStream,
          builder: (final context, final snapshot) {
            if (!snapshot.hasData) {
              // has data is negative
              _map = _map.copyWith(
                name: widget.state.node.name ??
                    widget.state.node.intrinsicState.displayName,
                map: [
                  <String, dynamic>{
                    'is playing': ap!.playing.toString(),
                  },
                ],
              );
            } else {
              _map = _map.copyWith(
                name: widget.state.node.name ??
                    widget.state.node.intrinsicState.displayName,
                map: [
                  <String, dynamic>{
                    ...getCurrentSongAttribute(),
                  },
                ],
              );
            }
            final datasets = addDataset(context, _map);
            return ChildConditionBuilder(
              ValueKey('${widget.state.node.nid} ${widget.state.loop}'),
              state: widget.state.copyWith(
                dataset: widget.state.dataset.isEmpty
                    ? datasets
                    : widget.state.dataset,
              ),
              child: widget.child,
            );
          },
        ),
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
    final audioPlayerDataset = widget.state.dataset.firstWhere(
      (final element) => element.getName == widget.selectedDataset.datasetName,
    );
    return audioPlayerDataset
        .getMap[variable?.audioController?.currentIndex ?? 0];
  }
}
