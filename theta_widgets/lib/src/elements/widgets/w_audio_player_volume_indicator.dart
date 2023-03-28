// Flutter imports:
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
// Package imports:
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:theta_models/theta_models.dart';
// Project imports:
import 'package:theta_widgets/src/core/teta_widget/teta_widget_state.dart';
import 'package:theta_widgets/src/elements/builder/gesture_detector_base.dart';
import 'package:theta_widgets/src/elements/index.dart';
import 'package:teta_front_end/teta_front_end.dart';

// ignore_for_file: public_member_api_docs

class WAudioPlayerVolumeIndicator extends StatefulWidget {
  /// Returns a [WAudioPlayerVolumeIndicator] widget in Teta
  const WAudioPlayerVolumeIndicator(
    final Key? key, {
    required this.state,
    required this.controller,
    this.child,
  }) : super(key: key);

  final TetaWidgetState state;
  final CNode? child;
  final FTextTypeInput controller;

  @override
  State<WAudioPlayerVolumeIndicator> createState() =>
      _WAudioPlayerVolumeIndicatorState();
}

class _WAudioPlayerVolumeIndicatorState
    extends State<WAudioPlayerVolumeIndicator> {
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
      if (mounted) {
        setState(() {
          audioController = variable?.audioController;
          isInitialized = true;
        });
      }
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
          'AudioPlayerVolumeIndicator Audio Controller is not initialized, yet.',
        ),
      );
    }
  }

  Widget progressBar() => audioController != null
      ? GestureBuilderBase.get(
          context: context,
          state: widget.state,
          child: StreamBuilder<Map<String, Object>>(
            stream: Rx.combineLatest3<Duration, Duration, double,
                Map<String, Object>>(
              audioController!.positionStream,
              audioController!.bufferedPositionStream,
              audioController!.volumeStream,
              (
                final Duration position,
                final Duration bufferedPosition,
                final double volume,
              ) =>
                  {
                'position': position,
                'bufferedPosition': bufferedPosition,
                'volume': volume,
              },
            ),
            builder: (final context, final snapshot) {
              final positionData = snapshot.data;
              final volume = positionData?['volume'] ?? 0.5;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Slider(
                    value: volume as double,
                    onChanged: (final value) {
                      audioController!.setVolume(value);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Icon(
                          Icons.volume_off,
                          color: Colors.white,
                        ),
                        Icon(
                          Icons.volume_up_rounded,
                          color: Colors.white,
                        )
                      ],
                    ),
                  )
                ],
              );
            },
          ),
        )
      : const Text('AudioPlayerVolumeIndicator Controller is null.');
}
