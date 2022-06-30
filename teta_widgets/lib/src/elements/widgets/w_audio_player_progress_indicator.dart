// Flutter imports:
// Package imports:
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:teta_core/teta_core.dart';

// Project imports:
import 'package:teta_widgets/src/elements/index.dart';
import 'package:rxdart/rxdart.dart';

// ignore_for_file: public_member_api_docs

class WAudioPlayerProgressIndicator extends StatefulWidget {
  /// Returns a [WAudioPlayerProgressIndicator] widget in Teta
  const WAudioPlayerProgressIndicator(
    final Key? key, {
    required this.node,
    required this.controller,
    required this.forPlay,
    required this.params,
    required this.states,
    required this.dataset,
    this.child,
    this.loop,
  }) : super(key: key);

  final CNode node;
  final CNode? child;
  final FTextTypeInput controller;
  final bool forPlay;
  final int? loop;

  final List<VariableObject> params;
  final List<VariableObject> states;
  final List<DatasetObject> dataset;

  @override
  State<WAudioPlayerProgressIndicator> createState() =>
      _WAudioPlayerProgressIndicatorState();
}

class _WAudioPlayerProgressIndicatorState
    extends State<WAudioPlayerProgressIndicator> {
  bool isInitialized = false;
  AudioPlayer? audioController;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    final page = BlocProvider.of<FocusPageBloc>(context).state;
    VariableObject? variable;
    if (widget.controller.type == FTextTypeEnum.param) {
      variable = page.params
          .firstWhereOrNull((final e) => e.name == widget.controller.paramName);
    } else {
      variable = page.states
          .firstWhereOrNull((final e) => e.name == widget.controller.stateName);
    }
    if (variable?.audioController != null) {
      setState(() {
        if(variable?.audioController != null){
        audioController = variable?.audioController;
        }
        isInitialized = true;
      });
    }
  }

  @override
  Widget build(final BuildContext context) {
    if (isInitialized) {
      return progressBar();
    } else {
      if (audioController == null) {
        init();
      }
      return const Center(
        child: THeadline3(
          'AudioPlayerProgressIndicator Audio Controller is not initialized, yet.',
        ),
      );
    }
  }

  Widget progressBar() => audioController != null
      ? StreamBuilder<Map<String, Duration>>(
          stream: Rx.combineLatest3<Duration, Duration, Duration?,
                  Map<String, Duration>>(
              audioController!.positionStream,
              audioController!.bufferedPositionStream,
              audioController!.durationStream,
              (
                final Duration position,
                final Duration bufferedPosition,
                final Duration? duration,
              ) =>
                  {
                    'position': position,
                    'bufferedPosition': bufferedPosition,
                    'duration': duration ?? Duration.zero
                  }),
          builder: (final context, final snapshot) {
            final positionData = snapshot.data;
            final duration = positionData?['duration'] ?? Duration.zero;
            final position = positionData?['position'] ?? Duration.zero;
            final bufferedPosition =
                positionData?['bufferedPosition'] ?? Duration.zero;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Slider(
                  max: duration.inSeconds.toDouble(),
                  value: position.inSeconds.toDouble(),
                  onChanged: (final value) {
                    if(audioController == null) {
                      init();
                    }
                    audioController?.seek(Duration(seconds: value.toInt()));
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        position.toString().split('.').first.padLeft(8, '0'),
                        style: const TextStyle(color: Colors.white),
                      ),
                      Text(
                        duration.toString().split('.').first.padLeft(8, '0'),
                        style: const TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                )
              ],
            );
          },
        )
      : const Text('AudioPlayerProgressIndicator Controller is null.');
}
