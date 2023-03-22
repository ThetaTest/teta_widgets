// Flutter imports:
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
// Package imports:
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:teta_models/teta_models.dart';
import 'package:teta_widgets/src/core/teta_widget/teta_widget_state.dart';
import 'package:teta_widgets/src/elements/builder/gesture_detector_base.dart';
// Project imports:
import 'package:teta_widgets/src/elements/index.dart';
import 'package:teta_front_end/teta_front_end.dart';

// ignore_for_file: public_member_api_docs

class WAudioPlayerProgressIndicator extends StatefulWidget {
  /// Returns a [WAudioPlayerProgressIndicator] widget in Teta
  const WAudioPlayerProgressIndicator(
    final Key? key, {
    required this.state,
    required this.controller,
    this.child,
  }) : super(key: key);

  final TetaWidgetState state;
  final CNode? child;
  final FTextTypeInput controller;

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
    VariableObject? variable;
    if (widget.controller.type == FTextTypeEnum.param) {
      variable = widget.state.params
          .firstWhereOrNull((final e) => e.name == widget.controller.paramName);
    } else {
      variable = widget.state.states
          .firstWhereOrNull((final e) => e.name == widget.controller.stateName);
    }
    if (variable?.audioController != null) {
      setState(() {
        if (variable?.audioController != null) {
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
      ? GestureBuilderBase.get(
          context: context,
          state: widget.state,
          child: StreamBuilder<Map<String, Duration>>(
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
              },
            ),
            builder: (final context, final snapshot) {
              final positionData = snapshot.data;
              final duration = positionData?['duration'] ?? Duration.zero;
              final position = positionData?['position'] ?? Duration.zero;

              //! Declared but not used - commented out
              //! final bufferedPosition = positionData?['bufferedPosition'] ?? Duration.zero;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Slider(
                    max: duration.inSeconds.toDouble(),
                    value: position.inSeconds.toDouble(),
                    onChanged: (final value) {
                      if (audioController == null) {
                        init();
                      }
                      audioController?.seek(Duration(seconds: value.toInt()));
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
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
          ),
        )
      : const Text('AudioPlayerProgressIndicator Controller is null.');
}
